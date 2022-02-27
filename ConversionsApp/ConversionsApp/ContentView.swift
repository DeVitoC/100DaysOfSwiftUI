//
//  ContentView.swift
//  ConversionsApp
//
//  Created by Christopher DeVito on 2/26/22.
//

import SwiftUI

struct ContentView: View {
    let tempUnits: [Temperature] = [.celcius, .fahrenheit, .kelvin]

    @State private var currentStartUnit: String = Temperature.celcius.rawValue
    @State private var currentEndUnit: String = Temperature.fahrenheit.rawValue
    @State private var startAmount: Double = 0.0
    private var endAmount: Double {
        if currentStartUnit == currentEndUnit {
            return startAmount
        }
        switch currentStartUnit {
        case Temperature.celcius.rawValue:
            if currentEndUnit == Temperature.fahrenheit.rawValue {
                return (startAmount * 9 / 5) + 32
            } else {
                return startAmount + 273.15
            }
        case Temperature.fahrenheit.rawValue:
            if currentEndUnit == Temperature.celcius.rawValue {
                return (startAmount - 32) * 5 / 9
            } else {
                return (startAmount - 32) * 5 / 9 + 273.15
            }
        case Temperature.kelvin.rawValue:
            if currentEndUnit == Temperature.celcius.rawValue {
                return startAmount - 273.15
            } else {
                return (startAmount - 273.15) * 9 / 5 + 32
            }
        default:
            return 0.0
        }
    }
    @FocusState private var isStartFocused: Bool

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select Unit to convert from", selection: $currentStartUnit) {
                        ForEach(tempUnits, id: \.rawValue.self) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                } header: {
                    Text("Select the unit to convert from: ")
                }

                Section {
                    Picker("Select Unit to convert to", selection: $currentEndUnit) {
                        ForEach(tempUnits, id: \.rawValue.self) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                } header: {
                    Text("Select the unit to convert to: ")
                }

                Section {
                    TextField("0.00", value: $startAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isStartFocused)
                } header: {
                    Text("Enter amount to convert from:")
                }

                Section {
                    Text("\(endAmount)")
                        .keyboardType(.decimalPad)
                } header: {
                    Text("\(startAmount) in \(currentStartUnit) is: ")
                }
            }
            .navigationTitle("Temperature Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        isStartFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum ConversionType: String {
    case temperature, distance, time, volume
}

enum Temperature: String {
    case celcius, fahrenheit, kelvin
}
