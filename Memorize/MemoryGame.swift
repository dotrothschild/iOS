//
//  MemoryGame.swift
//  Memorize
//
//  Created by Shimon Rothschild on 2-02-21.
//


import Foundation

// only at run time is the 'face' <CardContent> of the card determined, ex string (Emoji), image etc
struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        print("card chosen : \(card)")
    }
    
    // CardContent is String, the Emoji
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) { // can have MULTIPLE inits, cardContentFactory tells constructor what type of conent (ex: string) the card
        // cardContentFactory is function takes int and returns CardContent
        cards = Array<Card>() // empty array now initialized
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        // doing this is EmojiMemoryGame instead (viewModel)
        // cards.shuffle()
    }
    
    struct Card: Identifiable { // identifiable is ieterator
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent // don't care what the card will be when created passing the card 'type' <CardContent>
        var id: Int // this is for identifiable
    }
}
