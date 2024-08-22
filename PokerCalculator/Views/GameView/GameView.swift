//
//  GameView.swift
//  PokerCalculator
//
//  Created by Raj Lulla on 5/22/24.
//

import SwiftUI

struct GameView: View {
    @State var game: Game
    @ObservedObject var gameData: GameData
    @State private var showingAddPlayerView = false
    @State private var showingAlert = false
    @State private var navigateToSettleView = false
    
    var body: some View {
        VStack {
            List {
                ForEach(game.players, id: \.self) { player in
                    GameViewCell(player: player)
                        .swipeActions {
                            Button(role: .destructive) {
                                deletePlayer(player)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .navigationTitle(game.name)
            .navigationBarItems(
                trailing: Button(action: {
                    showingAddPlayerView = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddPlayerView) {
                AddPlayerView(game: $game)
            }
            
            VStack {
                Text("100 Chips = $\(game.hundredChipValue)")
                Text("Money Remaining in Pot: \(String(format: "$%.02f", remainingMoney))")
                    .foregroundColor(remainingMoney < 0 ? .red : .primary)
                
                Button(action: {
                    if remainingMoney < 0 {
                        showingAlert = true
                    } else {
                        navigateToSettleView = true
                    }
                }) {
                    Text("Calculate Debts")
                        .font(.headline)
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Warning"), message: Text("Cash out values exceed total buy ins!"), dismissButton: .default(Text("OK")))
                }
                .navigationDestination(isPresented: $navigateToSettleView) {
                    SettleView(players: game.players, remainingPot: game.remainingPot, hundredChipValue: game.hundredChipValue)
                }
            }
            .padding()
        }
        .onDisappear {
            gameData.updateGame(game)
        }
    }
    
    private func deletePlayer(_ player: Player) {
        if let index = game.players.firstIndex(of: player) {
            game.players.remove(at: index)
        }
    }
    
    private var remainingMoney: Float {
        let totalBuyIn = game.players.reduce(0) { $0 + $1.buyIn }
        let totalCashOut = game.players.reduce(0) { $0 + $1.cashOut }
        return Float(totalBuyIn - totalCashOut)
    }
}

#Preview {
    NavigationStack {
        GameView(game: GameMockData.sampleGame1, gameData: GameData())
    }
}
