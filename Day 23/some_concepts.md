SwiftUI relies very heavily on a Swift power feature called “opaque return types”, which you can see in action every time you write some View. This means “one object that conforms to the View protocol, but we don’t want to say what.”

using "some View" is important for performance: SwiftUI needs to be able to look at the views we are showing and understand how they change, so it can correctly update the user interface. If SwiftUI didn’t have this extra information, it would be really slow for SwiftUI to figure out exactly what changed – it would pretty much need to ditch everything and start again after every small change.

The View protocol has an associated type attached to it, which is Swift’s way of saying that View by itself doesn’t mean anything – we need to say exactly what kind of view it is.

it’s not allowed to write a view like this:
struct ContentView: View {
    var body: View {
        Text("Hello, world!")
    }
}
It is perfectly legal to write a view like this:
struct ContentView: View {
    var body: Text {
        Text("Hello, world!")
    }
}
