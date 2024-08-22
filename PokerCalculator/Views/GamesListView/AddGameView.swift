//
//  AddGameView.swift
//  PokerCalculator
//
//  Created by Raj Lulla on 5/21/24.
//

import SwiftUI

struct AddGameView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var gameData: GameData
    @State private var gameName = ""
    @State private var hundredChipValue = 100
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Game Details")) {
                    TextField("Game Name", text: $gameName)
                    HStack {
                        Text("$")
                        TextField("Hundred Chip Value", value: $hundredChipValue, formatter: NumberFormatter.hundredChipFormatter)
                            .keyboardType(.numberPad)
                    }
                }
            }
            .navigationBarTitle("Add New Game")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    if gameName.isEmpty {
                        alertMessage = "Game name is required."
                        showingAlert = true
                    } else if hundredChipValue < 1 || hundredChipValue > 1000 {
                        alertMessage = "Hundred chip value must be between 1 and 1000."
                        showingAlert = true
                    } else {
                        let newGame = Game(name: gameName, players: [], hundredChipValue: hundredChipValue)
                        gameData.addGame(newGame)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .disabled(gameName.isEmpty || hundredChipValue < 1 || hundredChipValue > 1000)
            )
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

extension NumberFormatter {
    static var hundredChipFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimum = 1
        formatter.maximum = 1000
        return formatter
    }
}

#Preview {
    AddGameView(gameData: GameData())
}
