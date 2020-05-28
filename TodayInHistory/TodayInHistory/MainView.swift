//
//  MainView.swift
//  TodayInHistory
//
//  Created by Tom on 28/5/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

import SwiftUI
//现在传入月日参数后，在获取接口的数据的逻辑没弄明白，明天研究
//这个问题可以分类：一个是初始化时获取数据，另一个是触发获取数据
struct MainView: View {
    @State var show = false
    @State var month = ""
    @State var day = ""
    
    var body: some View {
        ZStack {
            VStack {
                TextField("输入月份",text:$month)
                TextField("输入日期",text:$day)
                InputView(show: $show)
            }
            .animation(.spring())
            ContentView(show: $show, month: $month, day: $day)
                .animation(.easeInOut(duration: 2))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
