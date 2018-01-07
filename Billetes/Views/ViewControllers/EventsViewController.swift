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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

