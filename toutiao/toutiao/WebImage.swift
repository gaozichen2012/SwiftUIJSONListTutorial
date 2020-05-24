//
//  WebImage.swift
//  toutiao
//
//  Created by Tom on 24/5/2020.
//  Copyright © 2020 Tom. All rights reserved.
//

import SwiftUI
import Combine
#if true

#else
public class DataLoader: ObservableObject {

    public let objectWillChange = PassthroughSubject<Data,Never>()

    public private(set) var data = Data() {
        willSet {
            objectWillChange.send(newValue)
        }
    }

    private let resourseURL: URL?

    public init(resourseURL: URL?){
        self.resourseURL = resourseURL
    }

    public func loadImage() {
        guard let url = resourseURL else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data,_,_) in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                self.data = data
            }
        }   .resume()
    }
}

struct WebImage: View {

    @ObservedObject private var imageLoader: DataLoader

    public init(imageURL: URL?) {
        imageLoader = DataLoader(resourseURL: imageURL)
    }

    public var body: some View {
        if let uiImage = UIImage(data: self.imageLoader.data) {
            return AnyView(Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: ContentMode.fit))
        } else {
            return AnyView(Image(systemName: "ellipsis")
                            .onAppear(perform: { self.imageLoader.loadImage() }))
        }
    }
}
#endif

struct WebImage_Previews: PreviewProvider {
    static var previews: some View {
        WebImage()
    }
}
