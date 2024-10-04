We need an array of different countries and an integer storing which answer is correct
```
var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
var correctAnswer = Int.random(in: 0...2)
```

Inside our body, we need to lay out our game prompt in a vertical stack, so let’s start with that:
```
var body: some View {
    VStack {
        Text("Tap the flag of")
        Text(countries[correctAnswer])
    }
}
```

THe stack created which holds two text has no spacing so we need to create another vstack outer this so that we can have spacing between the text and the buttons so:
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

As we need a background color, so placing a zstack outer these vstacks and writing code for blue background will help.
```
var body: some View {
    ZStack {
        Color.blue
          .ignoreSafeArea()
        // previous VStack code
    }
}
```
