//
//  AttendeeTableViewCell.swift
//  Billetes
//
//  Created by Saoirse on 1/14/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import UIKit

class AttendeeTableViewCell: UITableViewCell {

    @IBOutlet weak var attendeeName: UILabel!    
    @IBOutlet weak var admissionStatus: UILabel!
    @IBOutlet weak var ticketNumber: UILabel!
    @IBOutlet weak var attendeeBackgroundView: UIView!
    @IBOutlet weak var checkInStatusImageView: UIImageView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        
        self.attendeeBackgroundView.layer.shadowOpacity = 0.6
        self.attendeeBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.attendeeBackgroundView.layer.shadowRadius = 5.0
        self.attendeeBackgroundView.layer.shadowColor = UIColor.darkGray.cgColor
        self.attendeeBackgroundView.layer.cornerRadius = 3.0
        self.attendeeBackgroundView.layer.cornerRadius = 3.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Set up cell properties for attendee.
    func configureCell(with attendee: Attendee) -> Void {
        self.attendeeName.text = attendee.name
        self.admissionStatus.text = attendee.admissionStatus
        self.ticketNumber.text = attendee.ticketNumber
    }
    
    // Updates the checkin status.
    func updateCheckInStatus(with status: Bool) -> Void {
        if status {
            self.checkInStatusImageView?.image = UIImage(named: "CheckedIn")
        }
        else {
            self.checkInStatusImageView?.image = UIImage(named: "NotCheckedIn")
        }
    }

}
