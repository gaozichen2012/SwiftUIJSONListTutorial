//
//  events.swift
//  TodayInHistory-new
//
//  Created by Tom on 8/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

//图片解析失败的原因是JSON数据值为""空字符串，而不是nil，所以需要通过==""判断，再调用

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
    
    //补全横幅卡片图片的http头
    var pictureURL: URL {
        return URL(string: "\(pic ?? "http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200405/20/9402433357.jpg")")!
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
