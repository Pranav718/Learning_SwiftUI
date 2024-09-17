We need to add three @State properties, because there are three pieces of data we’re expecting users to enter into our app.

```
@State private var checkAmount = 0.0
@State private var numberOfPeople = 2
@State private var tipPercentage = 20
```

Fourth property to store the list of possible tip sizes :
```
let tipPercentages = [10, 15, 20, 25, 0]
```

Modify the body property to this:
```
Form {
    Section {
        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        .keyboardType(.decimalPad)
    }
}
```
This way, we can let the user enter amount in their preffered currency as, Locale is a massive struct built into iOS that is responsible for storing all the user’s region settings – what calendar they use, how they separate thousands digits in numbers, whether they use the metric system, and more. In our case, we’re asking whether the user has a preferred currency code, and if they don’t we’ll fall back to “USD” so at least we have something.

Text fields have a modifier that lets us force a different kind of keyboard: keyboardType(). We can give this a parameter specifying the kind of keyboard we want, and in this instance either .numberPad or .decimalPad are good choices. Both of those keyboards will show the digits 0 through 9 for users to tap on, but .decimalPad also shows a decimal point so users can enter check amount like $32.50 rather than just whole numbers.
That is the reason for adding .decimalPad

Pickers, like text fields, need a two-way binding to a property so they can track their value. We already made an @State property for this purpose, called numberOfPeople, so our next job is to loop over all the numbers from 2 through to 99 and show them inside a picker.

Modify the first section in your form to include a picker, like this:
```
Section {
    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        .keyboardType(.decimalPad)

    Picker("Number of people", selection: $numberOfPeople) {
        ForEach(2..<100) {
            Text("\($0) people")
        }
    }
}
```

The row says “4 people”, but we gave our numberOfPeople property a default value of 2. 
Well, it's because it treates the value of 2 like index so if we start a loop from 2 then it's 0th index would be 2,














