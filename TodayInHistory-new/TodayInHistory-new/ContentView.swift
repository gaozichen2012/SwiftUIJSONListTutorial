//
//  ContentView.swift
//  TodayInHistory-new
//
//  Created by Tom on 8/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

//Tabbed View

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            EventListView(query: "2")
                .tabItem {
                    VStack {
                        Image(systemName: "tv")
                        Text("Movies")
                    }
            }
            .tag(0)
            
            EventListView(query: "3")
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
            }
            .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
