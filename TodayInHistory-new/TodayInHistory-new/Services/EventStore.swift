//
//  EventStore.swift
//  TodayInHistory-new
//
//  Created by Tom on 8/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//


//EventService的具体实施：在 EventStore class中进行实际的URL JSON解码

import Foundation

//获取1种格式的JSON数据：
//"http://api.juheapi.com/japi/toh?v=1.0&month=5&day=20&key=f16083ccb0da9bce187582cab895c060"
//https://api.themoviedb.org/3/movie/now_playing?api_key=a7532a23ae5813193ebd13ba4de76cf2
//https://api.themoviedb.org/3/movie/550?api_key=a7532a23ae5813193ebd13ba4de76cf2
//https://api.themoviedb.org/3/search/movie?language=en-US&include_adult=false&region=US&query=green&api_key=a7532a23ae5813193ebd13ba4de76cf2


class EventStore: EventService {
    
    static let shared = EventStore()
    private init() {}
    
    private let apiKey = "f16083ccb0da9bce187582cab895c060"
    private let baseAPIURL = "http://api.juheapi.com"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder

    //取得电影列表数据
    func fetchEvents(from endpoint: EventListEndpoint, completion: @escaping (Result<EventResponse, EventError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/japi/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    

    //定义了一个泛型函数用于加载URL和解码（使用了 URLComponents 和 URLQueryItem ）
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, EventError>) -> ()) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, EventError>, completion: @escaping (Result<D, EventError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}


