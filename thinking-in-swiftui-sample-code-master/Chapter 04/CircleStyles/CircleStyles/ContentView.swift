//
//  ContentView.swift
//  CircleStyles
//
//  Created by Chris Eidhof on 14.01.20.
//  Copyright © 2020 Chris Eidhof. All rights reserved.
//

import SwiftUI

//在view上扩展一个背景圆的方法
extension View {
    func tomBlueCircle(foreground: Color = .white, background: Color = .blue) -> some View {
        Circle()
            .fill(background)
            //            .overlay(Circle().strokeBorder(foreground).padding(3))
            .overlay(self.foregroundColor(foreground))
            .frame(width: 30, height: 30)
            .shadow(radius: 10)
    }
}

struct CircleModifier: ViewModifier {
    var foreground = Color.white
    var background = Color.blue
    func body(content: Content) -> some View {
        Circle()
            .fill(background)
//            .overlay(Circle().strokeBorder(foreground).padding(3))
            .overlay(content.foregroundColor(foreground))
            .frame(width: 30, height: 30)
            .shadow(radius: 10)
    }
}

struct CircleStyle: ButtonStyle {
    var foreground = Color.white
    var background = Color.blue
    
    func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        Circle()
            .fill(background.opacity(configuration.isPressed ? 0.8 : 1))
            .overlay(Circle().strokeBorder(foreground).padding(3))
            .overlay(configuration.label.foregroundColor(foreground))
            .frame(width: 75, height: 75)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    var body: some View {
        VStack(alignment: .trailing) {
            //使用自定义背景插件.tomBlueCircle()
            HStack {
                Text(".tomBlueCircle()（常用）")
                Text("按")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .shadow(radius: 5)
                    .tomBlueCircle()
                Image(systemName: "plus")
                    .shadow(radius: 5)
                    .tomBlueCircle()
            }
            
            //使用自定义的ViewModifier CircleModifier（不常用）
            HStack {
                Text(".modifier(CircleModifier())（不常用）")
                Text("按")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .shadow(radius: 5)
                    .modifier(CircleModifier())
                Image(systemName: "plus")
                    .shadow(radius: 5)
                    .modifier(CircleModifier())
            }
            
            HStack {
                Button(action: {}, label: { Text("One")})
                Button(action: {}, label: { Text("Two")})
                Button(action: {}, label: { Text("Three")})
            }
            .buttonStyle(CircleStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
