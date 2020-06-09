//
//  ActivityIndicatorView.swift
//  TodayInHistory-new
//
//  Created by Tom on 9/6/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

//Activity Indicator活动指标（转圈动画）

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
}
