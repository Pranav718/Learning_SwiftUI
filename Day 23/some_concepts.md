SwiftUI relies very heavily on a Swift power feature called “opaque return types”, which you can see in action every time you write some View. This means “one object that conforms to the View protocol, but we don’t want to say what.”

using "some View" is important for performance: SwiftUI needs to be able to look at the views we are showing and understand how they change, so it can correctly update the user interface. If SwiftUI didn’t have this extra information, it would be really slow for SwiftUI to figure out exactly what changed – it would pretty much need to ditch everything and start again after every small change.

The View protocol has an associated type attached to it, which is Swift’s way of saying that View by itself doesn’t mean anything – we need to say exactly what kind of view it is.

It’s not allowed to write a view like this:
```
struct ContentView: View {
    var body: View {
        Text("Hello, world!")
    }
}
```

It is perfectly legal to write a view like this:
```
struct ContentView: View {
    var body: Text {
        Text("Hello, world!")
    }
}
```

Many modifiers can be applied to containers, which allows us to apply the same modifier to many views at the same time.
For example, if we have four text views in a VStack and want to give them all the same font modifier, we could apply the modifier to the VStack directly and have that change apply to all four text views:

VStack {
    Text("Gryffindor")
    Text("Hufflepuff")
    Text("Ravenclaw")
    Text("Slytherin")
}
.font(.title)

This is called an environment modifier, and is different from a regular modifier that is applied to a view.
From a coding perspective these modifiers are used exactly the same way as regular modifiers. However, they behave subtly differently because if any of those child views override the same modifier, the child’s version takes priority.
As an example, this shows our four text views with the title font, but one has a large title:

VStack {
    Text("Gryffindor")
        .font(.largeTitle)
    Text("Hufflepuff")
    Text("Ravenclaw")
    Text("Slytherin")
}
.font(.title)

There, font() is an environment modifier, which means the Gryffindor text view can override it with a custom font.
However, this applies a blur effect to the VStack then attempts to disable blurring on one of the text views:

VStack {
    Text("Gryffindor")
        .blur(radius: 0)
    Text("Hufflepuff")
    Text("Ravenclaw")
    Text("Slytherin")
}
.blur(radius: 5)

If we have a property that could be either true or false, we can use that to control the foreground style of a button like this:

```
struct ContentView: View {
    @State private var useRedText = false

    var body: some View {
        Button("Hello World") {
            // flip the Boolean between true and false
            useRedText.toggle()            
        }
        .foregroundStyle(useRedText ? .red : .blue)
    }
}
```

This kind of code might look the same, but it’s actually less efficient:
```
var body: some View {
    if useRedText {
        Button("Hello World") {
            useRedText.toggle()
        }
        .foregroundStyle(.red)
    } else {
        Button("Hello World") {
            useRedText.toggle()
        }
        .foregroundStyle(.blue)
    }
}
```
