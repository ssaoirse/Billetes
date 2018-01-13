//
//  EventsTableViewCell.swift
//  Billetes
//
//  Created by Gayatri Nagarkar on 11/01/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateTimeLabel: UILabel!
    @IBOutlet weak var eventBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.eventBackgroundView.layer.shadowOpacity = 0.6
        self.eventBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.eventBackgroundView.layer.shadowRadius = 5.0
        self.eventBackgroundView.layer.shadowColor = UIColor.darkGray.cgColor
        self.eventBackgroundView.layer.cornerRadius = 3.0
        self.eventImageView.layer.cornerRadius = 3.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
