//
//  EventDetailView.swift
//  TodayInHistory-new
//
//  Created by Tom on 8/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

//完成EventDetail，使用了URLImage，明天尝试在APP中可以选择月日实时显示想要日期的事件

import SwiftUI
import URLImage

struct EventDetailView: View {
    let event: Event
    
    var body: some View {
        ZStack {
                MovieDetailListView(event: event)
        }
        .navigationBarTitle(event.title)
    }
}

struct MovieDetailListView: View {
    let event: Event
    
    var body: some View {
        List {
            //第一栏：横幅图片
            URLImage(URL(string: event.picture)!)
            //第二栏：电影类型+发行年份+电影时长
            HStack {
                Text("\(event.year)")
                Text("·")
                Text("\(event.month)")
                Text("·")
                Text("\(event.day)")
            }
            Text(event.lunar)
            
            //第三栏：概述
            Text(event.des)
            
            Divider()
            
            //第四栏：Starring主演+Director导演+Producer制片人+Screenwriter剧本作家
            
            
            //第五栏：Trailers预告片
        }
    }
}

struct MovieDetailImage: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(event: Event.stubbedEvent)
    }
}
