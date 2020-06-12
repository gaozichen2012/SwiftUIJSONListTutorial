//
//  events.swift
//  TodayInHistory-new
//
//  Created by Tom on 8/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//


// JSON数据图片信息为空，导致解析失败（Xcode无法预览）
// 图片解析失败的原因是JSON数据值为""空字符串，而不是nil，所以需要通过==""判断，再调用
// 注意：此时无法通过==nil判断，或者是强制解包!

// 比如：有的pic为""，这时通过Data Model处理空图片数据，赋予一个默认值即可

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
    
    var picture: String {
        //如果获取的pic为空字符串，则给个默认图片（空字符串不是nil）
        if pic == "" {
            return "http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200405/20/9402433357.jpg"
        }else{
            return "\(pic!)"
        }
        
        
    }
}
