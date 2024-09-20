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


ZStack {
    Text("Your content")
}
.background(.red)

That might have done what you expected, but there’s a good chance it was a surprise: only the text view had a background color, even though we’ve asked the whole ZStack to have it.

If you want to fill in red the whole area behind the text, you should place the color into the ZStack – treat it as a whole view, all by itself:

ZStack {
    Color.red
    Text("Your content")
}


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








