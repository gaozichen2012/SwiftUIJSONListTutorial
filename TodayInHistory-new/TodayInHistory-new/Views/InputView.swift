//
//  InputView.swift
//  TodayInHistory-new
//
//  Created by Tom on 15/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

import SwiftUI

struct InputView: View {
    @State var show = false
    @State var day = "1"
    var body: some View {
        ZStack {
            VStack {
                TextField("input day", text: $day)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: { self.show.toggle()}) {
                    VStack {
                        BottonView()
                        Spacer()
                    }
                }
                .sheet(isPresented: self.$show) { EventListView(query: self.day)}
                .animation(.spring())
            }
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}

//定义一个按钮
struct BottonView: View {
    var body: some View {
        VStack {
            Text("查询该日的历史事件")
        }
        .frame(width:200,height: 30)
        .background(Color.pink)
        .foregroundColor(.white)
        .cornerRadius(30)
    }
}
