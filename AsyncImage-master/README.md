## Article related to this project

- [Asynchronous Image Loading from URL in SwiftUI](https://www.vadimbulavin.com/asynchronous-swiftui-image-loading-from-url-with-combine-and-swift/).

---

# AsyncImage

The project demonstrates how to load images asynchronously in SwiftUI.

Usage:

```swift
// Image URLs to load
let posters = [
    "https://image.tmdb.org/t/p/original//pThyQovXQrw2m0s9x82twj48Jq4.jpg",
    "https://image.tmdb.org/t/p/original//vqzNJRH4YyquRiWxCCOH0aXggHI.jpg",
    "https://image.tmdb.org/t/p/original//6ApDtO7xaWAfPqfi2IARXIzj8QS.jpg",
    "https://image.tmdb.org/t/p/original//7GsM4mtM0worCtIVeiQt28HieeN.jpg"
].map { URL(string: $0)! }

struct ContentView: View {
    @Environment(\.imageCache) var cache: ImageCache

    var body: some View {
         List(posters, id: \.self) { url in
             AsyncImage(
                url: url,
                cache: self.cache,
                placeholder: Text("Loading ..."),
                configuration: { $0.resizable() }
             )
            .frame(idealHeight: UIScreen.main.bounds.width / 2 * 3) // 2:3 aspect ratio
         }
    }
}
```

Result:

<p align="center">
  <img src="https://github.com/V8tr/AsyncImage/blob/master/demo.gif" alt="How to load image from URL asynchronously in SwiftUI"/>
</p>