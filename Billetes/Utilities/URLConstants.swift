//
//  URLConstants.swift
//  Billetes
//
//  Created by Saoirse on 1/6/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation

struct URLConstants {
    
    // MARK:- BaseURL -
    static let kServerBaseURL                   = "https://www.boletosexpress.com"
    
    // MARK:- ServicePaths -
    static let kLoginServicePath                = "/newsite/api/public/login"
    static let kLogoutServicePath               = "/newsite/api/public/logout"
    
    // /newsite/api/public/events/{user_id}
    static let kEventsServicePath               = "/newsite/api/public/events/%d"
    
    // /newsite/api/public/event/{user_id}/{event_id}
    static let kEventDetailsServicePath         = "/newsite/api/public/event/%d/%d"
    
    // /newsite/api/public/event_day_tools/{user_id}/{event_id}
    static let kEventDayToolsServicePath        = "/newsite/api/public/event_day_tools/%d/%d"
    
    // /newsite/api/public/attendee_list/{user_id}/{event_id}
    static let kAttendeeListServicePath         = "/newsite/api/public/attendee_list/%d/%d"
    
    // /newsite/api/public/checkin
    static let kAttendeeCheckinServicePath      = "/newsite/api/public/checkin"
    
}
