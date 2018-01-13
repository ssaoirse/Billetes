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
    
    
    func fetchEventDetails(for eventId:Int) -> Void {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let eventsController = EventsController()
        eventsController.getDetails(
            for: eventId,
            success: { (eventDetail) in
                
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
                
                // not present in the service
                // self.daysLabel.text = String(eventDetail.a)
                // self.ticketsDetailsLabel.text = eventDetail.t
                
                MBProgressHUD.hide(for: self.view, animated: true)
        },
            failure: { (message) in
                MBProgressHUD.hide(for: self.view, animated: true)
        })
    }
    
}
