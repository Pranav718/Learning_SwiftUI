# Project 5

This project will be another game that will show players a random eight-letter word, and ask them to make words out of it.

We'll also get introduced to List, onAppear(), Bundle, fatalError(), and more 

The job of List is to provide a scrolling table of data. In fact, it’s pretty much identical to Form, except it’s used for presentation of data rather than requesting user input. Form is just a specialised type of list.

We can also switch to ForEach in order to create rows dynamically from an array or range:
```
List {
    ForEach(0..<5) {
        Text("Dynamic row \($0)")
    }
}
```

Where things get more interesting is the way you can mix static and dynamic rows:
```
List {
    Text("Static row 1")
    Text("Static row 2")

    ForEach(0..<5) {
        Text("Dynamic row \($0)")
    }

    Text("Static row 3")
    Text("Static row 4")
}
```

And of course we can combine that with sections, to make our list easier to read:
```
List {
    Section("Section 1") {
        Text("Static row 1")
        Text("Static row 2")
    }

    Section("Section 2") {
        ForEach(0..<5) {
            Text("Dynamic row \($0)")
        }
    }

    Section("Section 3") {
        Text("Static row 3")
        Text("Static row 4")
    }
}
```

Tip: As we can see, if our section header is just some text you can pass it in directly as a string – it’s a helpful shortcut for times when we don’t need anything more advanced.

We can notice that this list looks similar to the form we had previously, but we can adjust how the list looks using the listStyle() modifier, like this:
```
.listStyle(.grouped)
```

But one thing List can do that Form can’t is to generate its rows entirely from dynamic content without needing a ForEach.

So, if our entire list is made up of dynamic rows, we can simply write this:
```
List(0..<5) {
    Text("Dynamic row \($0)")
}
```

When working with an array of data, SwiftUI still needs to know how to identify each row uniquely, so if one gets removed it can simply remove that one rather than having to redraw the whole list. This is where the id parameter comes in, and it works identically in both List and ForEach – it lets us tell SwiftUI exactly what makes each item in the array unique.

When working with this kind of list data, we use id: \.self like this:
```
struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]

    var body: some View {
        List(people, id: \.self) {
            Text($0)
        }
    }
}
```

When Xcode builds our iOS app, it creates something called a “bundle”. This happens on all of Apple’s platforms, including macOS, and it allows the system to store all the files for a single app in one place – the binary code (the actual compiled Swift stuff we wrote), all the artwork, plus any extra files we need all in one place.

Let’s start writing some code. If we want to read the URL for a file in our main app bundle, we use Bundle.main.url(). If the file exists it will be sent back to us, otherwise we’ll get back nil, so this is an optional URL. That means we need to unwrap it like this:
```
if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
    // we found the file in our bundle!
}
```
Once we have a URL, we can load it into a string with a special initializer: String(contentsOf:). We give this a file URL, and it will send back a string containing the contents of that file if it can be loaded. If it can’t be loaded it throws an error, so we need to call this using try or try? like this:
```
if let fileContents = try? String(contentsOf: fileURL) {
    // we loaded the file into a string!
}
```

Swift gives us a method called components(separatedBy:) that can converts a single string into an array of strings by breaking it up wherever another string is found. For example, this will create the array ```["a", "b", "c"]:```

```
let input = "a b c"
let letters = input.components(separatedBy: " ")

let input = """
            a
            b
            c
            """
let letters = input.components(separatedBy: "\n")
```

Regardless of what string we split on, the result will be an array of strings. From there we can read individual values by indexing into the array, such as ```letters[0]``` or ```letters[2]```, but Swift gives us a useful other option: the ```randomElement()``` method returns one random item from the array.

For example, this will read a random letter from our array:
```
let letter = letters.randomElement()
```

Although we can see that the letters array will contain three items, Swift doesn’t know that – perhaps we tried to split up an empty string, for example. As a result, the randomElement() method returns an optional string, which we must either unwrap or use with nil coalescing.


