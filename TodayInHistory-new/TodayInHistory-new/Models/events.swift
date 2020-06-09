//
//  events.swift
//  TodayInHistory-new
//
//  Created by Tom on 8/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

import Foundation

struct EventResponse: Decodable {
    
    let result: [Event]
}

struct Event: Decodable, Identifiable {
    
    let id: String
    let title: String
    let pic: String?
    let year: Int
    let month: Int
    let day: Int
    let des: String
    let lunar: String
    
    //Identifiable必须要一个id，此时就需要CodingKey将trackId转为id
    enum CodingKeys: String, CodingKey {
        case id = "_id"
            case title = "title"
            case pic = "pic"
            case year = "year"
            case month = "month"
            case day = "day"
            case des = "des"
            case lunar = "lunar"
    }
}
