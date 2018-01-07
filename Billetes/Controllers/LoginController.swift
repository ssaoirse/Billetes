//
//  LoginController.swift
//  Billetes
//
//  Created by Saoirse on 1/6/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Alamofire
import SwiftyJSON

class LoginController: NSObject {
    
    // TODO:
    // Refactor into proper success and failure..
    // Store the User Id and token.
    func loginUser(withEmail email: String, password: String, success:@escaping (Bool) ->()){
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
            if((response.result.value) != nil) {
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
            }
            if let result = response.result.value {
                print(result)
            }
            if (response.result.isSuccess) {
                // Update the loggedIn status in persistence storage.
                Settings.sharedInstance.setLoggedIn(status: true)
                success(true)
            }
            else {
                success(false)
            }
        }
    }

}
