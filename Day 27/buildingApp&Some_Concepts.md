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
