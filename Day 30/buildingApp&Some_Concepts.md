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

We want to call addNewWord() when the user presses return on the keyboard, and in SwiftUI we can do that by adding an onSubmit() modifier somewhere in our view hierarchy – it could be directly on the textfield, but it can be anywhere else in the view because it will be triggered when any text is submitted.

onSubmit() needs to be given a function that accepts no parameters and returns nothing

Inside addNewWord() we used ```usedWords.insert(answer, at: 0)``` for a reason: if we had used append(answer) the new words would have appeared at the end of the list where they would probably be off screen

automatically capitalizes the first letter of whatever the user types, so when they submit “Car” what they see in the list is “car”.

To fix this, we can disable capitalization for the text field with another modifier: textInputAutocapitalization(). Please add this to the text field now:
```.textInputAutocapitalization(.never)```

So, we can wrap our word text in a HStack, and place an SF Symbol next to it using ```Image(systemName:)``` like this:
```
ForEach(usedWords, id: \.self) { word in
    HStack {
        Image(systemName: "\(word.count).circle")
        Text(word)
    }
}
withAnimation {
    usedWords.insert(answer, at: 0)
}
```




Now, write a new method called startGame() that will:
1.Find start.txt in our bundle
2.Load it into a string
3.Split that string into array of strings, with each element being one word
4.Pick one random word from there to be assigned to rootWord, or use a sensible default if the array is empty

func startGame() {
    // 1. Find the URL for start.txt in our app bundle
    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
        // 2. Load start.txt into a string
        if let startWords = try? String(contentsOf: startWordsURL) {
            // 3. Split the string up into an array of strings, splitting on line breaks
            let allWords = startWords.components(separatedBy: "\n")

            // 4. Pick one random word, or use "silkworm" as a sensible default
            rootWord = allWords.randomElement() ?? "silkworm"

            // If we are here everything has worked, so we can exit
            return
        }
    }

    // If were are *here* then there was a problem – trigger a crash and report the error
    fatalError("Could not load start.txt from bundle.")
}


SwiftUI gives us a dedicated view modifier for running a closure when a view is shown, so we can use that to call startGame() and get things moving – add this modifier after onSubmit():
.onAppear(perform: startGame)



Now that our game is all set up, the last part of this project is to make sure the user can’t enter invalid words
Let’s start with the first method: this will accept a string as its only parameter, and return true or false depending on whether the word has been used before or not. We already have a usedWords array, so we can pass the word into its contains() method and send the result back like this:

func isOriginal(word: String) -> Bool {
    !usedWords.contains(word)
}

So, here’s our second method:

func isPossible(word: String) -> Bool {
    var tempWord = rootWord

    for letter in word {
        if let pos = tempWord.firstIndex(of: letter) {
            tempWord.remove(at: pos)
        } else {
            return false
        }
    }

    return true
}

So, our last method will make an instance of UITextChecker, which is responsible for scanning strings for misspelled words. We’ll then create an NSRange to scan the entire length of our string, then call rangeOfMisspelledWord() on our text checker so that it looks for wrong words. When that finishes we’ll get back another NSRange telling us where the misspelled word was found, but if the word was OK the location for that range will be the special value NSNotFound.

So, here’s our final method:

func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

    return misspelledRange.location == NSNotFound
}
