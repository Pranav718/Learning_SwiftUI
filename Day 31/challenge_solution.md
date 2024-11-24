****First Challenge****

 We have to make two functions for first challenge, one which would confirm if the word count is shorter than 3 or not and return the boolean values accordingly, same for another function
 which would check if the word entered is the same as ```rootWord``` and return the boolean values accordingly

 We'll use the same process to process both of those functions, i.e. using guard
```
func wordCount(word: String) -> Bool{
        return word.count > 2
}
```

```  
func sameWord(word: String) -> Bool{
        return word != rootWord
}
```

```
guard wordCount(word: answer) else {
        wordError(title: "Word is correct but not accepted", message: "Word should be more than 3 characters")
        return
}
```

```
guard sameWord(word: answer) else {
        wordError(title: "Word not accepted", message: "It's the same word from which we have to make other words ")
        return
}
```



****Second Challenge****

Just adding a toolbar modifier after the navigation stack with a button that would call the startGame thus changing the words
```
.toolbar{
    Button("Next", action: startGame)
}
```



****Third Challenge****

We have to create a new variable named scoreCounter and would give points related to how long the word is, for which would write the code in ```isPossible()``` property
```
@State private var scoreCounter = 0
```

```
func isPossible(word: String) -> Bool{
        var tempWord = rootWord
        for letter in word{
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
                scoreCounter += 1
            }else{
                return false
            }
        }
        return true
    }

```

Now for the UI stuffs, it could be as simple as a section above the used words list which woulf update and show the score after every word.
Just for the fun and extra nice UI, I added game rules too in a cool way.

```
Section{
      Text("Game rules")
          .font(.title2)
          .fontWeight(.bold)
      VStack{
          HStack{
              Image(systemName: "star.fill")
                  .imageScale(.small)
              Text("The entered word should contain 3 or more letters.")
          }
          .padding(0.17)
          
          HStack{
              Image(systemName: "star.fill")
                  .imageScale(.small)
              Text("The entered word should not contain the word that is given.")
          }
          .padding(0.16)
          
          HStack{
              Image(systemName: "star.fill")
                  .imageScale(.small)
              Text("For each correct word, a point would be awarded which will be the same as the length of the word.")
          }
          .padding(0.17)
          
      }
  }
  
  Section{
      Text("Your score: \(scoreCounter)")
          .font(.title3)
          .fontWeight(.semibold)
  }
```
