//              *******************************
//  ViewModel   *******************************
//              *******************************

//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Shimon Rothschild on 2-02-21.
//


import SwiftUI // this did NOT have a screen so created swift  then changed import from Foundation to SwiftUI




// its a class so can instantiate in different swift views
class EmojiMemoryGameViewModel: ObservableObject {
    @Published private var model: EmojiMemoryGameModel<String>

    var theme = Theme.themes.randomElement()!
    var score: Int {model.score}
    var cards: Array<EmojiMemoryGameModel<String>.Card> {
        return model.cards
    }

    
    private static func createMemoryGame(theme: Theme) -> EmojiMemoryGameModel<String> {
        // get the random theme
       
        let emojis = theme.emojis.shuffled()
        var cardPairs: Int
        if theme.pairsOfCard != nil  {
            cardPairs = theme.pairsOfCard!
        } else {
            cardPairs = Int.random(in: 2...emojis.count)
        }
        return EmojiMemoryGameModel<String>(numberOfPairsOfCards: cardPairs){ pairIndex in
            return emojis[pairIndex]
        }
    }
    // MARK: - Intent always public
    func choose(card: EmojiMemoryGameModel<String>.Card) {
        // Here SQL would go if needed
        objectWillChange.send()
        model.choose(card: card)
    }
    
    func newGame() {
        theme = Theme.themes.randomElement()!
        model = EmojiMemoryGameViewModel.createMemoryGame(theme: theme)
    }
    
    init() {
        model = EmojiMemoryGameViewModel.createMemoryGame(theme: theme)
    }
}
