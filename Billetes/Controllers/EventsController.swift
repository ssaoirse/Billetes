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
    
    // Retrieves the list of all available events.
    // Fetch event list.
    func getEvents(success:@escaping (_ upcomingEvents: [Event], _ pastEvents:[Event]) ->(),
                   failure:@escaping (String?) ->()) {
        
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
                    let dateFormatter = DateFormatter()
                    // parse json.
                    let json = JSON(response.result.value!)
                    for item in json.arrayValue {
                        // TODO: Refactor.
                        let eventId = item[Constants.kEvent_IdKey].intValue
                        let name = item[Constants.kNameKey].stringValue
                        let thumbnail = item[Constants.kThumbnail_UrlKey].stringValue
                        let datestring = item[Constants.kDatetimeKey].stringValue
                        let datetime = dateFormatter.date(fromString: datestring,
                                                          format: Constants.kDatetimeFormatyyyyMMddHHmmss)
                        let event = Event(eventId: eventId,
                                          name: name,
                                          datetime: datetime!,
                                          thumbnailURL: thumbnail)
                        events.append(event)
                    }
                    
                    // Filter the list of events based on current date as upcoming and
                    // Upcoming events.
                    let today = Date()
                    let upcomingEvents = events.filter(){
                        $0.datetime >= today
                    }
                    
                    // past events.
                    let pastEvents = events.filter(){
                        $0.datetime < today
                    }
                    
                    // notify success.
                    success(upcomingEvents, pastEvents)
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
    

    // Returns the event details for the specified event Id.
    func getDetails(for eventId: Int,
                    success:@escaping (Bool) ->(),
                    failure:@escaping (String?)->()) {
        // Set service path.
        let loginInfo = Settings.sharedInstance.getLoginInfo()
        
        // Set request parameters.
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        headers[Constants.kTokenKey] = loginInfo.token
        
        let servicePath = URLConstants.kServerBaseURL +
            String(format: URLConstants.kEventDetailsServicePath, loginInfo.userId!, eventId)
        
        // Initiate request.
        Alamofire.request(servicePath,
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: headers)
        .responseJSON { response in
            
            // Check for success in response.
            if (response.result.isSuccess) {
                if response.result.value != nil  {
                    // TODO: Response not expected in an array, but a single dictionary.
                    // parse json.
                    let json = JSON(response.result.value!)
                    for item in json.arrayValue {
                        let eventId = item[Constants.kEvent_IdKey].intValue
                        let name = item[Constants.kNameKey].stringValue
                        let ticketsSold = item[Constants.kSoldKey].intValue
                        let ticketsAvailable = item[Constants.kAvailableKey].intValue
                        let totalTickets = item[Constants.kTicketsKey].intValue
                        let totalAmount = item[Constants.kAmountKey].doubleValue
                        let thumbnailURL = item[Constants.kThumbnail_UrlKey].string
                        let location = item[Constants.kLocationKey].string
                        
                        // TODO: handle datetime.
                        let dateFormatter = DateFormatter()
                        let datestring = item[Constants.kDatetimeKey].stringValue
                        let datetime = dateFormatter.date(fromString: datestring,
                                                          format: Constants.kDatetimeFormatyyyyMMddHHmmss)
                        
                        let eventDetail = EventDetail(eventId: eventId,
                                                      name: name,
                                                      datetime: datetime!,
                                                      ticketsSold: ticketsSold,
                                                      ticketsAvailable: ticketsAvailable,
                                                      totalTickets: totalTickets,
                                                      totalAmount: totalAmount,
                                                      location: location,
                                                      thumbnailURL: thumbnailURL)
                        print(eventDetail)
                        
                        // notify success.
                        success(true)
                        return
                    }
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
