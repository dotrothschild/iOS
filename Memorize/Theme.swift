//
//  Themes.swift
//  Memorize
//
//  Created by Shimon Rothschild on 22-02-21.
//

import SwiftUI

struct Theme {
    var name: String
    var emojis: [String]
    var color: Color
    var accent: Color
    var pairsOfCard: Int?

    
    static let halloween = Theme(name: "Halloween", emojis: ["👻", "🎃","🕷","💀","🧙"], color: .orange, accent: .white)
    static let cats = Theme(name: "Cats", emojis: ["😺", "😸", "😹", "😻", "🙀", "😿", "😾", "😼"], color: .gray, accent: .blue, pairsOfCard:8)
    static let flags = Theme(name: "Flags", emojis: ["🇸🇬","🇯🇵","🏴‍☠️","🏳️‍🌈","🇬🇧","🇹🇼","🇺🇸","🇦🇶","🇰🇵","🇭🇰","🇲🇨","🇼🇸"], color: .red, accent: .black)
    static let places = Theme(name: "Places", emojis: ["🗽","🗿","🗼","🎢","🌋","🏝","🏜","⛩","🕍","🕋","🏯","🏟"], color: .blue, accent: .white,pairsOfCard: 6)
    static let food = Theme(name: "Food", emojis: ["🌮","🍕","🍝","🍱","🍪","🍩","🥨","🥖","🍟","🍙","🍢","🍿"], color: .yellow, accent: .blue)
    static let sports = Theme(name: "Sports", emojis: ["🤺","🏑","⛷","⚽️","🏀","🪂","🥏","⛳️","🛹","🎣","🏉","🏓"], color: .black, accent: .green )
    
    static var themes: [Theme] = [halloween, cats, flags, places, food, sports]
}

// additional theme I don't use
//name: "Animals",
//        emojis: ["🦑","🦧","🦃","🦚","🐫","🦉","🦕","🦥","🐸","🐼","🐺","🦈"],
// techno, zodiac, vegetables, flowers
