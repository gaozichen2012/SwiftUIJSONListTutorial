//
//  ContentView.swift
//  ItunesTaylorSwift
//
//  Created by Tom on 19/5/2020.
//  Copyright © 2020 Tom. All rights reserved.
//
import SwiftUI
import Foundation
import Combine
import URLImage

//Response将存储结果数组。
struct Response: Codable {
    public var results: [Result]
}

//Result将存储曲目ID，名称和所属专辑
struct Result: Codable, Identifiable {
    public var id: Int
    public var trackName: String
    public var collectionName: String
    public var artworkUrl100: String
    
    //Identifiable必须要一个id，此时就需要CodingKey将trackId转为id
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case trackName
        case collectionName
        case artworkUrl100
    }
}

struct ContentView: View {
    @ObservedObject var fetch = FetchAlbumList()
    
    var body: some View {
        List(fetch.results)  { item in
            VStack(alignment: .leading) {
                HStack {
                    URLImage(URL(string: item.artworkUrl100)!,delay: 5)
                    VStack(alignment: .leading) {
                        Text(item.trackName)
                            .font(.headline)
                        Text(item.collectionName)
                    }
                }
            }
            .padding(.vertical)
        }
    }
}

class FetchAlbumList: ObservableObject {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

