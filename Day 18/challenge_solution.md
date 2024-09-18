1. Add a header to the third section, saying “Amount per person”
```
Section("Amount per person"){
    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
}
```

   
2. Add another section showing the total amount for the check – i.e., the original amount plus tip value, without dividing by the number of people.

First, we have to create a variable to store original amount plus tip value which returns as a double.
```
var totalAmountForCheck : Double {
        let tips = Double(tipPercentage)
        let total = checkAmount + checkAmount/100 * tips
        return total
}
```

Then, we have to add another section after the third section in which we would show the total amount for check.
```
Section("Total amount for check") {
    Text(totalAmountForCheck, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
}
```


3. Change the tip percentage picker to show a new screen rather than using a segmented control, and give it a wider range of options – everything from 0% to 100%. Tip: use the range 0..<101 for your range rather than a fixed array.

To show a new screen rather than a segmented control, we have to use navigationLink in pickerStyle.
And to give a wide range of options , we can loop from 0..<101 and hence the use of tipPercentage array will not be useful anymore.

Here's both of the points in code:
```
Section("How much do you want to tip?"){
    Picker("Tip percentage" ,selection: $tipPercentage){
        ForEach(0..<101){
            Text($0, format: .percent)
        }
    }
    //.pickerStyle(.segmented)
    .pickerStyle(.navigationLink)
}
```







   
