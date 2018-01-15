//
//  EventsTableViewCell.swift
//  Billetes
//
//  Created by Gayatri Nagarkar on 11/01/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import UIKit
import Alamofire

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
    
    // Set up cell properties for event.
    func configureCell(with event: Event) -> Void {
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        Alamofire.request(event.thumbnailURL!).response { response in
            if let data = response.data {
                if let image = UIImage(data: data) {
                    self.eventImageView.image = image
                }
                else {
                    self.eventImageView.image = UIImage(named: "EventListPlaceHolder")
                }
            } else {
                // assign no photo image.
                self.eventImageView.image = UIImage(named: "EventListPlaceHolder")
            }
        }
        
        // will remove this line after some testing
        // cell.eventImageView.imageFromUrl(urlString: pastEventsArray[indexPath.row].thumbnailURL!)
        
        self.eventNameLabel.text = event.name
        
        let formatter = DateFormatter()
        
        // set the format coming in service
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateString = formatter.string(from: event.datetime)
        
        // convert string to date
        let date = formatter.date(from: dateString)
        
        //set the date format whhich needs to be displayed
        formatter.dateFormat = "EEEE, MMMM dd, yyyy, hh:mm a"
        
        // convert date to string
        let displayDateString = formatter.string(from: date!)
        
        self.eventDateTimeLabel.text = displayDateString
    }
}
