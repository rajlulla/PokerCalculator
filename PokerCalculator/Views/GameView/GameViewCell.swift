//
//  GameViewCell.swift
//  PokerCalculator
//
//  Created by Raj Lulla on 5/22/24.
//

import SwiftUI

struct GameViewCell: View {
    let player: Player
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(player.name)
                .font(.title3)
                .lineLimit(1)
            Text("Buy-in: \(player.buyIn) Chips")
                .font(.footnote)
                .lineLimit(1)
            Text("Cash-out: \(player.cashOut) Chips")
                .font(.footnote)
                .lineLimit(1)
        }
    }
}

#Preview {
    GameViewCell(player: PlayerMockData.samplePlayerA)
}
