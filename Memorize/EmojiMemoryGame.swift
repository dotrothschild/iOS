//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Shimon Rothschild on 2-02-21.
//


import SwiftUI // this did NOT have a screen so created swift  then changed import from Foundation to SwiftUI




// its a class so can instantiate in different swift views
class EmojiMemoryGame {
   // single emoji private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 2) {_ in "😀"}  // ultimate reduction   cardContentFactory:{ pairIndex in  // all this was reduced (pairIndex: Int) -> String in
   //     return "😀"
   // })  // better name than 'model' would be "game" private(set) to the class only can set, but any one can see var cards was created in place of private(set)

    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame() // this creates the array, required at initialization
   
    static var useBigFont: Bool = true
    // must be static because need it to init class, but cant call it until class is created.
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃","🕷","💀","🧙"]
        // original return MemoryGame<String>(numberOfPairsOfCards: emojis.count){ pairIndex in
        let cardPairs =  Int.random(in: 2...5)
        if (cardPairs > 4) {
            useBigFont = false
        }
        
        // this calls the 'func' init ---> init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent)
        return MemoryGame<String>(numberOfPairsOfCards: cardPairs){ pairIndex in
            return emojis[pairIndex]
        }
    }
    // MARK: These 'things' are called intents
    // MARK: in place of (set) //MARK: shows up in breadcrumbs above
    var cards: Array<MemoryGame<String>.Card> {
        model.cards.shuffle()
        return model.cards
        //model.cards  // don't need keyword return because is single line
    }
    // Intent allow view to accerss outside
    func choose(card: MemoryGame<String>.Card) {
        // Here SQL would go if needed
        model.choose(card: card)
    }
}
