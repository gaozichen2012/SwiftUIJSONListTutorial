//
//  EventCardScrollView.swift
//  TodayInHistory-new
//
//  Created by Tom on 8/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

//此处预览有问题，明天继续参考TMDB添加其他部分，晚上回来测试
//如果有问题，则替换

import SwiftUI

struct EventCardScrollView: View {
    let title: String
    let events: [Event]
    
    var body: some View {
        #if true
        Text(title)
        #else
        VStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.events) { event in
                        NavigationLink(destination: EventDetailView()) {
                            EventCard()
                                .frame(width: 272, height: 200)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, event.id == self.events.first!.id ? 16 : 0)
                        .padding(.trailing, event.id == self.events.last!.id ? 16 : 0)
                    }
                }
            }
        }
        #endif
    }
}

struct EventCardScrollView_Previews: PreviewProvider {
    static var previews: some View {
        EventCardScrollView(title: "Latest", events: Event.stubbedEvents)
    }
}
