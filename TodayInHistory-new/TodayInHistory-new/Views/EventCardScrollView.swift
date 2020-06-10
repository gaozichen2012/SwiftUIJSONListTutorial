//
//  EventCardScrollView.swift
//  TodayInHistory-new
//
//  Created by Tom on 8/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

//

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

             ScrollView {
                VStack(spacing: 16) {
                    ForEach(self.events) { event in
                        NavigationLink(destination: EventDetailView()) {
                            EventCard(event: event)
                                .frame(width: 272)
                            //Text(event.pic!)
                        }
                        .buttonStyle(PlainButtonStyle())
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

