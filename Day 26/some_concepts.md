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
As our project this time introduces us to machine learning methods , here are some of the things I thought we should know,

On-device machine learning is surprisingly easy thanks to two Apple frameworks: Core ML, and Create ML. The first of those lets us make apps using machine learning, and the second lets us create custom machine learning models of our own using a dedicated Create ML app that makes the whole process drag and drop. As a result of all this work, it’s now within the reach of anyone to add machine learning to their app.

In this instance we are going to look at tabular regression which is a fancy name which means  that we can throw a load of spreadsheet-like data at Create ML and ask it to figure out the relationship between various values.

Machine learning is done in two steps: we train the model, then we ask the model to make predictions. 
Training is the process of the computer looking at all our data to figure out the relationship between all the values we have, and in large data sets it can take a long time – easily hours, potentially much longer. Prediction is done on device: we feed it the trained model, and it will use previous results to make estimates about new data.

For the training process:
Open XCode->XCode menu->Open Developer Tool->Create ML->Click new document->Tabular Regression->name your project->select your desktop

The first step is to provide Create ML with some training data. This is the raw statistics for it to look at, which in our case consists of four values: when someone wanted to wake up, how much sleep they thought they liked to have, how much coffee they drink per day, and how much sleep they actually need.

Paul has already provided this data for us in BetterRest.csv,which could be obtained from his github profile, which is in the project files for this project. This is a comma-separated values data set that Create ML can work with, and our first job is to import that.

So, in Create ML look under Data and select “Select…” under the Training Data title. When we press “Select…” again it will open a file selection window, and we should choose BetterRest.csv.

Important: This CSV file contains sample data for the purpose of this project, and should not be used for actual health-related work.









