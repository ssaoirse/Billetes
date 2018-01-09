//
//  Event.swift
//  Billetes
//
//  Created by Saoirse on 1/8/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation
import SwiftyJSON

// Data model for Event.
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

// Data model for Event Details:
struct EventDetail {
    let eventId: Int
    let name: String
    let datetime: Date
    let ticketsSold: Int
    let ticketsAvailable: Int
    let totalTickets: Int
    let totalAmount: Double
    var location: String?
    var thumbnailURL: String?
    
    init(eventId: Int, name: String, datetime: Date, ticketsSold: Int, ticketsAvailable: Int,
         totalTickets: Int, totalAmount: Double, location: String? = nil, thumbnailURL: String? = nil) {
        self.eventId = eventId
        self.name = name
        self.datetime = datetime
        self.ticketsSold = ticketsSold
        self.ticketsAvailable = ticketsAvailable
        self.totalTickets = totalTickets
        self.totalAmount = totalAmount
        self.location = location
        self.thumbnailURL = thumbnailURL
    }
    
}



