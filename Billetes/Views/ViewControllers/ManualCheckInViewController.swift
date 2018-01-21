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
    
    // property to be set by the caller.
    var eventID = 0
    var notCheckedInOnly: Bool = false
    
    // holds the list of all attendees
    var attendees = [Attendee]()
    var filteredAttendees = [Attendee]()
    
    // Delegate to notify when a new attendee is marked as checked in.
    weak var checkinDelegate: AttendeeCheckinDelegate?
    
    // Search controller.
    // use the same view to display results.
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var attendeesTableView: UITableView!
    @IBOutlet weak var noAttendeesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search attendee"
        // supported 9.1 and above.
        if #available(iOS 9.1, *) {
            // use the feature only available in iOS 9
            searchController.obscuresBackgroundDuringPresentation = false
        }
        
        // Supported 11.0 and above.
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            searchController.searchBar.tintColor = .white
            
            if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
                if let backgroundview = textfield.subviews.first {
                    
                    // Background color
                    backgroundview.backgroundColor = .white
                    
                    // Rounded corner
                    backgroundview.layer.cornerRadius = 10;
                    backgroundview.clipsToBounds = true;
                    
                }
            }
            navigationItem.hidesSearchBarWhenScrolling = false
        }
        else {
            self.attendeesTableView.tableHeaderView = self.searchController.searchBar
        }
        definesPresentationContext = true
        
        // Fetch the list of attendees.
        self.fetchAttendees(for: eventID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Fetch Attendee list:
    func fetchAttendees(for eventId:Int) -> Void {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let eventsController = EventsController()
        eventsController.getAttendees(for: eventId,
        success: { attendees in
            
            // Filter the list if only not checked in attendees are to be listed.
            if self.notCheckedInOnly {
                self.attendees = attendees.filter{ (attendee) -> Bool in
                    return !(attendee.isCheckedIn)
                }
            }
            else {
                self.attendees = attendees
            }
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
    
    // MARK:- Private Instance Methods:
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        self.filteredAttendees = self.attendees.filter({( attendee : Attendee) -> Bool in
            return attendee.name.lowercased().contains(searchText.lowercased())
        })
        
        self.attendeesTableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return self.searchController.isActive && !searchBarIsEmpty()
    }
}
    
// MARK:- Extension Table View Delegate, Data Source
extension ManualCheckInViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let attendeeCount: Int
        if isFiltering() {
            attendeeCount = filteredAttendees.count
        }
        else {
            attendeeCount = attendees.count
        }
        
        // Show no attendees label if count is 0
        if attendeeCount == 0 {
            noAttendeesLabel.isHidden = false
        }
        else {
            noAttendeesLabel.isHidden = true
        }
        
        return attendeeCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kAttendeeCellIdentifier,
                                                 for: indexPath) as! AttendeeTableViewCell
        let attendee : Attendee
        if self.isFiltering() {
            attendee = self.filteredAttendees[indexPath.row]
        }
        else {
            attendee = self.attendees[indexPath.row]
        }
        
        cell.configureCell(with: attendee)
        
        // Update checkin status.
        cell.updateCheckInStatus(with: attendee.isCheckedIn)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var attendee : Attendee
        if self.isFiltering() {
            attendee = self.filteredAttendees[indexPath.row]
        }
        else {
            attendee = self.attendees[indexPath.row]
        }
        
        // Do nothing if already checked in.
        if attendee.isCheckedIn {
            return
        }
        
        let ticketNumber = attendee.ticketNumber
        let email = attendee.email ?? ""
        self.checkinAttendee(at: indexPath, ticketNumber: ticketNumber, email: email)
    }
    
    
    // checkin selected attendee:
    func checkinAttendee(at indexPath: IndexPath, ticketNumber: String, email: String) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let attendeeCheckinController = AttendeeCheckinController()
        attendeeCheckinController.checkinAttendee(with: ticketNumber,
                                                  email: email,
                                                  status: true)
        { (checkedIn, message) in
            // Attendee checkin successfully
            if checkedIn {
                
                var attendee : Attendee
                if self.isFiltering() {
                    attendee = self.filteredAttendees[indexPath.row]
                    attendee.isCheckedIn = true
                    self.filteredAttendees[indexPath.row] = attendee
                }
                else {
                    attendee = self.attendees[indexPath.row]
                    attendee.isCheckedIn = true
                    self.attendees[indexPath.row] = attendee
                }
                
                // Notify the listener about the new checkin.
                var ticketArray  = [String]()
                ticketArray.append(ticketNumber)
                self.checkinDelegate?.didCheckinAttendees(for: self.eventID, ticketNumbers: ticketArray)
                
                MBProgressHUD.hide(for: self.view, animated: true)
                self.attendeesTableView.reloadData()
            }
            else {
                MBProgressHUD.hide(for: self.view, animated: true)
                if let msg = message {
                    print(msg)
                }
                
            }
        }
    }
}


// MARK:-
extension ManualCheckInViewController: UISearchResultsUpdating {
    
    // Update the search results.
    func updateSearchResults(for searchController: UISearchController) {
        self.filterContentForSearchText(self.searchController.searchBar.text!)
    }
    
}


