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
    
    // MARK: - Request Parameters -
    static let kEmailKey                        = "email"
    static let kPasswordKey                     = "password"
}
