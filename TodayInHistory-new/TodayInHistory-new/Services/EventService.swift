//
//  EventService.swift
//  TodayInHistory-new
//
//  Created by Tom on 8/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

import Foundation

//定义了1个服务protocol，包含1个方法：获取列表
protocol EventService {
    func fetchEvents(from endpoint: EventListEndpoint, completion: @escaping (Result<EventResponse, EventError>) -> ())
}

//封装了1个enum：供url参数使用，用于获取 list
enum EventListEndpoint: String, CaseIterable {
    case todayInHistory = "toh"//TodayHistory
    case upcoming
    case topRated = "top_rated"
    case popular
    
    var description: String {
        switch self {
            case .todayInHistory: return "Today in history"
            case .upcoming: return "Upcoming"
            case .topRated: return "Top Rated"
            case .popular: return "Popular"
        }
    }
}

//封装了几种fetch数据失败的原因
enum EventError: Error, CustomNSError {
    
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
    
}
