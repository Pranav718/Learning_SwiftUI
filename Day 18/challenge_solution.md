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

4. Change the tip percentage picker to show a new screen rather than using a segmented control, and give it a wider range of options – everything from 0% to 100%. Tip: use the range 0..<101 for your range rather than a fixed array.
