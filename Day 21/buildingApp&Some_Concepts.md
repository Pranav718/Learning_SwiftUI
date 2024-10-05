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

We will use shuffled() function so that the countries will be shuffled every time before calling
```
var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
```

```
@State private var showingScore = false

@State private var scoreTitle = ""
```

To see if the button tapped is right or not we use the following function
```
func flagTapped(_ number: Int) {
    if number == correctAnswer {
        scoreTitle = "Correct"
    } else {
        scoreTitle = "Wrong"
    }

    showingScore = true
}
```

Now replace the "\\ flag was tapped" button with calling the function
```
flagTapped(number)
```

Now we’re going to write an askQuestion() method that resets the game by shuffling up the countries and picking a new correct answer:
```
func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
}
```

Now we need to change the variables "countries" and "correctAnswer" to @State private var variables
```
@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
@State private var correctAnswer = Int.random(in: 0...2)
```

Now we’re ready to show the alert. This needs to:

1. Use the alert() modifier so the alert gets presented when showingScore is true.
2. Show the title we set in scoreTitle.
3. Have a dismiss button that calls askQuestion() when tapped.

So put the alert modifier at the end of the Zstack in the body property
```
.alert(scoreTitle, isPresented: $showingScore) {
    Button("Continue", action: askQuestion)
} message: {
    Text("Your score is ???")
}
```












