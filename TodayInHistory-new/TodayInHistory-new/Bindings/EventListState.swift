//
//  EventListState.swift
//  TodayInHistory-new
//
//  Created by Tom on 9/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

//上连接EventListView，下连接 EventStore 的 fetchEvents 方法

import SwiftUI

class EventListState: ObservableObject {
    
    @Published var events: [Event]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?
    
    private let eventService: EventService
    
    init(eventService: EventService = EventStore.shared) {
        self.eventService = eventService
    }
    //从EventStore中继承了 fetchEvents 方法获取数据
    //在onAppear中调用loadEvents时获取数据可以保证每次刷新是获取一次数据（不同于init时获取数据）
    func loadEvents(with endpoint: EventListEndpoint) {
        self.events = nil
        self.isLoading = true
        self.eventService.fetchEvents(from: endpoint) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.events = response.result
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
}



