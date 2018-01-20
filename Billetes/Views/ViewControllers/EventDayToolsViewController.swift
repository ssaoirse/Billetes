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
