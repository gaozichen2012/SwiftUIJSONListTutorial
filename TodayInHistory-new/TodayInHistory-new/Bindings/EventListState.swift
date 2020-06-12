//
//  EventListState.swift
//  TodayInHistory-new
//
//  Created by Tom on 9/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

//上连接EventListView，下连接 EventStore 的 fetchEvents 方法

import SwiftUI

#if true //添加日参数

class EventListState: ObservableObject {
    @Published var query = ""
    @Published var events: [Event]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?
    
    private var subscriptionToken: AnyCancellable?

    private let eventService: EventService
    
    init(eventService: EventService = EventStore.shared) {
        self.eventService = eventService
    }

    //在MovieSearchView中调用
    func startObserve() {
        guard subscriptionToken == nil else { return }
        
        self.subscriptionToken = self.$query
            .map { [weak self] text in
                self?.events = nil
                self?.error = nil
                return text
                
        }.throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] in self?.search(query: $0) }
    }

    //从EventStore中继承了 fetchEvents 方法获取数据
    //在onAppear中调用loadEvents时获取数据可以保证每次刷新是获取一次数据（不同于init时获取数据）
    func loadEvents(with endpoint: EventListEndpoint,query: String) {
        self.events = nil
        self.isLoading = true

        guard !query.isEmpty else {
            return
        }
        self.isLoading = true

        self.eventService.fetchEvents(from: endpoint, query: query) { [weak self] (result) in
            guard let self = self, self.query == query else { return }

            self.isLoading = false
            switch result {
            case .success(let response):
                self.events = response.result
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }

    deinit {
        self.subscriptionToken?.cancel()
        self.subscriptionToken = nil
    }
}

#else
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
#endif


