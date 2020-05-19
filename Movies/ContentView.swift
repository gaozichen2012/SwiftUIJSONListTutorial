//
//  ContentView.swift
//  SwiftUIJSONListTutorial
//
//  Created by Tom on 18/5/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

import SwiftUI
import Foundation
import Combine 

//符合Codable协议，以便能够从JSON File解码模型
//符合Identifiable协议，该协议允许在List中列出项目。
struct Movie: Codable, Identifiable {
    public var id: Int
    public var name: String
    public var released: String
    
    enum CodingKeys: String, CodingKey {
           case id = "id"
           case name = "title"
           case released = "year"
        }
}

//创建MovieFetcher class，该class将会加载JSON文件并解码
public class MovieFetcher: ObservableObject {

    @Published var movies = [Movie]()
    
    init(){
        load()
    }
    
    //load()方法从网络异步获取JSON数据，一旦数据加载完毕，我们便将其分配给movies。
    func load() {
        let url = URL(string: "https://gist.githubusercontent.com/rbreve/60eb5f6fe49d5f019d0c39d71cb8388d/raw/f6bc27e3e637257e2f75c278520709dd20b1e089/movies.json")!
    
        URLSession.shared.dataTask(with: url) {(data,response,error) in
            do {
                if let d = data {
                    let decodedLists = try JSONDecoder().decode([Movie].self, from: d)
                    DispatchQueue.main.async {
                        self.movies = decodedLists
                    }
                }else {
                    print("No Data")
                }
            } catch {
                print ("Error")
            }
            
        }.resume()
         
    }
}

struct FetchView: View {
    @ObservedObject var fetcher = MovieFetcher()
    
    var body: some View {
        VStack {
            List(fetcher.movies) { movie in
                VStack (alignment: .leading) {
                    Text(movie.name)
                    Text(movie.released)
                        .font(.system(size: 11))
                        .foregroundColor(Color.gray)
                }
            }
        }
    }
}