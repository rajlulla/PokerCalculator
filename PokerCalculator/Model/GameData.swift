//
//  GameData.swift
//  PokerCalculator
//
//  Created by Raj Lulla on 5/23/24.
//

import Foundation

class GameData: ObservableObject {
    @Published var games: [Game] = []
    
    private let saveKey = "SavedGames"
    
    init() {
        loadGames()
    }
    
    func addGame(_ game: Game) {
        games.append(game)
        saveGames()
    }
    
    func deleteGames(at offsets: IndexSet) {
        games.remove(atOffsets: offsets)
        saveGames()
    }
    
    func updateGame(_ game: Game) {
        if let index = games.firstIndex(where: { $0.id == game.id }) {
            games[index] = game
            saveGames()
        }
    }
    
    private func loadGames() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decodedGames = try? JSONDecoder().decode([Game].self, from: data) {
            games = decodedGames
        }
    }
    
    private func saveGames() {
        if let encodedData = try? JSONEncoder().encode(games) {
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }
}
