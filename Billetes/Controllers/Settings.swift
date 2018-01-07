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
    
    // MARK: -
    // MARK: Private Methods -
    func initializeDefaults() {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: Constants.kLoggedInKey) != nil {
            return
        }
        UserDefaults.standard.set(false, forKey: Constants.kLoggedInKey)
        UserDefaults.standard.synchronize()
    }

}
