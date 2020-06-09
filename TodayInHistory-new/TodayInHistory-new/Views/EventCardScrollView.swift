//
//  EventCardScrollView.swift
//  TodayInHistory-new
//
//  Created by Tom on 8/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

//此处预览有问题,可能是因为有的pic没图片，导致图片解码失败，可能要修改;明天尝试加打印信息测试哪里出问题了

import SwiftUI

struct EventCardScrollView: View {
    let title: String
    let events: [Event]
    
    var body: some View {

        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(self.events) { event in
                        NavigationLink(destination: Text("detail")) {
                            EventCard(event: event)
                                .frame(width: 272, height: 200)
//                            Text(event.pic!)
                        }
//                        .buttonStyle(PlainButtonStyle())
//                        .padding(.leading, event.id == self.events.first!.id ? 16 : 0)
//                        .padding(.trailing, event.id == self.events.last!.id ? 16 : 0)
                    }
                }
            }
        }

    }
}

struct EventCardScrollView_Previews: PreviewProvider {
    static var previews: some View {
        EventCardScrollView(title: "Latest", events: Event.stubbedEvents)
    }
}

