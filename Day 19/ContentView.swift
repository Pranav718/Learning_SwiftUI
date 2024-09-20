//
//  ContentView.swift
//  lengthConverter
//
//  Created by Pranav Ray on 31/07/24.
//

import SwiftUI


struct ContentView: View {
    @State private var selectedUnitForInput = "Meters"
    @State private var selectedUnitForOutput = "Kilometers"
    
    let units = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    
    @State private var inputLength = 0.0
    @State private var outputLength = 0.0
    
    var outputInUnit: Double {
        var finalOutput = 0.0
        
        // converting any input unit to meters
        if selectedUnitForInput == "Meters"{
            inputLength = inputLength
        }
        else if selectedUnitForInput == "Kilometers"{
            inputLength = inputLength * 1000
        }
        else if selectedUnitForInput == "Feet"{
            inputLength = inputLength * 0.3048
        }
        else if selectedUnitForInput == "Yards"{
            inputLength = inputLength * 0.9144
        }
        else{
            inputLength = inputLength * 1.609344
        }
        
        // converting meters to final output unit
        if selectedUnitForOutput == "Meters"{
            finalOutput = inputLength
        }
        else if selectedUnitForOutput == "Kilometers"{
            finalOutput = inputLength / 1000
        }
        else if selectedUnitForOutput == "Feet"{
            finalOutput = inputLength / 0.3048
        }
        else if selectedUnitForOutput == "Yards"{
            finalOutput = inputLength / 0.9144
        }
        else{
            finalOutput = inputLength /
        }
        
        return finalOutput
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Input Unit", selection: $selectedUnitForInput){
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }
                    
                    TextField("Length", value: $inputLength, format: .number)
                    
                }
                Section(){
                    Picker("Output Unit", selection: $selectedUnitForOutput){
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }
                    //.pickerStyle(.segmented)
                    .pickerStyle(.navigationLink)
                    
                }
                Section("Output length in \(selectedUnitForOutput)") {
                    Text(outputInUnit , format: .number)
                }
            }
            .navigationTitle("Length Converter")
        }
    }
}

#Preview {
    ContentView()
}
