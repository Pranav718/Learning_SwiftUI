//
//  ContentView.swift
//  WordScramble
//
//  Created by Pranav Ray on 10/08/24.
//

import SwiftUI
    
struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var scoreCounter = 0
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
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
                
                Section{
                    ForEach(usedWords, id: \.self) { word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError){
                Button("OK"){}
            }message: {
                Text(errorMessage)
            }
            .toolbar{
                Button("Next", action: startGame)
            }
        }
    }
    func addNewWord(){
   //lowercase and trim the word to make sure we dont add duplicate words with case difference
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        //exit if the remaining string is empty
        guard answer.count > 0 else {return}
        
        //now if it comes to this, then the string is definitly not empty
        guard isOriginal(word: answer) else{
            wordError(title: "Word used already!", message: "Be more original :)")
            return
        }
        
        guard isPossible(word: answer) else{
            wordError(title: "Word isn't possible!",message: "Can't spell that word from \(rootWord)")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "No such word exist")
            return
        }
        
        guard wordCount(word: answer) else {
            wordError(title: "Word is correct but not accepted", message: "Word should be more than 3 characters")
            return
        }
        
        guard sameWord(word: answer) else {
            wordError(title: "Word not accepted", message: "It's the same word from which we have to make other words ")
            return
        }
        
        withAnimation{
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame(){
        scoreCounter = 0
        usedWords = []
        //1.Find the url for start.txt from the app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            //2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL){
                //3.Split the string into an array of strings splitting on newline characters
                let allWords = startWords.components(separatedBy: "\n")
                
                //4. Pick one random word or use "silkworm" as default
                rootWord = allWords.randomElement() ?? "Silkworm"
                
                //5. If we are here, everything worked so we have to exit
                return
            }
        }
        
        // If were are here then there was a problem – trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
        //false if it does not contains the word and then it'll be flipped to be true thus original
    }
    
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
    
    func wordCount(word: String) -> Bool{
        return word.count > 2
    }
    
    func sameWord(word: String) -> Bool{
        return word != rootWord
    }
    
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        //if the word was OK the location for that range will be the special value NSNotFound.
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
}

#Preview {
    ContentView()
}
