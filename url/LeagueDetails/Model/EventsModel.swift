//
//  EventsModel.swift
//  url
//
//  Created by Ann mohammed on 24/06/2022.
//

import Foundation

struct EventsModel: Codable {
    let events: [EventsData]?
}

struct EventsData: Codable {
    let strEvent: String?
    let dateEvent: String?
    let strTime: String?
    let strHomeTeam: String?
    let strAwayTeam: String?
    let intHomeScore: String?
    let intAwayScore: String?
    let strThumb: String?
}
