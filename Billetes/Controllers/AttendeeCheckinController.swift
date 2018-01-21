//
//  AttendeeCheckinController.swift
//  Billetes
//
//  Created by Saoirse on 1/21/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AttendeeCheckinController: NSObject {

    // Checkin Attendee:
    func checkinAttendee(with ticketNumber: String, email: String, status: Bool,
                         completion: @escaping(Bool, String?)->()) {
        // Set service path.
        let loginInfo = Settings.sharedInstance.getLoginInfo()
        
        // Set service path
        let servicePath = URLConstants.kServerBaseURL + URLConstants.kAttendeeCheckinServicePath
        
        // Set request parameters.
        let params: Parameters = [Constants.kTicketNumKey: ticketNumber,
                                  Constants.kEmailKey: email,
                                  Constants.kIsCheckedInKey: status]
        
        // Set request parameters.
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        headers[Constants.kTokenKey] = loginInfo.token
        
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
                    completion(false, message)
                    return
                }
                
                // notify success.
                completion(true, "")
                return
            }
            else {
                // notify error.
                completion(false, response.error?.localizedDescription)
            }
        }
    }
}
