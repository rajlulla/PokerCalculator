//
//  AddPlayerView.swift
//  PokerCalculator
//
//  Created by Raj Lulla on 5/22/24.
//

import SwiftUI

struct AddPlayerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var game: Game
    @State private var playerName = ""
    @State private var buyIn = ""
    @State private var cashOut = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Player Details")) {
                    TextField("Player Name", text: $playerName)
                    TextField("Buy-in", text: $buyIn)
                        .keyboardType(.numberPad)
                    TextField("Cash-out", text: $cashOut)
                        .keyboardType(.numberPad)
                }
            }
            .navigationBarTitle("Add New Player")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    validateAndSave()
                }
            )
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func validateAndSave() {
        if playerName.isEmpty {
            alertMessage = "Player name is required."
            showingAlert = true
        } else if buyIn.isEmpty {
            alertMessage = "Buy-in value is required."
            showingAlert = true
        } else if cashOut.isEmpty {
            alertMessage = "Cash-out value is required."
            showingAlert = true
        } else if let buyInValue = Int(buyIn), let cashOutValue = Int(cashOut) {
            let newPlayer = Player(name: playerName, buyIn: buyInValue, cashOut: cashOutValue)
            game.addPlayer(newPlayer)
            presentationMode.wrappedValue.dismiss()
        } else {
            alertMessage = "Invalid input values."
            showingAlert = true
        }
    }
}

#Preview {
    AddPlayerView(game: .constant(GameMockData.sampleGame1))
}
