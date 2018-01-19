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
                
                // parse json.
                let json = JSON(response.result.value!)
                // TODO: Encapsulate status and message into the service response.
                let status = json[Constants.kStatusKey].intValue
                let message = json[Constants.kMessageKey].stringValue
                if status != 200 {
                    // notify error.
                    failure(message)
                    return
                }
                
                // Initialize the array to be returned.
                var events = [Event]()
                let dateFormatter = DateFormatter()
                
                for item in json[Constants.kDataKey].arrayValue {
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
            else {
                // notify error.
                failure(response.error?.localizedDescription)
            }
        }
    }
    

    // Returns the event details for the specified event Id.
    func getDetails(for eventId: Int,
                    success:@escaping (EventDetail) ->(),
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
                
                // parse json.
                let json = JSON(response.result.value!)
                // TODO: Encapsulate status and message into the service response.
                let status = json[Constants.kStatusKey].intValue
                let message = json[Constants.kMessageKey].stringValue
                if status != 200 {
                    // notify error.
                    failure(message)
                    return
                }
                
                // Parse event details.
                let eventId = json[Constants.kDataKey][Constants.kEvent_IdKey].intValue
                let name = json[Constants.kDataKey][Constants.kNameKey].stringValue
                let ticketsSold = json[Constants.kDataKey][Constants.kSoldKey].intValue
                let ticketsAvailable = json[Constants.kDataKey][Constants.kAvailableKey].intValue
                let totalTickets = json[Constants.kDataKey][Constants.kTicketsKey].intValue
                let totalAmount = json[Constants.kDataKey][Constants.kAmountKey].doubleValue
                let freeAdmission = json[Constants.kDataKey][Constants.kFreeAdmissionKey].intValue
                let thumbnailURL = json[Constants.kDataKey][Constants.kThumbnail_UrlKey].string
                let location = json[Constants.kDataKey][Constants.kLocationKey].string
                let eventURL = json[Constants.kDataKey][Constants.kEventUrlKey].string
                
                
                // TODO: handle datetime.
                let dateFormatter = DateFormatter()
                let datestring = json[Constants.kDataKey][Constants.kDatetimeKey].stringValue
                let datetime = dateFormatter.date(fromString: datestring,
                                                  format: Constants.kDatetimeFormatyyyyMMddHHmmss)
                
                let eventDetail = EventDetail(eventId: eventId,
                                              name: name,
                                              datetime: datetime!,
                                              ticketsSold: ticketsSold,
                                              ticketsAvailable: ticketsAvailable,
                                              totalTickets: totalTickets,
                                              totalAmount: totalAmount,
                                              freeAdmission: freeAdmission,
                                              location: location,
                                              thumbnailURL: thumbnailURL,
                                              eventURL: eventURL)
                
                // notify success.
                success(eventDetail)
                return
            }
            else {
                // notify error.
                failure(response.error?.localizedDescription)
            }
        }
    }
    
    
    // Event Day Tools:
    func getEventDayTools(for eventId: Int,
                          success:@escaping (EventDayTools) ->(),
                          failure:@escaping (String?)->()) {
        // Set service path.
        let loginInfo = Settings.sharedInstance.getLoginInfo()
        
        let servicePath = URLConstants.kServerBaseURL +
            String(format: URLConstants.kEventDayToolsServicePath, loginInfo.userId!, eventId)
        
        // Set request parameters.
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        headers[Constants.kTokenKey] = loginInfo.token
        
        // Initiate request.
        Alamofire.request(servicePath,
                          method: .get,
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
                    failure(message)
                    return
                }
                
                // Parse event details.
                let eventId = json[Constants.kDataKey][Constants.kEvent_IdKey].intValue
                let name = json[Constants.kDataKey][Constants.kNameKey].stringValue
                let checkedIn = json[Constants.kDataKey][Constants.kCheckedInKey].intValue
                let notCheckedIn = json[Constants.kDataKey][Constants.kNotCheckedInKey].intValue
                let location = json[Constants.kDataKey][Constants.kLocationKey].stringValue
                
                // TODO: handle datetime.
                let dateFormatter = DateFormatter()
                let datestring = json[Constants.kDataKey][Constants.kDatetimeKey].stringValue
                let datetime = dateFormatter.date(fromString: datestring,
                                                  format: Constants.kDatetimeFormatyyyyMMddHHmmss)
                let eventDayTools = EventDayTools(eventId: eventId,
                                                  name: name,
                                                  location: location,
                                                  datetime: datetime!,
                                                  checkedIn: checkedIn,
                                                  notCheckedIn: notCheckedIn)
                
                // notify success.
                success(eventDayTools)
                return
            }
            else {
                // notify error.
                failure(response.error?.localizedDescription)
            }
        }
    }
    
    
    // Attendee List:
    func getAttendees(for eventId: Int,
                      success:@escaping ([Attendee]) ->(),
                      failure:@escaping (String?)->()) {
        // Set service path.
        let loginInfo = Settings.sharedInstance.getLoginInfo()
        
        // Set request parameters.
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        headers[Constants.kTokenKey] = loginInfo.token
        
        let servicePath = URLConstants.kServerBaseURL +
            String(format: URLConstants.kAttendeeListServicePath, loginInfo.userId!, eventId)
        
        // Initiate request.
        Alamofire.request(servicePath,
                          method: .get,
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
                    failure(message)
                    return
                }
                
                // Initialize the array to be returned.
                var attendees = [Attendee]()
                for item in json[Constants.kDataKey].arrayValue {
                    // TODO: Refactor.
                    let name = item[Constants.kNameKey].stringValue
                    let ticketNumber = item[Constants.kTicketNumKey].stringValue
                    let admissionStatus = item[Constants.kAdmissionStatusKey].stringValue
                    let isCheckedIn = item[Constants.kAdmissionStatusKey].boolValue
                    let email = item[Constants.kEmailKey].string
                    
                    let attendee = Attendee(name: name,
                                            ticketNumber: ticketNumber,
                                            isCheckedIn: isCheckedIn,
                                            admissionStatus: admissionStatus,
                                            email: email)
                    attendees.append(attendee)
                }
                
                // sort the array if it has elements.
                if attendees.count > 1 {
                    attendees.sort(by: { (attendee1, attendee2) -> Bool in
                        return attendee1.name < attendee2.name
                    })
                }
                
                // notify success.
                success(attendees)
                return
            }
            else {
                // notify error.
                failure(response.error?.localizedDescription)
            }
        }
    }
    
    
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
