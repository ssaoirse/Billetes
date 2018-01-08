//
//  EventsController.swift
//  Billetes
//
//  Created by Saoirse on 1/8/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Alamofire
import SwiftyJSON

// Controller class to perform service and data handling for Events..
class EventsController: NSObject {
    
    // Fetch event list.
    func getEvents(success:@escaping ([Event]) ->(),
                   failure:@escaping (String?) ->()){
        
        // Set service path.
        let loginInfo = Settings.sharedInstance.getLoginInfo()
        
        // Set request parameters.
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        headers[Constants.kTokenKey] = loginInfo.token
        
        let servicePath = URLConstants.kServerBaseURL +
            String(format: URLConstants.kEventsServicePath, loginInfo.userId!)
        
        // Initiate request.
        Alamofire.request(servicePath,
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: headers)
        .responseJSON { response in
            
            // Check for success in response.
            if (response.result.isSuccess) {
                if response.result.value != nil  {
                    // Initialize the array to be returned.
                    var events = [Event]()
                    // parse json.
                    let json = JSON(response.result.value!)
                    for item in json.arrayValue {
                        // TODO: Refactor.
                        let eventId = item[Constants.kEvent_IdKey].intValue
                        let name = item[Constants.kNameKey].stringValue
                        let thumbnail = item[Constants.kThumbnail_UrlKey].stringValue
                        let datestring = item[Constants.kDatetimeKey].stringValue
                        
                        let dateFormatter = DateFormatter()
                        let datetime = dateFormatter.date(fromString: datestring,
                                                          format: Constants.kDatetimeFormatyyyyMMddHHmmss)
                        let event = Event(eventId: eventId,
                                          name: name,
                                          datetime: datetime!,
                                          thumbnailURL: thumbnail)
                        events.append(event)
                    }
                    
                    // notify success.
                    success(events)
                }
            }
            else {
                if let statusCode = response.response?.statusCode {
                    print(statusCode)
                }
                // notify error.
                failure(response.error?.localizedDescription)
            }
        }
    }
    
}
