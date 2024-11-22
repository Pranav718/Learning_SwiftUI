We need

1.An array of words already used
2.Root word for them to spell other words from
3.a string we can bind to a text field
```
@State private var usedWords = [String]()
@State private var rootWord = ""
@State private var newWord = ""
```

As for the body of the view, we’re going to start off as simple as possible: a NavigationStack with rootWord for its title, then a couple of sections inside a list:
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

Important Note: Using id: \.self would cause problems if there were lots of duplicates in usedWords, but soon enough we’ll be disallowing that so it’s not a problem.

Now, our text view has a problem: although we can type into the text box, we can’t submit anything from there – there’s no way of adding our entry to the list of used words.
To fix that we’re going to write a new method called addNewWord() that will:

1.Lowercase newWord and remove any whitespace

2.Check that it has at least 1 character otherwise exit

3.Insert that word at position 0 in the usedWords array

4.Set newWord back to be an empty string

Later on we’ll add some extra validation between steps 2 and 3 to make sure the word is allowable, but for now this method is straightforward:
```
func addNewWord() {
    // lowercase and trim the word, to make sure we don't add duplicate words with case differences
    let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

    // exit if the remaining string is empty
    guard answer.count > 0 else { return }

    // extra validation to come

    usedWords.insert(answer, at: 0)
    newWord = ""
}
```
