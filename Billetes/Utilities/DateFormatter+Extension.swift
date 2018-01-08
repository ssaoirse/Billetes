//
//  DateFormatter+Extension.swift
//  Billetes
//
//  Created by Saoirse on 1/8/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    // Return a Date object from string having specified date format:
    func date(fromString dateString: String, format: String) -> Date? {
        self.dateFormat = format
        self.timeZone = TimeZone(abbreviation: "UTC")
        self.locale = Locale(identifier: "en_US_POSIX")
        return self.date(from: dateString)
    }
}
