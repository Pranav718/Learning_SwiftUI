Starting with our 1st project - WeSplit

In this project we’re going to be building a check-splitting app that we might use after eating at a restaurant – we enter the cost of our food, select how much of a tip we want to leave, and how many people we’re with, and it will tell us how much each person needs to pay.

To create a Form, we use the following syntax:
```
Form {
  Text("Hello world")
}
```

If we want to break our form into more visual chunks, we can use Section like this:
```
Form{
  Section{
    Text("Section 1")
  }
  Section{
    Text("Section 2")
  }
}
```

As we add a section inside the form, so in a similar way, to put a navigation bar, we need to add it under navigation stack aswell.
```
NavigationStack{
  Form{
    Section{
      Text("hello world")
    }
  }
  .navigationTitle("Title")
}
```

If we want to get a small font for Title, we can use inline modifier
```
.navigationBarTitleDisplayMode(.inline)
```


Normally we can’t make any statements inside a struct in which a value changes because as we learned that structs are immutable values.
So for example we want to increase the times a button is pressed by 1 , we can’t do so in struct due to this property

Here comes the function named as @State which written before a var , and inside a struct can be subjected to change in its value for example:
```
struct contentView: View {
  @State var tapCount = 0
  var body: some View {
    Button("Tap count: \(tapCount)") {
      tapCount += 1
    }
  }
}
```

If we wanted to create an editable text box that users can type into









