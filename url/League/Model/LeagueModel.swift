//
//  LeagueModel.swift
//  url
//
//  Created by Ann mohammed on 23/06/2022.
//

import Foundation
import CoreData

struct LeaguesModel:Codable{
    let countries:[Myleagues]?
}

struct Myleagues :Codable{
    
    let idLeague: String?
    let strLeague:String?
    let strLeagueAlternate : String?
    let strYoutube : String?
    let strBadge: String?
    
    static let database = DatabaseHandler.shared
   
}

@objc(Model)
public class OfflineStorage: NSManagedObject {
    
    @NSManaged var idLeague: String
    @NSManaged var strLeague: String
    @NSManaged var strLeagueAlternate: String
    @NSManaged var strYoutube: String
    @NSManaged var strBadge: String
    
}
