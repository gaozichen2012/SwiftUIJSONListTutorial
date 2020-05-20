//
//  ContentView.swift
//  TodayInHistory
//
//  Created by Tom on 20/5/2020.
//  Copyright © 2020 Tom. All rights reserved.
//
import SwiftUI
import Foundation
import Combine

//不知道哪里出了问题，调试的警告是如下，可能是获取不到该网址的数据，Xcode需要设置，也有可能是Data Model有问题
//2020-05-20 23:54:17.616292+0800 TodayInHistory[3565:121026] Task <B9FEC6EA-73BA-4669-B731-224370CC09A0>.<1> finished with error [-1022] Error Domain=NSURLErrorDomain Code=-1022 "The resource could not be loaded because the App Transport Security policy requires the use of a secure connection." UserInfo={NSUnderlyingError=0x6000019af330 {Error Domain=kCFErrorDomainCFNetwork Code=-1022 "(null)"}, NSErrorFailingURLStringKey=http://api.juheapi.com/japi/toh?v=1.0&month=5&day=20&key=f16083ccb0da9bce187582cab895c060, NSErrorFailingURLKey=http://api.juheapi.com/japi/toh?v=1.0&month=5&day=20&key=f16083ccb0da9bce187582cab895c060, NSLocalizedDescription=The resource could not be loaded because the App Transport Security policy requires the use of a secure connection.}
//No data
//Message from debugger: Terminated due to signal 15
#if false
//Response将存储结果数组。
struct Response: Codable {
    public var results: [Result]
}

//Result将存储曲目ID，名称和所属专辑
struct Result: Codable, Identifiable {
    public var id: Int
    public var trackName: String
    public var collectionName: String
    
    //Identifiable必须要一个id，此时就需要CodingKey将trackId转为id
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case trackName = "trackName"
        case collectionName = "collectionName"
    }
}

class FetchEventList: ObservableObject {
    @Published var results = [Result]()
    
    init() {
        let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song")!
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
                            self.results = decodedResponse.results
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
        List(fetch.results, id: \.id)  { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
    }
}

#else
//Response将存储结果数组。
struct Response: Codable {
    public var result: [Result]
}

//Result将存储曲目ID，名称和所属专辑
struct Result: Codable, Identifiable {
    public var id: String
    public var title: String
    public var pic: String
    public var year: Int
    public var month: Int
    public var day: Int
    public var des: String
    public var lunar: String
    
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

class FetchEventList: ObservableObject {
    @Published var result = [Result]()
    
    init() {
        let url = URL(string: "http://api.juheapi.com/japi/toh?v=1.0&month=5&day=20&key=f16083ccb0da9bce187582cab895c060")!
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
                            self.result = decodedResponse.result
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
        List(fetch.result, id: \.id)  { item in
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                Text(item.des)
            }
        }
    }
}
#endif




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
