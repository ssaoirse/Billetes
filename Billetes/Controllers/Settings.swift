//
//  Settings.swift
//  Billetes
//
//  Created by Saoirse on 1/7/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation

class Settings {
    static let sharedInstance = Settings()
    
    // This prevents others from using the default '()' initializer for this class.
    private init() {
        // Set default values for logged in status.
        initializeDefaults()
    }
    
    // MARK:- Login Status -
    
    // Return true/false based on the login status.
    func isLoggedIn() -> Bool {
        UserDefaults.standard.synchronize()
        return UserDefaults.standard.bool(forKey: Constants.kLoggedInKey)
    }
    
    // Setter for login status.
    func setLoggedIn(status: Bool) -> Void {
        UserDefaults.standard.set(status, forKey: Constants.kLoggedInKey)
        UserDefaults.standard.synchronize()
    }
    
    // MARK:- Login Info -
    
    // Returns the Login Info.
    func getLoginInfo() -> (userId: String?, token: String?) {
        let userId = UserDefaults.standard.string(forKey: Constants.kUser_IdKey)
        let token = UserDefaults.standard.string(forKey: Constants.kTokenKey)
        return (userId,token)
    }
    
    // Set the user Id and the access token.
    func setLoginInfo(userId: String, token: String) -> Void {
        UserDefaults.standard.set(userId, forKey: Constants.kUser_IdKey)
        UserDefaults.standard.set(token, forKey: Constants.kTokenKey)
        UserDefaults.standard.synchronize()
    }
    
    // MARK:- Private Methods -
    func initializeDefaults() {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: Constants.kLoggedInKey) != nil {
            return
        }
        UserDefaults.standard.set(false, forKey: Constants.kLoggedInKey)
        UserDefaults.standard.set("", forKey: Constants.kUser_IdKey)
        UserDefaults.standard.set("", forKey: Constants.kTokenKey)
        UserDefaults.standard.synchronize()
    }
}
