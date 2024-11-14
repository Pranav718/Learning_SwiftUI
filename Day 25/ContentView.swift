import SwiftUI

struct ContentView: View {
    @State private var options = ["Rock", "Paper", "Scissors"]
    @State private var correctAnswer = Int.random(in: 0..<3)
    @State private var scoreTitle = ""
    @State private var scoreChecker = 0
    @State private var x = ""
    @State private var showingScore = false
    @State private var questionCounter = 0
    @State private var newQuestions = false
    @State private var y = 0
    
    var body: some View {
        ZStack{
            RadialGradient(colors: [.cyan,.white], center: .topLeading, startRadius: 500, endRadius: 00)
                .ignoresSafeArea()
            
        
                VStack(spacing: 20){
                    Text("Choose One")
                        .foregroundStyle(.secondary)
                        .font(.largeTitle.weight(.semibold))
                    ForEach(0..<3){ number in
                        Button{
                            buttonTapped(number)
                            questionsAsked(questionCounter)
                        }
                        label: {
                            Text(options[number])
                                .padding(20)
                                .shadow(radius: 20)
                                .background(.ultraThinMaterial)
                        
                        }
                        .clipShape(.rect(cornerRadius: 20))
                        
                    }
                    
                }
                .frame(maxWidth: 360)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
            VStack(){
                Spacer()
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
                
                
            
            VStack(alignment: .leading){
                Spacer()
                HStack(){
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("Rock Paper Scissors")
                        .foregroundStyle(.black)
                        .font(.largeTitle.weight(.bold))
                    Spacer()
                    Spacer()
                    Spacer()
                }
                Spacer()
                Spacer()
                Spacer()
                
            }
            
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        }message: {
                Text(x)
        }
        .alert("Alert", isPresented: $newQuestions){
            Button("Restart", action: askQuestion)
        }message: {
            Text("Your overall score was: \(y) out of 10")
        }

    }
    
    func buttonTapped(_ number: Int){
        if options[number] == options[correctAnswer]{
            scoreTitle = "It's the same one!"
            scoreChecker += 0
            x = "Can you guess next one?"
            
        }else if options[number] == "Rock"{
            if options[correctAnswer] == "Scissors"{
                scoreTitle = "You won!, It was \(options[correctAnswer])"
                scoreChecker += 1
                x = "Can you guess next one?"
            }else {
                scoreTitle = "You lost!, It was \(options[correctAnswer])"
                scoreChecker += 0
                x = "Can you guess next one?"
            }
        }
        else if options[number] == "Paper"{
            if options[correctAnswer] == "Rock"{
                scoreTitle = "You won!, It was \(options[correctAnswer])"
                scoreChecker += 1
                x = "Can you guess next one?"
            }else {
                scoreTitle = "You lost!, It was \(options[correctAnswer])"
                scoreChecker += 0
                x = "Can you guess next one?"
            }
        }
        else if options[number] == "Scissors"{
            if options[correctAnswer] == "Paper"{
                scoreTitle = "You won!, It was \(options[correctAnswer])"
                scoreChecker += 1
                x = "Can you guess next one?"
            }else {
                scoreTitle = "You lost!, It was \(options[correctAnswer])"
                scoreChecker += 0
                x = "Can you guess next one?"
            }
        }
        
        showingScore = true
        questionCounter += 1
    }
    
    func askQuestion(){
        correctAnswer = Int.random(in: 0..<3)
    }
    
    func questionsAsked(_ num: Int){
        if num == 10{
            questionCounter = 0
            newQuestions = true
            y = scoreChecker
            scoreChecker = 0
            showingScore = false
            
        }
    }
}




#Preview {
    ContentView()
}
