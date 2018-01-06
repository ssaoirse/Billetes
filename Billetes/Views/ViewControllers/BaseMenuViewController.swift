//
//  BaseMenuViewController.swift
//  Billetes
//
//  Created by Gayatri Nagarkar on 04/01/18.
//  Copyright © 2018 Gayatri Nagarkar. All rights reserved.
//

import UIKit

class BaseMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItem =
            UIBarButtonItem(image: #imageLiteral(resourceName: "Menu_icon"), style: .plain, target: self.revealViewController(),
                            action: #selector(SWRevealViewController.revealToggle(_:)))

        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        self.revealViewController().rearViewRevealWidth = 250.0
        self.revealViewController().bounceBackOnOverdraw = false
        self.revealViewController().stableDragOnOverdraw = true
    }
}
