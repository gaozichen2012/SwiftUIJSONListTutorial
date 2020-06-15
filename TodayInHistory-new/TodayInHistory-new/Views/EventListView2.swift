//
//  EventListView2.swift
//  TodayInHistory-new
//
//  Created by Tom on 15/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

import SwiftUI

struct EventListView2: View {
    @State var day = ""
    let query: String
    //@ObservedObject告诉SwiftUI，这个对象是可以被观察的，里面含有被@Published包装了的属性。
    @ObservedObject private var todayInHistoryState = EventListState()
    
    var body: some View {
        VStack {
//             DatePicker(selection: $date, label: { Text("Date") })
//            .datePickerStyle(WheelDatePickerStyle())
//            Text("\(date)")
            TextField("input day", text: $day)
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
    }
}

struct EventListView2_Previews: PreviewProvider {
    static var previews: some View {
        EventListView2(query: "4")
    }
}
