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
        let params: Parameters = [URLConstants.kEmailKey: email,
                                  URLConstants.kPasswordKey: password]
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
                if response.result.value != nil  {
                    // parse json.
                    let json = JSON(response.result.value!)
                    
                    // Read token and user id.
                    let userId = json[Constants.kUser_IdKey].intValue
                    let token = json[Constants.kTokenKey].stringValue
                    
                    // Update the loggedIn status in persistence storage.
                    Settings.sharedInstance.setLoggedIn(status: true)
                    Settings.sharedInstance.setLoginInfo(userId: userId, token: token)
                    
                    // notify success.
                    success(true, nil)
                }
            }
            else {
                if let statusCode = response.response?.statusCode {
                    print(statusCode)
                }
                // notify error.
                success(false, response.error?.localizedDescription)
            }
        }
    }

}
