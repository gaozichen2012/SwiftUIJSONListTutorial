//
//  EventCard.swift
//  TodayInHistory-new
//
//  Created by Tom on 8/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

import SwiftUI
import URLImage

struct EventCard: View {
    let event: Event

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                .fill(Color.gray.opacity(0.3))
                URLImage(URL(string: "http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200405/20/9402433357.jpg")!)
                HStack {
                    VStack(alignment: .leading) {
                        Text("title")
                        Spacer()
                    }
                    Spacer()
                }
                .padding([.top, .leading])
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(20)
            .shadow(radius: 10)
        }
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard()
    }
}
