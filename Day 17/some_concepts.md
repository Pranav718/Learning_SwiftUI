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

We could add a second section with a text view showing the value of checkAmount, like this:
```
Form {
    Section {
        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        .keyboardType(.decimalPad)
    }

    Section {
        Text(checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
    }
}
```

Pickers, like text fields, need a two-way binding to a property so they can track their value. We already made an @State property for this purpose, called numberOfPeople, so our next job is to loop over all the numbers from 2 through to 99 and show them inside a picker.

Modifying the first section in our form to include a picker, like this:
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
Well, it's because it treates the value of 2 like index so if we start a loop from 2 then it's 0th index would be 2,... and the 2nd index would be 4.

One popular picker style is called navigation link, which moves the user to a new screen to select their option. To try it here, add the .pickerStyle(.navigationLink) modifier to our picker.

We need to add a navigation stack, which does two things: gives us some space across the top to place a title, and also lets iOS slide in new views as needed.

So, directly before the form add NavigationStack {, and after the form’s closing brace we have to add another closing brace. If we got it right, our code should look like this:
```
var body: some View {
    NavigationStack {
        Form {
            // everything inside our form
        }
    }
}
```

To add a title we use the following modifier just after closing braces of navigation stack: 
```
.navigationTitle("WeSplit")
```

Adding a third section to show tip percentages:
```
Section {
    Picker("Tip percentage", selection: $tipPercentage) {
        ForEach(tipPercentages, id: \.self) {
            Text($0, format: .percent)
        }
    .pickerStyle(.segmented)
    }
}
```

```
Section("How much tip do you want to leave?") {
    Picker("Tip percentage", selection: $tipPercentage) {
        ForEach(tipPercentages, id: \.self) {
            Text($0, format: .percent)
        }
    }
    .pickerStyle(.segmented)
}
```

We used
```
Section("How much tip do you want to leave?")
```
Rather than
```
Section{
    Text("How much tip do you want to leave?")
}
```

As we can use the same text we just created, just moved to be the section header rather than a loose label inside it, and it looks good too.

**Calculating total per person**

First, we add the computed property itself, just before the body property:
```
var totalPerPerson: Double {
    // calculate the total per person here
    return 0
}
```

Replacing // with codes now and return 0 too with return amountPerPerson
```
let peopleCount = Double(numberOfPeople + 2)
let tipSelection = Double(tipPercentage)

let tipValue = checkAmount / 100 * tipSelection
let grandTotal = checkAmount + tipValue
let amountPerPerson = grandTotal / peopleCount

return amountPerPerson
```
Converting the resulting value to a Double because it needs to be used alongside the checkAmount.

Now, Replacing this:
```
Section {
    Text(checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
}
```
With this:
```
Section {
    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
}
```

For removing the keyboard which just doesn't goes away, first we need to meet our second property wrapper: @FocusState. This is exactly like a regular @State property, except it’s specifically designed to handle input focus in our UI.

Add this new property to ContentView:
```
@FocusState private var amountIsFocused: Bool
```
Now we can attach that to our text field, so that when the text field is focused amountIsFocused is true, otherwise it’s false. Add this modifier to the TextField:
```
.focused($amountIsFocused)
```

To make this work, we need to add this new modifier to our form, below the existing navigationTitle() modifier:
```
.toolbar {
    if amountIsFocused {
        Button("Done") {
            amountIsFocused = false
        }
    }
}
```

1. The toolbar() modifier lets us specify toolbar items for a view. These toolbar items might appear in various places on the screen – in the navigation bar at the top, in a special toolbar area at the bottom, and so on.

2. The condition checks whether amountIsFocused is currently true, so we only show the button when the text field is active.

3. The Button view we’re using here displays some tappable text, which in our case is “Done”. We also need to provide it with some code to run when the button is pressed, which in our case sets amountIsFocused to false so that the keyboard is dismissed.

First project app is finished!









