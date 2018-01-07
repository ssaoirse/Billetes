//
//  LoginController.swift
//  Billetes
//
//  Created by Saoirse on 1/6/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Alamofire

class LoginController: NSObject {
    
    // TODO: Refactor.
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
            if let result = response.result.value {
                print(result)
            }
            if (response.result.isSuccess) {
                success(true)
            }
            else {
                success(false)
            }
        }
    }

}
