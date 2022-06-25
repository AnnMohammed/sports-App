//
//  TeamsModel.swift
//  url
//
//  Created by Ann mohammed on 24/06/2022.
//

import Foundation

struct TeamsModel: Codable {
    let teams: [TeamsData]?
}

struct TeamsData: Codable {
    let strTeam: String?
    let strTeamShort: String?
    let strAlternate: String?
    let strLeague: String?
    let strStadium: String?
    let strTeamBanner: String?
}
