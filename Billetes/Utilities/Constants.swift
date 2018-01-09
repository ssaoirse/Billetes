//
//  Constants.swift
//  Billetes
//
//  Created by Gayatri Nagarkar on 04/01/18.
//  Copyright © 2018 Gayatri Nagarkar. All rights reserved.
//

import Foundation

struct Constants {
    
    // MARK: -
    // MARK: Key names -
    //    static let kTitle = "title"
    
    // MARK: -
    // MARK: Identifiers -
    static let kMenuCellIdentifier = "cellMenu"
    
    // MARK: -
    // MARK: Storyboard names -
    static let kStoryboard_Login = "Login"
    static let kStoryboard_Base = "Base"
    //    static let kStoryboard_Events = "Events"
    
    // MARK: -
    // MARK: View Controller Identifiers -
    static let kViewController_Login = "LoginViewController"
    static let kViewController_Base = "SideMenuViewController"
    static let kViewController_Events = "Events"
    
    // MARK: -
    // MARK: Alert messages -
    static let kAlert_InvalidCredentials = "Invalid Username or Password."
    static let kAlert_BlankCredentials = "Please enter Username and Password."
    static let kAlert_WrongEmail = "Please enter valid Username."
    static let kAlert_ContainsWhitespace = "Username or password should not contain any whitespace."
    static let kAlert_OK = "OK"
    
    // MARK: -
    // MARK: App Settings -
    static let kLoggedInKey = "loggedIn"
    static let kUser_IdKey = "user_id"
    static let kTokenKey = "token"
    
    // MARK: - Events -
    static let kEvent_IdKey = "event_id"
    static let kNameKey = "name"
    static let kThumbnail_UrlKey = "thumbnail_url"
    static let kDatetimeKey = "datetime"
    static let kDatetimeFormatyyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
    
    // MARK: - Event Details -
    static let kLocationKey = "location"
    static let kSoldKey = "sold"
    static let kTicketsKey = "tickets"
    static let kAvailableKey = "available"
    static let kAmountKey = "amount"
    
    
}
