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

Now we need to import coreML for the remaining tasks required to be done in project
```
import CoreML
```

Now we can turn to calculateBedtime(). First, we need to create an instance of the SleepCalculator class, like this:
```
func calculateBedTime(){
    do {
        let config = MLModelConfiguration()
        let model = try SleepCalculator(configuration: config)

        // more code here
    } catch {
        // something went wrong!
    }
}
```

We trained our model with a CSV file containing the following fields:

“wake”: when the user wants to wake up. This is expressed as the number of seconds from midnight, so 8am would be 8 hours multiplied by 60 multiplied by 60, giving 28800.
“estimatedSleep”: roughly how much sleep the user wants to have, stored as values from 4 through 12 in quarter increments.
“coffee”: roughly how many cups of coffee the user drinks per day.

We already have two of them, because our sleepAmount and coffeeAmount properties are mostly good enough – we just need to convert coffeeAmount from an integer to a Double so that Swift is happy.

But figuring out the wake time requires more thinking, because our wakeUp property is a Date not a Double representing the number of seconds. Helpfully, this is where Swift’s DateComponents type comes in: it stores all the parts required to represent a date as individual values, meaning that we can read the hour and minute components and ignore the rest. All we then need to do is multiply the minute by 60 (to get seconds rather than minutes), and the hour by 60 and 60 (to get seconds rather than hours).

We can get a DateComponents instance from a Date with a very specific method call: Calendar.current.dateComponents(). 
We can then request the hour and minute components, and pass in our wake up date. The DateComponents instance that comes back has properties for all its components – year, month, day, timezone, etc – but most of them won’t be set. The ones we asked for – hour and minute – will be set, but will be optional, so we need to unwrap them carefully.

replacing the //more code here with the following code:
```
let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
let hour = (components.hour ?? 0) * 60 * 60
let minute = (components.minute ?? 0) * 60
```

The next step is to feed our values into Core ML and see what comes out. This is done using the prediction() method of our model, which wants the wake time, estimated sleep, and coffee amount values required to make a prediction, all provided as Double values. We just calculated our hour and minute as seconds, so we’ll add those together before sending them in.

Adding this just below the previous code:
```
let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

// more code here
```

 prediction now contains how much sleep they actually need
 Now we need to show users how much sleep they actually need and we are going to do that with the help of alert modifier
 First adding these:
 ```
@State private var alertTitle = ""
@State private var alertMessage = ""
@State private var showingAlert = false
```

replace the // something went wrong comment with some code that sets up a useful error message:
```
alertTitle = "Error"
alertMessage = "Sorry, there was a problem calculating your bedtime."
```

Regardless of whether or not the prediction worked, we should show the alert. It might contain the results of their prediction or it might contain the error message, but it’s still useful. So, putting this at the end of calculateBedtime(), after the catch block:
```
showingAlert = true
```

Putting this directly after where we set the sleepTime constant:
```
alertTitle = "Your ideal bedtime is…"
alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
```

We’re going to add a computed property to our ContentView struct that contains a Date value referencing 7AM of the current day. This is surprisingly easy: we can just create a new DateComponents of our own, and use Calendar.current.date(from:) to convert those components into a full date.
```
var defaultWakeTime: Date {
    var components = DateComponents()
    components.hour = 7
    components.minute = 0
    return Calendar.current.date(from: components) ?? .now
}
```

And now we can use that for the default value of wakeUp in place of Date.now:
```
@State private var wakeUp = defaultWakeTime
```

We can make defaultWakeTime a static variable, which means it belongs to the ContentView struct itself rather than a single instance of that struct. This in turn means defaultWakeTime can be read whenever we want, because it doesn’t rely on the existence of any other properties.

So, change the property definition to this:
```
static var defaultWakeTime: Date {
```

Creating a form , 
```
NavigationStack {
    Form {
```

```
VStack(alignment: .leading, spacing: 0) {
    Text("Desired amount of sleep")
        .font(.headline)

    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
}
```

Writing "cup(s)" works, but it's a bit lazy. Ideally we'd show "1 cup", but "2 cups", "3 cups", and so on – we'd have correct plurals here.
We could correct that with a ternary operator like this:
```
Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cup(s)", value: $coffeeAmount, in: 1...20)
```


