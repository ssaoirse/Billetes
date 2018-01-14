//
//  ManualCheckInViewController.swift
//  Billetes
//
//  Created by Gayatri Nagarkar on 13/01/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import UIKit
import MBProgressHUD

class ManualCheckInViewController: UIViewController {
    
    // holds the list of all attendees
    var attendees:[Attendee] = []
    
    @IBOutlet weak var attendeesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.fetchAttendees()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Fetch Attendee list:
    func fetchAttendees() -> Void {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let eventsController = EventsController()
        eventsController.getAttendees(for: 50235,
        success: { attendees in
            self.attendees = attendees
            MBProgressHUD.hide(for: self.view, animated: true)
            self.attendeesTableView.reloadData()
        },
        failure: { (message) in
            if let msg = message {
                print(msg)
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        })
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
    
// MARK:- Extension Table View Delegate, Data Source
extension ManualCheckInViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.attendees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kAttendeeCellIdentifier,
                                                 for: indexPath) as! AttendeeTableViewCell
        let attendee = self.attendees[indexPath.row]
        cell.configureCell(with: attendee)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}

