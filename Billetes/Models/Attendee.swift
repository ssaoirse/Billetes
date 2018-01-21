//
//  Attendee.swift
//  Billetes
//
//  Created by Saoirse on 1/11/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation

// MARK: - Attendee -
struct Attendee {
    let name: String
    let ticketNumber: String
    var isCheckedIn: Bool
    let admissionStatus: String
    let email: String?
    
    init(name: String,ticketNumber: String, isCheckedIn: Bool, admissionStatus: String, email: String? = nil){
        self.name = name
        self.ticketNumber = ticketNumber
        self.isCheckedIn = isCheckedIn
        self.admissionStatus = admissionStatus
        self.email = email
    }
}
