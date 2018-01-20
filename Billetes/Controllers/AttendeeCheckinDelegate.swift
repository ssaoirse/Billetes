//
//  AttendeeCheckinDelegate.swift
//  Billetes
//
//  Created by Saoirse on 1/20/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation

protocol AttendeeCheckinDelegate: class {
    // Notifies with an array of attendee Id/s for an Event (eventId)
    // when they are checked in.
    func didCheckinAttendees(for eventId: Int, attendeeIds: [Int])
}
