//
//  HomeModel.swift
//  url
//
//  Created by Ann mohammed on 23/06/2022.
//

import Foundation

// MARK :- Response model
struct Response:Codable{
    let sports :[Sports]?
}

// MARK :- Response model
struct Sports :Codable{
    //data forms
    let idSport : String?
    let strFormat:String?
    let strSportThumb : String?
    let strSportIconGreen: String?
    let strSportDescription : String?
    let strSport : String?
    
}


