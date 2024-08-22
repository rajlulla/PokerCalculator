//
//  GamesListCell.swift
//  PokerCalculator
//
//  Created by Raj Lulla on 5/21/24.
//

import SwiftUI

struct GamesListCell: View {
    
    let game: Game
    private let dateFormatter: DateFormatter
    
    init(game: Game) {
        self.game = game
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "MMM d y, h:mm"
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(game.name)
                .font(.title3)
                .lineLimit(1)
            
            Text(dateFormatter.string(from: game.createDate))
                .font(.footnote)
                .lineLimit(1)
            
            Text(String(format: "Pot: $%.02f", game.pot))
                .lineLimit(1)
        }
    }
}

#Preview {
    GamesListCell(game: GameMockData.sampleGame1)
}
