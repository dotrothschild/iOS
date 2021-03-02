//  **************************************************************
//  ***********************  Model *******************************
//  **************************************************************

//  MemoryGame.swift
//  Memorize
//
//  Created by Shimon Rothschild on 2-02-21.
//  Timer function is NOT completed


import Foundation

// only at run time is the 'face' <CardContent> of the card determined, ex string (Emoji), image etc
struct EmojiMemoryGameModel<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card> // Access control: write is private, read public
    var score = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
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
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched { // , is sequential and
            cards[chosenIndex].flipCount += 1
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    // no matter how many times seen add 2 points
                    score += 2
                } // no match and flip second card over to see this
                else {
                    // is it 2nd time seeing and no match
                    if (cards[chosenIndex].flipCount > 1) {
                        score -= 1}
                    if (cards[potentialMatchIndex].flipCount > 1) {
                        score -= 1}                }
                self.cards[chosenIndex].isFaceUp = true
                
            } else { // it is the first card
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
    
    struct Card: Identifiable { // identifiable is ieterator -- because the array is private, it's ok that card not set private
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var content: CardContent // don't care what the card will be when created passing the card 'type' <CardContent>
        var flipCount: Int = 0
        var id: Int // this is for identifiable
        
        // MARK: - Bonus Time
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        var bonusRemaing: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}

