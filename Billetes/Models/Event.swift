//
//  Event.swift
//  Billetes
//
//  Created by Saoirse on 1/8/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation

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
