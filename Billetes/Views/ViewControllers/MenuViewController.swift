//
//  MenuViewController.swift
//  Billetes
//
//  Created by Gayatri Nagarkar on 04/01/18.
//  Copyright © 2018 Gayatri Nagarkar. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var menuTableView: UITableView!
    
    var menuList:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        menuList = ["Events", "Logout"]
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.kMenuCellIdentifier)!
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.textLabel?.text = menuList[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: Constants.kViewController_Events, sender: self)
        case 1:
            let storyboard = UIStoryboard(name: Constants.kStoryboard_Login, bundle: nil)
            
            // instantiate your desired ViewController
            let rootViewController = storyboard.instantiateViewController(withIdentifier: Constants.kViewController_Login)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            if let window = appDelegate.window {
                window.rootViewController = rootViewController
            }
        default:
            self.performSegue(withIdentifier: Constants.kViewController_Base, sender: self)
        }        
    }
}
