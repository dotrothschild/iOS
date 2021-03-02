//  *******************************
//  *********** VIEW (Kotlin: Activity)
//  *******************************

//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Shimon Rothschild on 1-02-21.
//

import SwiftUI



struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGameViewModel //
    var body: some View {
        NavigationView {
            VStack {
                Grid(viewModel.cards)  {card in  // 2nd param is function , viewForItem: {... in swift, don't need to explicitly state it
                    CardView(card: card,
                             gradient: Gradient(colors: [self.viewModel.theme.color, self.viewModel.theme.accent]))
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.75)) {
                                self.viewModel.choose(card: card)
                            }
                           
                        }
                        .padding(5)
                    
                }
                .padding()
                .foregroundColor(viewModel.theme.color)
                Text("Score: \(viewModel.score)")
            }
            .navigationBarTitle("\(viewModel.theme.name)")
            // works original::  .navigationBarItems(trailing: Button("New Game") {
            .navigationBarItems(trailing: Button(action: {
                withAnimation(.easeInOut(duration: 1)) {
                    viewModel.newGame()
                }
            }, label: { Text("New Game") }))
        }
    }
}

struct CardView: View {
    var card: EmojiMemoryGameModel<String>.Card
    let gradient: Gradient
    
    var body: some View {
        // need geometry to size font in card
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0 // need this because animations only show past. Initial setting of clock is 0, but that is in future
    // so can't use card.bonusRemaining, and model won't update every 1/10 second, this gets updated
    
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaing
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    // becuase declaures opaque return type view, but empty view on 'else' declare method as @ViewBuilder
    @ViewBuilder
    private func body (for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack(){
                Group {
                // works, but want custom shape, new file for shape::  Circle().padding(5).opacity(0.4)
                // how to set animatedBonus time to know card.bonusTimeRemaing (around hour 1:30 of lesson video 6
                if card.isConsumingBonusTime {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                   
                    .onAppear() { // this synch
                        startBonusTimeAnimation()
                    }
                } else {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaing*360-90), clockwise: true)                }
                }
                    .padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360: 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1.0).repeatForever(autoreverses: false) : .default)
            }
            
            .cardify(isFaceUp: card.isFaceUp, gradient: gradient) // the extenision defined in file Cardify
            .transition(AnyTransition.scale)
            
        }
    }
    // MARK: -  Drawing constants to move magic numbers out of code
    // connstants can be private
    
    private let fontScaleFactor: CGFloat = 0.75
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGameViewModel()
        game.choose(card: game.cards[0]) // statically select card to see front
        game.choose(card: game.cards[1])
        
        return  EmojiMemoryGameView(viewModel: game)
    }
}
