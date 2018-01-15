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

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var checkedInLabel: UILabel!
    @IBOutlet weak var notCheckedInLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fetchEventDayTools(for: eventID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchEventDayTools(for eventId:Int) -> Void {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let eventsController = EventsController()
        eventsController.getEventDayTools(
            for: eventId,
            success: { (eventDayTools) in
                print(eventDayTools)
                
//                Alamofire.request(eventDayTools.u!).response { response in
//                    if let data = response.data {
//                        let image = UIImage(data: data)
//                        self.eventImageView.image = image
//                    } else {
//                        //TODO: assign no photo image.
//                    }
//                }
                
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
                
                self.checkedInLabel.text = String(eventDayTools.checkedIn)
                self.notCheckedInLabel.text = String(eventDayTools.notCheckedIn)
                
                MBProgressHUD.hide(for: self.view, animated: true)
        },
            failure: { (message) in
          
                MBProgressHUD.hide(for: self.view, animated: true)
        })
        
    }

}
