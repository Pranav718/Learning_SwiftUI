I'm doing all of three challenges at once


First name all the variables needed: 
```
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreChecker = 0

    @State private var questionCounter = 0
    @State private var newQuestions = false

    @State private var x = ""
    @State private var y = ""

```

Then write three functions, one for updating score 
```
 func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct!"
            scoreChecker += 1
            if questionCounter == 0{
                scoreChecker = 0
            }
            x = "That's \(countries[correctAnswer])"
        }else if number != correctAnswer{
            scoreTitle = "Wrong!"
            scoreChecker -= 1
            if questionCounter == 0{
                scoreChecker = 0
            }
            x = "That's \(countries[number])"
        }
        showingScore = true
        questionCounter += 1
    }
```

Then for asking question , which we would use after showing 8 questions and one function to calculate the no. of questions asked which we would keep track by keeping it inside button modifier.

```
    func askquestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<3)
    }
    
    func questionsAsked(_ num : Int){
        if num == 8{
            questionCounter = 0
            newQuestions = true
            showingScore = false
        }
    }
```

Now for alert to appear after 8 questions and the alert to appear after choosing a flag, wether it is correct,

First add these in place to //flag was tapped
```
   flagTapped(number)
   questionsAsked(questionCounter)
```

Then:


