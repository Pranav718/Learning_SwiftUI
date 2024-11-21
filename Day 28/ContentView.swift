//
//  ContentView.swift
//  BetterSleep
//
//  Created by Pranav Ray on 07/08/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    var calculateBedtime: String{
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0)*60*60
            let minute = (components.minute ?? 0)*60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
        }catch{
            return "Sorry, There was a problem calculating your bedtime."
        }
    }
    
    static var defaultWakeTime: Date{
        var components = DateComponents()
        components.hour = 5
        components.minute = 30
        
        return Calendar.current.date(from: components) ?? .now
        //we use nil coalescing as it can return no value too
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section(){
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section(){
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section(){
                    Text("Amount of coffee intake")
                        .font(.headline)
                    Picker("Number of cups", selection: $coffeeAmount){
                        ForEach(0...5,id: \.self){ number in
                            Text("\(number) \(number == 1 || number == 0 ? "cup" : "cups")")
                        }
                    }
                }
                Section("Your recommended bedtime is") {
                    Text(calculateBedtime)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                }
            }
            .navigationTitle("BetterRest")
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
            
        }
        
        
    }

}

#Preview {
    ContentView()
}
