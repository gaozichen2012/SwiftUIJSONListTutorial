//
//  ContentView.swift
//  SwiftUIJSONListTutorial
//
//  Created by Arthur Knopper on 18/02/2020.
//  Copyright © 2020 Arthur Knopper. All rights reserved.
//

import SwiftUI
import Foundation
import Combine

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
