import Foundation

import Foundation

struct EventsResponse: Decodable {
    
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
}
