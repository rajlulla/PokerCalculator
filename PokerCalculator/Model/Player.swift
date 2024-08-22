//
//  Player.swift
//  PokerCalculator
//
//  Created by Raj Lulla on 5/21/24.
//

import Foundation

struct Player: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var buyIn: Int
    var cashOut: Int

    // Conformance to Equatable using name only
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }

    // Conformance to Hashable using name only
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

struct PlayerMockData {
    static let samplePlayerA = Player(name: "A", buyIn: 100, cashOut: 75)
    static let samplePlayerB = Player(name: "B", buyIn: 100, cashOut: 175)
    static let samplePlayerC = Player(name: "C", buyIn: 200, cashOut: 175)
    static let samplePlayerD = Player(name: "D", buyIn: 100, cashOut: 150)
    static let samplePlayerE = Player(name: "E", buyIn: 100, cashOut: 0)
}
