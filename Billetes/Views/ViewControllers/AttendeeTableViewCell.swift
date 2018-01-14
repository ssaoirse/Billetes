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
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
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

}
