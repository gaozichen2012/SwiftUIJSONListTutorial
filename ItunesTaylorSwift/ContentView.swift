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

//Response将存储结果数组。
struct Response: Codable {
    var results: [Result]
}

//Result将存储曲目ID，名称和所属专辑
struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

func loadData() {
    //1.Creating the URL we want to read.
guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
    print("Invalid URL")
    return
}
//2.Wrapping that in a URLRequest, which allows us to configure how the URL should be accessed.
let request = URLRequest(url: url)
//3.Create and start a networking task from that URL request.
URLSession.shared.dataTask(with: request) { data, response, error in
if let data = data {
    //4.Handle the result of that networking task.
    if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
        // we have good data – go back to the main thread
        DispatchQueue.main.async {
            // update our UI
            self.results = decodedResponse.results
        }

        // everything is good, so we can exit
        return
    }
}

// if we're still here it means there was a problem
print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
}.resume()
}

struct ContentView: View {
    @State private var results = [Result]()

    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
            .onAppear(perform: loadData)
        }
    }
}





//符合Codable协议，以便能够从JSON File解码模型
//符合Identifiable协议，该协议允许在列表中列出项目。
struct Todo: Codable, Identifiable {
    public var id: Int
    public var title: String
    public var completed: Bool
}




class FetchToDo: ObservableObject {
    //1.  当Published将被更改时，将更新ContentView中的List。
    @Published var todos = [Todo]()
     
    init() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
         // 2.创建一个任务检索json文件的内容
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let todoData = data {
                    // 3.数据被解码为Todo项目数组，并分配给todos属性。
                    let decodedData = try JSONDecoder().decode([Todo].self, from: todoData)
                    DispatchQueue.main.async {
                        self.todos = decodedData
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

#if 1
struct ContentView: View {
    @State private var results = [Result]()

    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
    }
}
#endif

struct ContentView: View {
    // 1.fetch属性将观察FetchToDo类的更改
    @ObservedObject var fetch = FetchToDo()
    var body: some View {
        VStack {
            // 2.List创建一个包含待办事项的列表
            List(fetch.todos) { todo in
                VStack(alignment: .leading) {
                    // 3.标题和完成的字段将显示在列表中
                    Text(todo.title)
                    Text("\(todo.completed.description)") // print boolean
                        .font(.system(size: 11))
                        .foregroundColor(Color.gray)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
