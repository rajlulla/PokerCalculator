//
//  GamesListView.swift
//  PokerCalculator
//
//  Created by Raj Lulla on 5/21/24.
//

import SwiftUI

struct GamesListView: View {
    @StateObject private var gameData = GameData()
    @State private var showingAddGameView = false
    @State private var selectedGame: Game?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(gameData.games.sorted(by: { $0.createDate > $1.createDate })) { game in
                    NavigationLink(value: game.id) {
                        GamesListCell(game: game)
                    }
                }
                .onDelete(perform: deleteGame)
            }
            .navigationTitle("Games")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                    showingAddGameView = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddGameView) {
                AddGameView(gameData: gameData)
            }
            .navigationDestination(for: UUID.self) { gameId in
                if let game = gameData.games.first(where: { $0.id == gameId }) {
                    GameView(game: game, gameData: gameData)
                }
            }
        }
    }
    
    private func deleteGame(at offsets: IndexSet) {
        gameData.deleteGames(at: offsets)
    }
}

#Preview {
    GamesListView()
}
