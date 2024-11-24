Let’s start with the basics: we need an array of words they have already used, a root word for them to spell other words from, and a string we can bind to a text field. So, add these three properties to ContentView now:
```
@State private var usedWords = [String]()
@State private var rootWord = ""
@State private var newWord = ""
```

We'll start with a navigation stack having title as rootword and then a couple of sections inside a list
```
var body: some View {
    NavigationStack {
        List {
            Section {
                TextField("Enter your word", text: $newWord)
            }

            Section {
                ForEach(usedWords, id: \.self) { word in
                    Text(word)
                }
            }
        }
        .navigationTitle(rootWord)
    }
}
```

We're now going to write a new method called addNewWord() that will, lowercase newWord and remove any whitespace, also checking that it has at least 1 character otherwise exit, insert that word at position 0 in the usedWords array, set newWord back to be an empty string

