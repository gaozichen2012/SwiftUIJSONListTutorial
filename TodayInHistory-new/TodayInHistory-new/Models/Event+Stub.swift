//
//  Event+Stub.swift
//  TodayInHistory-new
//
//  Created by Tom on 8/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

import Foundation

//从本地的Resources文件夹movie_list.json文件中获取数据（用于一些卡片视图的直接预览）
extension Event {
    
    static var stubbedEvents: [Event] {
        let response: EventResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_list")
        return response!.result
    }
    
    static var stubbedMovie: Event {
        stubbedEvents[0]
    }
}

//封装一个本地解码器
extension Bundle {
    
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}
