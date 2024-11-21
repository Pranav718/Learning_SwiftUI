1. Replaced each VStack with Section.
 ```
   Section(){
       Text("When do you want to wake up?")
           .font(.headline)
            DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
  }

 Section(){
     Text("Desired amount of sleep")
         .font(.headline)
     Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
 }

 Section(){
     Text("Amount of coffee intake")
        .font(.headline)
     Picker("Number of cups", selection: $coffeeAmount){
         ForEach(0...5,id: \.self){ number in
             Text("\(number) \(number == 1 || number == 0 ? "cup" : "cups")")
         }
     }
 }
 ```

2. Replaced number of cups stepper to a picker showing same range of values
   ```
   Picker("Number of cups", selection: $coffeeAmount){
       ForEach(0...5,id: \.self){ number in
           Text("\(number) \(number == 1 || number == 0 ? "cup" : "cups")")
       }
   }
   ```

3. Changed the UI so that it shows recommended bedtime using a nice and large font, by placing the calculateBedTime() function's code inside a variable which would return String.
```
var calculateBedtime: String{
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0)*60*60
            let minute = (components.minute ?? 0)*60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
        }catch{
            return "Sorry, There was a problem calculating your bedtime."
        }
    }
```

And then making a section on which we would display the sleep time in a large bold font:
```
Section("Your recommended bedtime is") {
          Text(calculateBedtime)
              .font(.largeTitle)
              .fontWeight(.bold)
}
```




