import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Monaco","Nigeria","Poland","Spain","UK","Ukraine","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0..<3)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreChecker = 0
    @State private var x = ""
    @State private var questionCounter = 0
    @State private var y = 0
    @State private var newQuestions = false
    
    var body: some View {
        ZStack{
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.6, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess The Flag")
                    .foregroundStyle(.white)
                    .font(.largeTitle.weight(.bold))
                
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                            questionsAsked(questionCounter)//flag was tapped
                        }label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 10)
                        }
                    }
                    
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()

                HStack(spacing: 10){
                    Text("Score:")
                        .foregroundStyle(.white)
                        .font(.title.weight(.bold))
                    Text(scoreChecker, format: .number)
                        .foregroundStyle(.white)
                        .font(.title.weight(.bold))
                }
                Spacer()
                
            }
            .padding(20)
            
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askquestion)
        }message: {
            Text(x)
        }
        .alert("Alert", isPresented: $newQuestions){
                Button("Restart", action: askquestion)
        }message: {
                Text("Your overall score was: \(y)")
        }
    }
    
    
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
    
    func askquestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<3)
    }
    
    func questionsAsked(_ num : Int){
        if num == 8{
            questionCounter = 0
            newQuestions = true
            showingScore = false
            y = scoreChecker
            scoreChecker = 0
        }
      
       
    }
    
}

#Preview {
    ContentView()
}
