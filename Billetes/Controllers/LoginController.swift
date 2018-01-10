//
//  LoginController.swift
//  Billetes
//
//  Created by Saoirse on 1/6/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Alamofire
import SwiftyJSON

// Controller class to perform login and logout service and data handling.
class LoginController: NSObject {
    
    // Perform login service and save the user id and token on success.
    // Return status and error message if any.
    func loginUser(withEmail email: String,
                   password: String,
                   success:@escaping (Bool, String?) ->()){
        
        // Set service path.
        let servicePath = URLConstants.kServerBaseURL + URLConstants.kLoginServicePath
        
        // Set request parameters.
        let params: Parameters = [Constants.kEmailKey: email,
                                  Constants.kPasswordKey: password]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        // Initiate request.
        Alamofire.request(servicePath,
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: headers)
        .responseJSON { response in
            
            // Check for success in response.
            if (response.result.isSuccess) {
                // parse json.
                let json = JSON(response.result.value!)
                
                // TODO: Encapsulate status and message into the service response.
                let status = json[Constants.kStatusKey].intValue
                let message = json[Constants.kMessageKey].stringValue
                if status != 200 {
                    // notify error.
                    success(false, message)
                    return
                }
                
                // Read token and user id.
                let userId = json[Constants.kDataKey][Constants.kUser_IdKey].intValue
                let token = json[Constants.kDataKey][Constants.kTokenKey].stringValue
                
                // Update the loggedIn status in persistence storage.
                Settings.sharedInstance.setLoggedIn(status: true)
                Settings.sharedInstance.setLoginInfo(userId: userId, token: token)
                
                // notify success.
                success(true, nil)
            }
            else {
                // notify error.
                success(false, response.error?.localizedDescription)
            }
        }
    }
    
    
    // Logout:
    // Perform login service and save the user id and token on success.
    // Return status and error message if any.
    func logoutUser(completion:@escaping (Bool, String?) ->()){
        
        // Set service path.
        let servicePath = URLConstants.kServerBaseURL + URLConstants.kLogoutServicePath
        
        // Set service path.
        let loginInfo = Settings.sharedInstance.getLoginInfo()
        
        // Set request parameters.
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        headers[Constants.kTokenKey] = loginInfo.token
        
        // Initiate request.
        Alamofire.request(servicePath,
                          method: .post,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: headers)
        .responseJSON { response in
            // Check for success in response.
            if (response.result.isSuccess) {
                // parse json.
                let json = JSON(response.result.value!)
                
                // TODO: Encapsulate status and message into the service response.
                let status = json[Constants.kStatusKey].intValue
                let message = json[Constants.kMessageKey].stringValue
                if status != 200 {
                    // notify error.
                    completion(false, message)
                    return
                }
                
                // Update the loggedIn status in persistence storage.
                // Reset
                Settings.sharedInstance.setLoggedIn(status: false)
                Settings.sharedInstance.setLoginInfo(userId: -1, token: "")
                
                // notify success.
                completion(true, nil)
            }
            else {
                // notify error.
                completion(false, response.error?.localizedDescription)
            }
        }
    }

}
