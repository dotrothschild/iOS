//
//  ContentView.swift
//  Memorize
//
//  Created by Shimon Rothschild on 1-02-21.
//

import SwiftUI



struct ContentView: View {

    var viewModel: EmojiMemoryGame
    
    var body: some View {
        
        HStack {             
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                        viewModel.choose(card: card) }
            }
        }
        
        .padding()
        .foregroundColor(Color.orange)
        .font(EmojiMemoryGame.useBigFont ? Font.largeTitle: Font.title)
    }
    
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
       
        ZStack(){
            if (card.isFaceUp) {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3).aspectRatio(2/3, contentMode: .fit)// stroke makes a 1 point line around edge
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill().aspectRatio(0.75, contentMode: .fit)
                
            }
        }
    }
}








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
