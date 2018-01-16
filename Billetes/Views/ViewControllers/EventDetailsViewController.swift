//
//  EventDetailsViewController.swift
//  Billetes
//
//  Created by Gayatri Nagarkar on 08/01/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class EventDetailsViewController: UIViewController {
    
    var eventID = 0
    var thumbnailURL: String? = nil
    var eventURL: String? = nil
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var ticketsSoldLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var ticketsDetailsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        fetchEventDetails(for: self.eventID)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func eventDayToolsTapped(_ sender: Any) {
        
        let eventDayToolsViewController = storyboard?.instantiateViewController(withIdentifier: Constants.kViewController_EventDayTools) as! EventDayToolsViewController
        
        eventDayToolsViewController.eventID = self.eventID
        if let thumbnailURL = self.thumbnailURL {
            eventDayToolsViewController.eventImageURL = thumbnailURL
        }
        navigationController?.pushViewController(eventDayToolsViewController, animated: true)
    }
    
    @IBAction func openEventInBrowserTapped(_ sender: Any) {
        // Open event URL in browser.
        if let eventURL = self.eventURL, let url = URL(string: eventURL) {
            UIApplication.shared.openURL(url)
        }
    }
    
    func fetchEventDetails(for eventId:Int) -> Void {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let eventsController = EventsController()
        eventsController.getDetails(
            for: eventId,
            success: { (eventDetail) in
                
                print("eventDetail: \n", eventDetail, "\n\n")

                // Save the thumbnail URL.
                if let thumbnailURL = eventDetail.thumbnailURL {
                    self.thumbnailURL = thumbnailURL
                }
                
                // Save the eventURL
                if let eventURL = eventDetail.eventURL {
                    self.eventURL = eventURL
                }
                
                Alamofire.request(eventDetail.thumbnailURL!).response { response in
                    if let data = response.data {
                        let image = UIImage(data: data)
                        self.eventImageView.image = image
                    } else {
                        //TODO: assign no photo image.
                    }
                }
                
                self.eventNameLabel.text = eventDetail.name
                self.eventLocationLabel.text = eventDetail.location
                
                let formatter = DateFormatter()
                
                // set the format coming in service
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let dateString = formatter.string(from: eventDetail.datetime)
                
                // convert string to date
                let date = formatter.date(from: dateString)
                
                //set the date format whhich needs to be displayed
                formatter.dateFormat = "EEEE, MMMM dd, yyyy, hh:mm a"
                
                // convert date to string
                let displayDateString = formatter.string(from: date!)
                
                self.eventDateLabel.text = displayDateString
                self.ticketsSoldLabel.text = String(eventDetail.ticketsSold)
                self.amountLabel.text = String(eventDetail.totalAmount)
                
                // Get difference in number of days from event date.
                let nbrOfDays = self.differenceInDays(with: eventDetail.datetime)
                self.daysLabel.text = String(nbrOfDays)
                
                let detailsString = "Free Admission: $\(eventDetail.freeAdmission) \nSold: \(eventDetail.ticketsSold) / Available: \(eventDetail.ticketsAvailable)* / Active"
                self.ticketsDetailsLabel.text = detailsString
                
                MBProgressHUD.hide(for: self.view, animated: true)
        },
            failure: { (message) in
                MBProgressHUD.hide(for: self.view, animated: true)
        })
    }
    
    
    // Returns difference in terms of number of days for the passed Date with
    // comparison to Today's date.
    func differenceInDays(with date: Date) -> Int {
        let calendar = NSCalendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: Date())
        let date2 = calendar.startOfDay(for: date)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        var nbrOfDays = 0
        guard let difference = components.day else {
            return 0
        }
        nbrOfDays = difference
        if nbrOfDays < 0 {
            nbrOfDays = -nbrOfDays
        }
        return nbrOfDays
    }
    
}
