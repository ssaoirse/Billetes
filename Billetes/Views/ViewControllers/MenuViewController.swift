//
//  MenuViewController.swift
//  Billetes
//
//  Created by Gayatri Nagarkar on 04/01/18.
//  Copyright © 2018 Gayatri Nagarkar. All rights reserved.
//

import UIKit
import MBProgressHUD

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
            self.logoutUser()
        default:
            self.performSegue(withIdentifier: Constants.kViewController_Base, sender: self)
        }        
    }
    
    
    // Logout:
    func logoutUser() {
        let loginController = LoginController()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        loginController.logoutUser { (success, message) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            // navigate to login screen.
            if(success) {
                let storyboard = UIStoryboard(name: Constants.kStoryboard_Login, bundle: nil)
                
                // instantiate your desired ViewController
                let rootViewController = storyboard.instantiateViewController(withIdentifier: Constants.kViewController_Login)
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                if let window = appDelegate.window {
                    window.rootViewController = rootViewController
                }
            }
            else {
                if let msg = message {
                    let alertView = UIAlertController.init(title: Bundle().displayName,
                                                           message: msg,
                                                           preferredStyle: UIAlertControllerStyle.alert)
                    alertView.addAction(UIAlertAction(title: Constants.kAlert_OK,
                                                      style: UIAlertActionStyle.default,
                                                      handler: nil))
                    self.present(alertView, animated: true, completion: nil)
                }
            }
        }
    }
}
