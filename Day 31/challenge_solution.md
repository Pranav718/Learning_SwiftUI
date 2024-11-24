**First Challenge**

 We have to make two functions for first challenge, one which would confirm if the word count is shorter than 3 or not and return the boolean values accordingly, same for another function
 which would check if the word entered is the same as ```rootWord``` and return the boolean values accordingly

 We'll use the same process to check both of those conditions, i.e. using guard
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

