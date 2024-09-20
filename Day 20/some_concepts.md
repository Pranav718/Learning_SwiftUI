In swiftui , we prefer to use leading for left and trailing for right
```
VStack(alignment: .leading, spacing: 15) {
            Spacer()
            Text("Hello World!")
            Text("This is inside a VStack.")
            Spacer()
            Spacer()
        }
```
        
Spacer in Vstack if is below then sends the text upwards like a spring and if its written upwards then sends the text downwards like spring
Spacer in Hstack if is below then sends the text leftwards like a spring and if its written upwards then sends the text rightwards like spring

ZStack doesn’t have the concept of spacing because the views overlap, but it does have alignment. So, if we have one large thing and one small thing inside our ZStack, we can make both views align to the top like this: 
```
ZStack(alignment: .top)
```

```
ZStack(alignment: .top) {
     Text("Hello World!")               
     Text("This is inside a ZStack.")    //after assigning alignment to top,hello world text will be in background and the latter text above it like a copyright thumbnail
    }
```

```
ZStack{
            ZStack {
                Color(red: 1, green: 0.8, blue: 0)
                    .frame(width: 545, height: .infinity)
                Color.black
                    .frame(width : 345)
                Color.red
                    .frame(width: 245)
                Color.black
                    .frame(width : 145)
                Color(red: 1, green: 0.8, blue: 0)
                    .frame(width: 45)
                
                Color.black
                    .frame(height : 345)
                Color(red: 1, green: 0.8, blue: 0)
                    .frame(height: 45)
                Color.black
                    .frame(height : 345)
                Color(red: 1, green: 0.8, blue: 0)
                    .frame(height: 245)
                Color.black
                    .frame(height : 145)
                Color.red
                    .frame(height: 55)

                
                
                
                Text("Your content")
            }
            
        }
        .ignoresSafeArea()
```

.ignoreSafeArea() puts the color above dynamic island as well as in left out areas where we couldn't fill the colors before.

```
ZStack {
    Text("Your content")
}
.background(.red)
```
That might have done what we expected, but there’s a good chance it was a surprise: only the text view had a background color, even though we’ve asked the whole ZStack to have it.

If we want to fill in red the whole area behind the text, we should place the color into the ZStack – treat it as a whole view, all by itself:
```
ZStack {
    Color.red
    Text("Your content")
}
```

Colors automatically take up all the space available, but we can also use the frame() modifier to ask for specific sizes. For example, we could ask for a 200x200 red square like this:
```
Color.red
    .frame(width: 200, height: 200)
```

```
Color.red
    .frame(minWidth: 200, maxWidth: .infinity, maxHeight: 200)
```

If we need something specific, we can create custom colors by passing in values between 0 and 1 for red, green, and blue, like this:
```
Color(red: 1, green: 0.8, blue: 0)
```

Semantic colors: colors that don’t say what hue they contain, but instead describe their purpose.
For example, Color.primary is the default color of text in SwiftUI, and will be either black or white depending on whether the user’s device is running in light mode or dark mode. There’s also Color.secondary, which is also black or white depending on the device, but now has slight transparency so that a little of the color behind it shines through.


**Gradients**
Gradients are made up of several components:
   An array of colors to show 
   Size and direction information 
   The type of gradient to use 

For example, a linear gradient goes in one direction, so we provide it with a start and end point like this:
```
LinearGradient(colors: [.white, .black], startPoint: .top, endPoint: .bottom)
```

Tip: Swift knows we’re creating gradient stops here, so as a shortcut we can just write .init rather than Gradient.Stop, like this:
```
LinearGradient(stops: [
    .init(color: .white, location: 0.45),
    .init(color: .black, location: 0.55),
], startPoint: .top, endPoint: .bottom)
```

For RadialGradient and AngularGradient, one example is enough to grasp its functionality: 
```
RadialGradient(colors: [.blue, .black], center: .center, startRadius: 20, endRadius: 200)
```
```
AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
```

**Buttons**

Simplest way of making one: 
```
Button("Delete selection") {
    print("Now deleting…")
}
```

It could take any function as argument too rather than using a closure for ex:-
```
Button(“Delete selection”, action: executedelete() )
func executedelete(){
	print(“Deleting now . . .”)
}
```

We could say that our Delete button has a destructive role like this:
```
Button("Delete selection", role: .destructive, action: executeDelete)
```

We can use one of the built-in styles for buttons: .bordered and .borderedProminent. These can be used by themselves, or in combination with a role:
```
VStack {
    Button("Button 1") { }
        .buttonStyle(.bordered)
    Button("Button 2", role: .destructive) { }
        .buttonStyle(.bordered)
    Button("Button 3") { }
        .buttonStyle(.borderedProminent)
    Button("Button 4", role: .destructive) { }
        .buttonStyle(.borderedProminent)
}
```

If we want to customize the colors used for a bordered button, use the tint() modifier like this:
```
Button("Button 3") { }
    .buttonStyle(.borderedProminent)
    .tint(.mint)
```

If we want something completely custom, we can pass a custom label using a second trailing closure:
```
Button {
    print("Button was tapped")
} label: {
    Text("Tap me!")
        .padding()
        .foregroundStyle(.white)
        .background(.red)
}
```











