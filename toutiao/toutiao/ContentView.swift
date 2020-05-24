//
//  ContentView.swift
//  toutiao
//
//  Created by Tom on 21/5/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

import SwiftUI
import Foundation
import Combine
import URLImage

//Response将存储结果数组。
struct Response: Codable {
    public var reason: String
    public var result: Result
    public var error_code: Int
}

struct Result: Codable {
    public var stat: String
    public var data: [Data]
}

//Result将存储曲目ID，名称和所属专辑
//url形式的字符串不需要做特殊处理
//解析失败的原因是因为有的成员无数据，需要对无数据的成员进行手动解析
struct Data: Codable, Identifiable {
    public var id: String
    public var title: String
    public var date: String
    public var category: String
    public var author_name: String
    public var url: String
    public var thumbnail_pic_s: String
    //    public var thumbnail_pic_s02: String
    //    public var thumbnail_pic_s03: String
    
    //Identifiable必须要一个id，此时就需要CodingKey将trackId转为id
    enum CodingKeys: String, CodingKey {
        case id = "uniquekey"
        case title //= "title"
        case date //= "date"
        case category
        case author_name
        case url
        case thumbnail_pic_s
        //        case thumbnail_pic_s02
        //        case thumbnail_pic_s03
    }
}

class FetchEventList: ObservableObject {
    @Published var newsData = [Data]()
    
    init() {
        let url = URL(string: "http://v.juhe.cn/toutiao/index?type=&key=60601f9d58d37f9a05bd2880c55f4d74")!
        //2.Wrapping that in a URLRequest, which allows us to configure how the URL should be accessed.
        let request = URLRequest(url: url)
        //3.Create and start a networking task from that URL request.
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    // 3.数据被解码为Todo项目数组，并分配给todos属性。
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                    DispatchQueue.main.async {
                        // update our UI
                        self.newsData = decodedResponse.result.data
                        print("Have data")
                    }
                } else {
                    print("No data")
                }
            } catch {
                print("Error")
            }
        }.resume()
    }
}

struct ContentView: View {
    @ObservedObject var fetch = FetchEventList()
    
    var body: some View {
        List(fetch.newsData)  { item in
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                Text(item.date)
                Text(item.category)
                Text(item.author_name)
                //                Text(item.url)
                //                Text(item.thumbnail_pic_s)
                URLImage(URL(string: item.thumbnail_pic_s)!,delay: 0.25)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
