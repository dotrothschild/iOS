//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Shimon Rothschild on 2-02-21.
//


import SwiftUI // this did NOT have a screen so created swift  then changed import from Foundation to SwiftUI




// its a class so can instantiate in different swift views
class EmojiMemoryGame: ObservableObject {
   // single emoji private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 2) {_ in "😀"}  // ultimate reduction   cardContentFactory:{ pairIndex in  // all this was reduced (pairIndex: Int) -> String in
   //     return "😀"
   // })  // better name than 'model' would be "game" private(set) to the class only can set, but any one can see var cards was created in place of private(set)

    // every time changes will publish that changed
    // @Published is in place of objectWillChange.send() for each var
    // !!!!! Course says prefix with @Published, but that caused all blank screen, removing it worked
    // @Published private var model: MemoryGame ...... was white when implemented shuffle in var cards: Array
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame() // this creates the array, required at initialization
   
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
    
    // don't need to explictly state this var objectWillChange: ObservableObjectPublisher
    
    // MARK: These 'things' are called intents
    // MARK: in place of (set) //MARK: shows up in breadcrumbs above
    var cards: Array<MemoryGame<String>.Card> {
        //model.cards.shuffle() works here if remove @Publish and .shuffle from model
        return model.cards
        //model.cards  // don't need keyword return because is single line
    }
    // Intent allow view to accerss outside
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        // Here SQL would go if needed
        objectWillChange.send()
        model.choose(card: card)
    }
}
