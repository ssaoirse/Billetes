//
//  EventsViewController.swift
//  Billetes
//
//  Created by Gayatri Nagarkar on 02/01/18.
//  Copyright © 2018 Gayatri Nagarkar. All rights reserved.
//

import UIKit

class EventsViewController: BaseMenuViewController {

    @IBOutlet weak var eventsSegmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        self.eventsSegmentedControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white],
                                                           for: UIControlState.normal)
        self.eventsSegmentedControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white],
                                                           for: UIControlState.selected)
        //fetchEvents()
        //fetchEventDetails()
        //fetchEventDayTools()
        //fetchAttendees()
        //checkinAttendee()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK:- DEBUG CODE REMOVE LATER -
    
    func fetchEvents() -> Void {
        let eventsController = EventsController()
        eventsController.getEvents(
        success: { upcomingEvents, pastEvents  in
            print("Upcoming Events\n", upcomingEvents)
            print("Past Events\n", pastEvents)
        },
        failure: { (message) in
            if let msg = message {
                print(msg)
            }
        })
    }
    
    
    func fetchEventDetails() -> Void {
        let eventsController = EventsController()
        eventsController.getDetails(for: 50773,
        success: { (eventDetail) in
            print(eventDetail)
        },
        failure: { (message) in
            
        })
    }
    
    
    func fetchEventDayTools() -> Void {
        let eventsController = EventsController()
        eventsController.getEventDayTools(for: 50773,
        success: { (eventDayTools) in
            print(eventDayTools)
        },
        failure: { (message) in
        
        })
        
    }
    
    func fetchAttendees() -> Void {
        let eventsController = EventsController()
        eventsController.getAttendees(for: 50235,
        success: { (attendees) in
            print("Attendees Count: ",attendees.count)
            print(attendees)
        },
        failure: { (message) in
        
        })
    }
    
    func checkinAttendee() {
        let eventsController = EventsController()
        eventsController.checkinAttendee(with: "1032955",
                                         email: "johnjmaloney@gmail.com",
                                         status: true,
        completion: { (success, message) in
            
        })
    }
}

