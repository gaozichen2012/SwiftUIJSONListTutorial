//
//  EventCard.swift
//  TodayInHistory-new
//
//  Created by Tom on 8/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

import SwiftUI
//import URLImage

struct EventCard: View {
    let event: Event
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                
                if self.imageLoader.image != nil {
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                }
                
                //URLImage(URL(string: "http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200405/20/9402433357.jpg")!)
                //                URLImage(URL(string: event.pic!)!)
                
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(20)
            .shadow(radius: 10)
            
            HStack {
                Text("\(event.year)")
                Text(event.title)
            }
        }
        .lineLimit(2)
        .onAppear {
            //首次刷新时将图片信息传给imageLoader
            self.imageLoader.loadImage(with: URL(string: self.event.picture)!)
        }
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard(event: Event.stubbedEvent)
    }
}
