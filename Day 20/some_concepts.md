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

ZStack doesn’t have the concept of spacing because the views overlap, but it does have alignment. So, if we have one large thing and one small thing inside our ZStack, we can make both views align to the top like this: ZStack(alignment: .top)

