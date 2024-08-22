//
//  Game.swift
//  PokerCalculator
//
//  Created by Raj Lulla on 5/21/24.
//

import Foundation

struct Game: Identifiable, Codable, Hashable {
    var id = UUID()
    let name: String
    var createDate: Date = Date()
    var players: [Player]
    let hundredChipValue: Int
    var remainingPot: Int {
        let totalBuyIn = players.reduce(0) { $0 + $1.buyIn }
        let totalCashOut = players.reduce(0) { $0 + $1.cashOut }
        return totalBuyIn - totalCashOut
    }
    var pot: Float {
        let totalBuyIn = players.reduce(0) { $0 + $1.buyIn }
        return Float(totalBuyIn) * Float(hundredChipValue) / 100.0
    }
    
    mutating func addPlayer(_ player: Player) {
        players.append(player)
    }
}

struct GameMockData {
    static let sampleGame1 = Game(name: "Game 1",
                                  players: [PlayerMockData.samplePlayerA,
                                            PlayerMockData.samplePlayerB,
                                            PlayerMockData.samplePlayerC,
                                            PlayerMockData.samplePlayerD,
                                            PlayerMockData.samplePlayerE],
                                  hundredChipValue: 50)
}
