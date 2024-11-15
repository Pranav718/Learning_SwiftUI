We start by adding three properties that let us store the information for those controls:
```
@State private var wakeUp = Date.now
@State private var sleepAmount = 8.0
@State private var coffeeAmount = 1
```

Inside our body property, changing our UI,
```
NavigationStack {
    VStack {
        Text("When do you want to wake up?")
            .font(.headline)

        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
            .labelsHidden()

        // more to come
    }
}
```
We’ve asked for .hourAndMinute configuration because we care about the time someone wants to wake up and not the day, and with the labelsHidden() modifier we don’t get a second label for the picker – the one above is more than enough.

Adding this code in place of the // more to come comment,
```
Text("Desired amount of sleep")
    .font(.headline)

Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
```
what the above code does is asks user for desired amount of sleep they need, Giving them a range of 4 to 12 hours with a step value of 25 minutes, and formatted() method so we see numbers like “8” and not “8.000000”.

Now a stepper for asking how many cup of coffee they drink
```
Text("Daily coffee intake")
    .font(.headline)

Stepper("\(coffeeAmount) cup(s)", value: $coffeeAmount, in: 1...20)
```
The final thing we need is a button to let users calculate the best time they should go to sleep. We could do that with a simple button at the end of the VStack, but I think it works better to add a button directly to the navigation bar.

First we need a method for the button to call, so add an empty calculateBedtime() method like this:
```
func calculateBedtime() {
}
```

Now we need to use the toolbar() modifier to add a button to the navigation bar. While we’re here, we might as well also use navigationTitle() to put some text at the top.

adding these modifiers to the VStack:
```
.navigationTitle("BetterRest")
.toolbar {
    Button("Calculate", action: calculateBedtime)
}
```

Tip: Our button will automatically be placed in the top-right corner for left-to-right languages such as English, but will automatically move to the other side for right-to-left languages.

