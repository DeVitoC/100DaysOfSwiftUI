//
//  ContentView.swift
//  BetterRest
//
//  Created by Christopher DeVito on 3/3/22.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeup = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

//    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }

    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                Text("When do you want to wake up?")
                    .font(.headline)
                DatePicker("Please enter a time", selection: $wakeup, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                }
                .onChange(of: wakeup) { newValue in
                    calculateBedtime()
                }

                VStack(alignment: .leading, spacing: 0) {
                Text("Desired amount of sleep")
                    .font(.headline)
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                .onChange(of: sleepAmount) { newValue in
                    calculateBedtime()
                }

                VStack(alignment: .leading, spacing: 0) {
                Text("Daily coffee intake")
                    .font(.headline)
                Stepper(coffeeAmount == 1 ? "1 Cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                }
                .onChange(of: coffeeAmount) { newValue in
                    calculateBedtime()
                }

                Section {
                    Text(alertMessage)
                        .font(.largeTitle)
                        .frame(alignment: .center)
                } header: {
                    Text("Your recommended bedtime is:")
                }
            }
            .navigationTitle("BetterRest")
            .onAppear {
                calculateBedtime()
            }
//            .toolbar {
//                Button("Calculate", action: calculateBedtime)
//            }
//            .alert(alertTitle, isPresented: $showingAlert) {
//                Button("OK") { }
//            } message: {
//                Text(alertMessage)
//            }
        }
    }

    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCaclulator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeup)
            let hour = components.hour ?? 0
            let minute = components.minute ?? 0
            let seconds = Double(((hour * 60) + minute) * 60)
            let prediction = try model.prediction(wake: seconds, estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeup - prediction.actualSleep
//            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
//            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }

        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
