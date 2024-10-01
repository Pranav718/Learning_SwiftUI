 The basic UI structure will be two labels telling the user what to do, then three image buttons showing three world flags.

 First,  we should find the assets for this project and drag them into our asset catalog. 
 That means opening Assets.xcassets in Xcode, then dragging in the flag images from the project2-files folder (which is posted at sir's github account: @twostraws). 
 The images are named after their country, along with either @2x or @3x – these are images at double resolution and triple resolution to handle different types of iPhone screen.

 Next, we need two properties to store our game data: an array of all the country images we want to show in the game and an integer storing which country image is correct.

```
var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
var correctAnswer = Int.random(in: 0...2)
```

Inside our body, we need to lay out our game prompt in a vertical stack:
```
var body: some View {
    VStack {
        Text("Tap the flag of")
        Text(countries[correctAnswer])
    }
}
```

Now adding another vstack with a good spacing and making buttons inside another Vstack to have more control over it.
```
VStack(spacing: 30) {
    VStack {
        Text("Tap the flag of")
        Text(countries[correctAnswer])
    }

    ForEach(0..<3) { number in
        Button {
           // flag was tapped
        } label: {
            Image(countries[number])
        }
    }
}
```

Now we want to give it a blue background so we have to place a Zstack that would contain both of the vstacks- a vstack which is under another vstack which both are under zstack
var body: some View {
    ZStack {
        // previous VStack code
    }
}
