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
                             self.viewModel.choose(card: card)
                    }
                    .padding(5)
                }
                .padding()
                .foregroundColor(viewModel.theme.color)
                Text("Score: \(viewModel.score)")
            }
            .navigationBarTitle("\(viewModel.theme.name)")
            .navigationBarItems(trailing: Button("New Game") {
                viewModel.newGame()
            })
        }
    }
}

struct CardView: View {
    var card: EmojiMemoryGameModel<String>.Card
    let gradient: Gradient
    
    var body: some View {
        // need geometry to size font in card
        GeometryReader { geometry in   // default inserted this next <#T##(GeometryProxy) -> _#>)// lesson 3
            ZStack(){
                if (card.isFaceUp) {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)// moved to HStack .aspectRatio(2/3, contentMode: .fit)// stroke makes a 1 point line around edge
                    Text(card.content)
                } else {
                    // only flip if !matched else is matched 'magically' removes card
                    if !card.isMatched {
                       RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))// don't need this because moved to single line in HStack.aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            //.font(Font.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor)) // because it touches edge, do *0.75
            .font(Font.system(size: fontSize(for: geometry.size)))
        }
    }
    // MARK: -  Drawing constants to move magic numbers out of code
    let cornerRadius: CGFloat = 10.0 // not a generic float, but must write exactly the data type
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGameViewModel())
    }
}
