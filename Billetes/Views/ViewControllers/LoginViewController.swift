//
//  LoginViewController.swift
//  Billetes
//
//  Created by Gayatri Nagarkar on 02/01/18.
//  Copyright © 2018 Gayatri Nagarkar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        usernameTextField.text = "boletosexpress@gmail.com"
        passwordTextField.text = "eXpre55$"
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        if isValidate() {
            
            let storyboard = UIStoryboard(name: Constants.kStoryboard_Base, bundle: nil)
            
            // instantiate your desired ViewController
            let rootViewController =
                storyboard.instantiateViewController(withIdentifier: Constants.kViewController_Base)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            if let window = appDelegate.window {
                window.rootViewController = rootViewController
            }
        }
    }
    
    func isValidate() -> Bool {
        
        if ((usernameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!) {
            
            let alerView = UIAlertController.init(title: Bundle().displayName,
                                                  message: Constants.kAlert_BlankCredentials,
                                                  preferredStyle: UIAlertControllerStyle.alert)
            alerView.addAction(UIAlertAction(title: Constants.kAlert_OK, style: UIAlertActionStyle.default, handler: nil))
            present(alerView, animated: true, completion: nil)
            return false
        }
        else {
            
            if !((usernameTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!) &&
                !((passwordTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!) {
                
                let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                if emailTest.evaluate(with: usernameTextField.text) {
                    
                    return true
                }
                else {
                    let alerView = UIAlertController.init(title:Bundle().displayName,
                                                          message: Constants.kAlert_WrongEmail,
                                                          preferredStyle: UIAlertControllerStyle.alert)
                    alerView.addAction(UIAlertAction(title: Constants.kAlert_OK, style: UIAlertActionStyle.default,
                                                     handler: nil))
                    present(alerView, animated: true, completion: nil)
                    return false
                }
            }
            else {
                let alerView = UIAlertController.init(title: Bundle().displayName,
                                                      message: Constants.kAlert_ContainsWhitespace,
                                                      preferredStyle: UIAlertControllerStyle.alert)
                alerView.addAction(UIAlertAction(title: Constants.kAlert_OK, style: UIAlertActionStyle.default, handler: nil))
                present(alerView, animated: true, completion: nil)
                return false
            }
        }
    }
}
