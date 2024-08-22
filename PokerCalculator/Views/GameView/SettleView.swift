//
//  SettleView.swift
//  PokerCalculator
//
//  Created by Raj Lulla on 5/22/24.
//

import SwiftUI

struct SettleView: View {
    let players: [Player]
    let remainingPot: Int
    let hundredChipValue: Int
    
    var body: some View {
        List {
            ForEach(calculateDebts(), id: \.self) { debt in
                Text("\(debt.from.name) owes \(debt.to.name) $\(String(format: "%.02f", debt.amount))")
            }
        }
        .navigationTitle("Settle Debts")
    }
    
    private func calculateDebts() -> [Debt] {
        let chipToDollarMultiplier: Float = Float(hundredChipValue) / 100
        
        var debts: [Debt] = []
        var netBalances = players.map { player -> (player: Player, balance: Int) in
            let net = player.cashOut - player.buyIn
            return (player, net)
        }
        
        if remainingPot > 0 {
            let potPlayer = Player(name: "Pot", buyIn: 0, cashOut: remainingPot)
            netBalances.append((potPlayer, remainingPot))
        }
        
        netBalances.sort { $0.balance < $1.balance }
        
        var i = 0
        var j = netBalances.count - 1
        
        while i < j {
            let debtor = netBalances[i]
            let creditor = netBalances[j]
            
            let amount = min(-debtor.balance, creditor.balance)
            
            debts.append(Debt(from: debtor.player, to: creditor.player, amount: Float(amount) * chipToDollarMultiplier))
            
            netBalances[i].balance += amount
            netBalances[j].balance -= amount
            
            if netBalances[i].balance == 0 {
                i += 1
            }
            
            if netBalances[j].balance == 0 {
                j -= 1
            }
        }
        
        return debts
    }
    
    struct Debt: Hashable {
        let from: Player
        let to: Player
        let amount: Float
    }
}

#Preview {
    NavigationStack {
        SettleView(players: GameMockData.sampleGame1.players,
                   remainingPot: GameMockData.sampleGame1.remainingPot,
                   hundredChipValue: GameMockData.sampleGame1.hundredChipValue)
    }
}
