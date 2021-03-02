//
//  Cardify.swift
//  Memorize
//
//  Created by Shimon Rothschild on 1-03-21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    var gradient: Gradient
    
    init(isFaceUp: Bool, gradient: Gradient) {
        rotation = isFaceUp ? 0 : 180
        self.gradient = gradient
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get {return rotation}
        set {rotation = newValue}
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }
            .opacity(isFaceUp  ? 1 : 0)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))// don't need this because moved to single line in HStack.aspectRatio(2/3, contentMode: .fit)
                    .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(
            Angle.degrees(rotation),
            axis: (0,1,0))
        
    }
    private let cornerRadius: CGFloat = 10.0 // not a generic float, but must write exactly the data type
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool, gradient: Gradient) ->some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, gradient: gradient))
        
    }
    
}
