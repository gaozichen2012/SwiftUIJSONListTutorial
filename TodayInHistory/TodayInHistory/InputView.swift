//
//  InputView.swift
//  TodayInHistory
//
//  Created by Tom on 28/5/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

import SwiftUI

struct InputView: View {
    @Binding var show : Bool

    var body: some View {
        VStack {
            Button(action: {self.show.toggle()}){
                Text("提交")
                .scaleEffect(show ? 1.5 : 1)
            }
        }
        .padding(.all)
    }
}

//struct InputView_Previews: PreviewProvider {
//    static var previews: some View {
//        InputView(show: <#Binding<Bool>#>)
//    }
//}
