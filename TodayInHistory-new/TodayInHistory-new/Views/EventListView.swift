//
//  EventListView.swift
//  TodayInHistory-new
//
//  Created by Tom on 9/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

//Tabview第一栏


import SwiftUI

struct EventListView: View {
    let query: String
    //@ObservedObject告诉SwiftUI，这个对象是可以被观察的，里面含有被@Published包装了的属性。
    @ObservedObject private var todayInHistoryState = EventListState()
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    if todayInHistoryState.events != nil {
                        EventCardScrollView(title: "Today in history", events: todayInHistoryState.events!)
                            .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                    } else {
                            LoadingView(isLoading: self.todayInHistoryState.isLoading, error: self.todayInHistoryState.error) {
                                self.todayInHistoryState.loadEvents2(query: self.query)
                        }
                    }
                }
                .navigationBarTitle("The EventDb")
            }
            .onAppear {
                //self.todayInHistoryState.loadEvents(with: .todayInHistory)
                self.todayInHistoryState.loadEvents2(query: self.query)
            }
        }
//        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//        .background(Color.yellow)
//        .cornerRadius(30)
////        .offset(y:show ? 50 : UIScreen.main.bounds.height-500)
//            .offset(y:show ? 50 :100)
//        .onTapGesture {
//            self.todayInHistoryState.loadEvents2(query: self.query)
//        }
        
    }
}
