//
//  EventsViewController.swift
//  Billetes
//
//  Created by Gayatri Nagarkar on 02/01/18.
//  Copyright © 2018 Gayatri Nagarkar. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

class EventsViewController: BaseMenuViewController {
    
    var upcomingEventsArray:[Event] = []
    var pastEventsArray:[Event] = []
    
    @IBOutlet weak var eventsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var noEventsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.eventsSegmentedControl.setTitleTextAttributes(
            [NSAttributedStringKey.foregroundColor: UIColor.white], for: UIControlState.normal)
        self.eventsSegmentedControl.setTitleTextAttributes(
            [NSAttributedStringKey.foregroundColor: UIColor.white], for: UIControlState.selected)
        
        fetchEvents()
        //fetchAttendees()
        //checkinAttendee()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmententedControlValueChanged(_ sender: Any) {
        
        self.eventsTableView.reloadData()
        self.manageNoDataLabel()
    }
    
    func manageNoDataLabel() -> Void {
        
        if (self.eventsSegmentedControl.selectedSegmentIndex == 0 && self.upcomingEventsArray.count == 0) {
        
            self.noEventsLabel.isHidden = false
        }
        else if (self.eventsSegmentedControl.selectedSegmentIndex == 1 && self.pastEventsArray.count == 0) {
            
            self.noEventsLabel.isHidden = false
        }
        else {
            self.noEventsLabel.isHidden = true
        }
    }
    
    // MARK:- DEBUG CODE REMOVE LATER -
    
    func fetchEvents() -> Void {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let eventsController = EventsController()
        
        eventsController.getEvents(
        success: { upcomingEvents, pastEvents  in
            
            print("Upcoming events: \n", upcomingEvents, "\n\n")
            print("Past events: \n", pastEvents, "\n\n")

            self.upcomingEventsArray = upcomingEvents
            self.pastEventsArray = pastEvents
            
            self.eventsTableView.reloadData()
            self.manageNoDataLabel()
            MBProgressHUD.hide(for: self.view, animated: true)
                
        },
        failure: { (message) in
            if let msg = message {
                MBProgressHUD.hide(for: self.view, animated: true)
                let alertView = UIAlertController.init(title: Bundle().displayName,
                                                      message: msg,
                                                      preferredStyle: UIAlertControllerStyle.alert)
                alertView.addAction(UIAlertAction(title: Constants.kAlert_OK,
                                                  style: UIAlertActionStyle.default,
                                                  handler: nil))
                self.present(alertView, animated: true, completion: nil)
            }
        })
    }
    
    func fetchAttendees() -> Void {
        let eventsController = EventsController()
        eventsController.getAttendees(
            for: 50235,
            success: { (attendees) in
                print("Attendees Count: ",attendees.count)
                print(attendees)
        },
            failure: { (message) in
                
        })
    }
    
    func checkinAttendee() {
        let eventsController = EventsController()
        eventsController.checkinAttendee(
            with: "1032955",
            email: "johnjmaloney@gmail.com",
            status: true,
            completion: { (success, message) in
                
        })
    }
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (self.eventsSegmentedControl.selectedSegmentIndex == 0) {
            
            return upcomingEventsArray.count
        }
        else {
            return pastEventsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kEventCellIdentifier, for: indexPath)
            as! EventsTableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
                
        // configure cell based on selected segment.
        if (self.eventsSegmentedControl.selectedSegmentIndex == 0) {
            cell.configureCell(with: upcomingEventsArray[indexPath.row]);
        }
        else {
            cell.configureCell(with: pastEventsArray[indexPath.row]);
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let eventDetailsViewController = storyboard?.instantiateViewController(withIdentifier: Constants.kViewController_EventDetails) as! EventDetailsViewController
        
        if (self.eventsSegmentedControl.selectedSegmentIndex == 0) {
            eventDetailsViewController.eventID = self.upcomingEventsArray[indexPath.row].eventId
        }
        else {
            eventDetailsViewController.eventID = self.pastEventsArray[indexPath.row].eventId
        }
        
        navigationController?.pushViewController(eventDetailsViewController, animated: true)
    }
}

// will remove this code after some testing
/*
extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(url: url as URL)
            
            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) {
                (response: URLResponse?, data: Data?, error: Error?) -> Void in
                if let imageData = data as NSData? {
                    self.image = UIImage(data: imageData as Data)
                }
            }
        }
    }
}
 */
