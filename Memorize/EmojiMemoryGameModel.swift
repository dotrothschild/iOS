//  **************************************************************
//  ***********************  Model *******************************
//  **************************************************************

//  MemoryGame.swift
//  Memorize
//
//  Created by Shimon Rothschild on 2-02-21.
//


import Foundation

// only at run time is the 'face' <CardContent> of the card determined, ex string (Emoji), image etc
struct EmojiMemoryGameModel<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var score = 0
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set { // the setter flips all cards face down, that's what it sets
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue // same as code commented out
            }
        }
    }
    
    mutating func choose(card: Card) { // functions that change 'self' in struct must be mutating
        // dont want to print, kept for code reference print("card chosen : \(card)")
        // find the index of selected card to get reference to the card
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched { // , is sequential and
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
           
        }
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
        cards.shuffle() // with here, the click to reverse works correctly with @Published private var model: MemoryGame<String>
    }
    
    struct Card: Identifiable { // identifiable is ieterator
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent // don't care what the card will be when created passing the card 'type' <CardContent>
        var id: Int // this is for identifiable
    }
}
