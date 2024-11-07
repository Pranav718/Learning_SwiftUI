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

Now we are modifying our backround from blue to a linear gradient so that the background looks clean and any flag with blue colour would stand out
replacing:
```
Color.blue
    .ignoredSafeArea()
```

to:
```
LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
    .ignoresSafeArea()
```

Now using font() modifier to select built in size from iOS and weight() modifier for semi bold, bold or any weight type .
Adding this after:
```
Text("Tap the flag of")
    .font(.subheadline.weight(.heavy)))
```
And 
```
Text(countries[correctAnswer])
    .font(.largeTitle.weight(.bold))
```

Now Making our image capsule shaped is as easy as adding the .clipShape(.capsule) modifier and a shadow modifier to stand out, like this:
```
Image(countries[number])
    .clipShape(.capsule)
    .shadow(radius: 5)
```

Now in order to make our UI more nice, we are replacing lineargradient color with a radial gradient color with start radius and end radius
```
RadialGradient(stops: [
    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
], center: .top, startRadius: 200, endRadius: 700)
    .ignoresSafeArea()
```

We reduce the vstack spacing from 30 to 15 because we want to make it a colored rectangle with rounded edges so that part of the game stands out on the screen.

To do that, add these modifiers to the end of the same VStack:
```
.frame(maxWidth: .infinity)
.padding(.vertical, 20)
.background(.regularMaterial)
.clipShape(.rect(cornerRadius: 20))
```

Our next step is to add a title before our main box, and a score placeholder after. This means another VStack around what we have so far, because the existing VStack(spacing: 15) we have is where we apply the material effect.

So, we wrap our current VStack in a new one with a title at the top, like this:
```
VStack {
    Text("Guess the Flag")
        .font(.largeTitle.weight(.bold))
        .foregroundStyle(.white)

    // that VStack(spacing: 15) code
}
```

Tip:  Asking for bold fonts is so common there’s actually a small shortcut: 
```
.font(.largeTitle.bold()).
```

We  also slot in a score label at the bottom of that new VStack, like this:
```
Text("Score: ???")
    .foregroundStyle(.white)
    .font(.title.bold())
```

For the white “Tap the flag of”, we can have that use the iOS vibrancy effect to let a little of the background color shine through. Change its foregroundStyle() modifier to this:
```
.foregroundStyle(.secondary)
```

There are four spacers we have to add:
    One, directly before the “Guess the Flag” title.
    Two, directly before the “Score: ???” text.
    Third, And one directly after the “Score: ???” text.

And a little padding around the VStack.









