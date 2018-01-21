//
//  EventDayToolsViewController.swift
//  Billetes
//
//  Created by Gayatri Nagarkar on 13/01/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import MessageUI


class EventDayToolsViewController: UIViewController {

    var eventID = 0
    var eventImageURL: String? = nil
    
    var attendeesCheckedIn: Int = 0
    var totalAttendees: Int = 0
    var reloadProgressView: Bool = false

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var checkedInLabel: UILabel!
    @IBOutlet weak var notCheckedInLabel: UILabel!
    @IBOutlet weak var checkInSummaryProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkInSummaryProgressView.clipsToBounds = true
        checkInSummaryProgressView.layer.cornerRadius = 3
        
        // Do any additional setup after loading the view.
        fetchEventDayTools(for: eventID)
        
        // Initiate request to load image.
        DispatchQueue.main.async {
            self.loadEventImage()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Reload progress view if flag is set.
        // This used to update progress after change in manual scan.
        if reloadProgressView {
            reloadProgressView = false
            updateProgress()
        }
    }
    
    @IBAction func scanTicketsTapped(_ sender: Any) {
        
        let codeScannerViewController = storyboard?.instantiateViewController(withIdentifier: "QRCodeScannerViewController") as! QRCodeScannerViewController
        
        navigationController?.pushViewController(codeScannerViewController, animated: true)
    }
    
    @IBAction func manualCheckInTapped(_ sender: Any) {
     
        let manualCheckInViewController = storyboard?.instantiateViewController(withIdentifier: "ManualCheckInViewController") as! ManualCheckInViewController
        manualCheckInViewController.eventID = self.eventID
        manualCheckInViewController.checkinDelegate = self
        navigationController?.pushViewController(manualCheckInViewController, animated: true)
    }
    
    // List remaining Attendees:
    @IBAction func didTapListRemainingAttendees(_ sender: UIButton) {
    }
    
    // Email Remaining Attendees:
    @IBAction func didTapEmailRemainingAttendees(_ sender: UIButton) {
        // Do nothing if all attendees have checked in.
        if self.totalAttendees - self.attendeesCheckedIn == 0 {
            return
        }
        
        // Fetch Attendees:
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let eventsController = EventsController()
        eventsController.getAttendees(for: self.eventID,
        success: { attendees in
            // Filter attendees who have not checked in
            if attendees.count == 0 {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.showAlert(with: "No remaining attendees")
                return
            }
            
            let notCheckedIn = attendees.filter{ (attendee) -> Bool in
                // return true if attendee not checked in and has email address
                return(!attendee.isCheckedIn && !(attendee.email?.isEmpty)!)
            }
            .flatMap{ (attendee) -> String? in
                attendee.email
            }
            
            MBProgressHUD.hide(for: self.view, animated: true)
            self.sendEmail(to: notCheckedIn)
        },
        failure: { (message) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showAlert(with: message)
        })
    }
    
    func fetchEventDayTools(for eventId:Int) -> Void {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let eventsController = EventsController()
        eventsController.getEventDayTools(
            for: eventId,
            success: { (eventDayTools) in
                
                print("eventDayTools: \n", eventDayTools, "\n\n")

                self.eventNameLabel.text = eventDayTools.name
                self.eventLocationLabel.text = eventDayTools.location
                
                let formatter = DateFormatter()
                
                // set the format coming in service
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let dateString = formatter.string(from: eventDayTools.datetime)
                
                // convert string to date
                let date = formatter.date(from: dateString)
                
                //set the date format whhich needs to be displayed
                formatter.dateFormat = "EEEE, MMMM dd, yyyy, hh:mm a"
                
                // convert date to string
                let displayDateString = formatter.string(from: date!)
                
                self.eventDateLabel.text = displayDateString
                
                // Set attendee counts.
                self.attendeesCheckedIn = eventDayTools.checkedIn
                self.totalAttendees = self.attendeesCheckedIn + eventDayTools.notCheckedIn
                
                // Update the Progress
                self.updateProgress()
                
                MBProgressHUD.hide(for: self.view, animated: true)
        },
            failure: { (message) in
          
                MBProgressHUD.hide(for: self.view, animated: true)
        })
        
    }
    
    // Load image using URL passed.
    func loadEventImage() -> Void {
        guard let url = self.eventImageURL else {
            return
        }
        Alamofire.request(url).response { response in
            if let data = response.data, let image = UIImage(data: data){
                self.eventImageView.image = image
            }
            else {
                self.eventImageView.image = UIImage(named: "EventListPlaceHolder")
            }
        }
    }
    
    // Update Progress:
    func updateProgress() {
        // Set values for attendees checkedin, total etc.
        let notCheckedIn = self.totalAttendees - self.attendeesCheckedIn
        
        // Set Labels:
        self.checkedInLabel.text = String(self.attendeesCheckedIn)
        self.notCheckedInLabel.text = String(notCheckedIn)
        
        // Set Progress:
        if self.totalAttendees <= 0 {
            return
        }
        // Compute proportion of attendees against the total attendees.
        let progress = Float(self.attendeesCheckedIn) / Float(self.totalAttendees)
        checkInSummaryProgressView.progress = progress
    }
    
    // Show alert:
    func showAlert(with message: String?) {
        guard let msg = message else {
            return
        }
        let alertView = UIAlertController.init(title: Bundle().displayName,
                                               message: msg,
                                               preferredStyle: UIAlertControllerStyle.alert)
        alertView.addAction(UIAlertAction(title: Constants.kAlert_OK,
                                          style: UIAlertActionStyle.default,
                                          handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
    
    // MARK:- SEND EMAIL:
    //
    // TODO:
    // Max number of email addresses to be checked. Email to be sent to all not checked in recipients.
    func sendEmail(to recipients: [String]) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            //mail.setToRecipients(recipients)
            mail.setBccRecipients(recipients)
            mail.setSubject("Boletos " + self.eventNameLabel.text!)
            present(mail, animated: true)
        }
        else {
            // show failure alert
            self.showAlert(with: "Unable to send email")
        }
    }
}


// MARK:- AttendeeCheckinDelegate
extension EventDayToolsViewController: AttendeeCheckinDelegate {
    
    func didCheckinAttendees(for eventId: Int, attendeeIds: [Int]) {
        
        // Update the Progress values.
        let newCheckins = attendeeIds.count
        if newCheckins <= 0 {
            return
        }
        self.attendeesCheckedIn += newCheckins
        // Set the flag to update progress.
        self.reloadProgressView = true
    }
}


// MARK: - MFMailComposeViewControllerDelegate
extension EventDayToolsViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

