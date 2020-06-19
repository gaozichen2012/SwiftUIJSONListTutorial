//
//  ContentView.swift
//  01 Tap Me
//
//  Created by Florian Kugler on 31-01-2020.
//  Copyright © 2020 objc.io. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var counter = 0
    var body: some View {
        VStack {
            log("button准备工作")
            Button(action: { self.counter += 1 }, label: {
                Text("Tap me!")
                    .padding()
                    .background(Color(.tertiarySystemFill))
                    .cornerRadius(5)
            })
            
            if counter > 0 {
                Text("You've tapped \(counter) times")
                log("You've tapped \(counter) times")
            } else {
                Text("You've not yet tapped")
                log("You've not yet tapped")
            }
        }
    }
}

func log(_ log: String) -> EmptyView {
    print("打印测试： \(log)")
    return EmptyView()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
