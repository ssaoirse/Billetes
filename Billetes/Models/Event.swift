//
//  Event.swift
//  Billetes
//
//  Created by Saoirse on 1/8/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation
import SwiftyJSON

// MARK:- Event -
struct Event {
    let eventId: Int
    let name: String
    var thumbnailURL: String?
    var datetime: Date
    
    // Intializer.
    init(eventId: Int, name: String, datetime: Date, thumbnailURL: String? = nil ) {
        self.eventId = eventId
        self.name = name
        self.datetime = datetime
        self.thumbnailURL = thumbnailURL
    }
}


// MARK:- Event Detail -
struct EventDetail {
    let eventId: Int
    let name: String
    let datetime: Date
    let ticketsSold: Int
    let ticketsAvailable: Int
    let totalTickets: Int
    let totalAmount: Double
    let freeAdmission: Int
    var location: String?
    var thumbnailURL: String?
    var eventURL: String?
    
    init(eventId: Int, name: String, datetime: Date, ticketsSold: Int, ticketsAvailable: Int,
         totalTickets: Int, totalAmount: Double, freeAdmission: Int, location: String? = nil, thumbnailURL: String? = nil,
         eventURL: String? = nil) {
        self.eventId = eventId
        self.name = name
        self.datetime = datetime
        self.ticketsSold = ticketsSold
        self.ticketsAvailable = ticketsAvailable
        self.totalTickets = totalTickets
        self.totalAmount = totalAmount
        self.freeAdmission = freeAdmission
        self.location = location
        self.thumbnailURL = thumbnailURL
        self.eventURL = eventURL
    }
}


// MARK:- Event Day Tools -
struct EventDayTools {
    let eventId: Int
    let name: String
    let location: String
    let datetime: Date
    let checkedIn: Int
    let notCheckedIn: Int
    
    // Intializer.
    init(eventId: Int, name: String, location: String, datetime: Date, checkedIn: Int, notCheckedIn: Int ) {
        self.eventId = eventId
        self.name = name
        self.datetime = datetime
        self.location = location
        self.checkedIn = checkedIn
        self.notCheckedIn = notCheckedIn
    }
}







