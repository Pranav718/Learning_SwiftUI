Starting project 4: BetterSleep

SwiftUI has two ways of letting users enter numbers, and the one we’ll be using here is Stepper: a simple - and + button that can be tapped to select a precise number. The other option is Slider, which we’ll be using later on – it also lets us select from a range of values, but less precisely.

Ex:
```
Stepper(“\(amounthours) hours of sleep”, value: $amounthours)
```

As we have to provide a range to select the hours which a person sleeps , we can set a range using in statement
```
Stepper(“\(amounthours) hours of sleep”, value: $amounthours, in: 4…12)
```

As the precision of the numbers are just too long, we can make the shorter by using formatted command, we can also provide a step value which is originally 1
```
Stepper(“\(amounthours.formatted()) hours of sleep”, value: $amounthours , in: 4…12, step: 0.25)
```

SwiftUI gives us a dedicated picker type called DatePicker that can be bound to a date property. Yes, Swift has a dedicated type for working with dates, and it’s called – unsurprisingly – Date.

So, to use it you’d start with an @State property such as this:
```
@State private var wakeUp = Date.now
DatePicker("Please enter a date", selection: $wakeUp)
```

The date picker still makes space for a label even though it’s empty, and now users with the screen reader active (more familiar to us as VoiceOver) won’t have any idea what the date picker is for.

A better alternative is to use the labelsHidden() modifier, like this:
```
DatePicker("Please enter a date", selection: $wakeUp)
    .labelsHidden()
```


Use displayedComponents to decide what kind of options users should see:
If we don’t provide this parameter, users see a day, hour, and minute.
If we use .date users see month, day, and year.
If we use .hourAndMinute users see just the hour and minute components.
So, we can select a precise time like this:
```
DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
```

Now, we’ve been using ranges for a while now, and you’re used to seeing things like 1...5 or 0..<10, but we can also use Swift dates with ranges. For example:
```
func exampleDates() {
    // create a second Date instance set to one day in seconds from now
    let tomorrow = Date.now.addingTimeInterval(86400)  // 86400 seconds means one day,thus making date one day ahead (tommorow)

    // create a range from those two
    let range = Date.now...tomorrow
}
```
Swift lets us form one-sided ranges – ranges where we specify either the start or end but not both, leaving Swift to infer the other side.
For example, we could create a date picker like this:
```
DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
```
That will allow all dates in the future, but none in the past – read it as “from the current date up to anything.”
```
 func exampleDates(){
       var components = DateComponents()
       components.hour = 8
       components.minute = 0

}
```
DateComponents, which lets us read or write specific parts of a date rather than the whole thing.
So, if we wanted a date that represented 8am today, we could write code like this:
```
func exampleDate(){
    var components = DateComponents()
    components.hour = 8
    components.minute = 0
    let date = Calendar.current.date(from: components) ?? .now
}
```
To pull out (i.e to read) the time to wake up from user's response,we might write code like this:
```
let components = Calendar.current.dateComponents([.hour, .minute], from: .now)
let hour = components.hour ?? 0
let minute = components.minute ?? 0
```

The last challenge is how we can format dates and times, and here we have two options.

First, is to rely on the format parameter that has worked so well for us in the past, and here we can ask for whichever parts of the date we want to show.

For example, if we just wanted the time from a date we would write this:
```
Text(Date.now, format: .dateTime.hour().minute())
```
Or if we wanted the day, month, and year, we would write this:
```
Text(Date.now, format: .dateTime.day().month().year())
```
As an alternative, we can use the formatted() method directly on dates, passing in configuration options for how we want both the date and the time to be formatted, like this:
```
Text(Date.now.formatted(date: .long, time: .shortened))
```
