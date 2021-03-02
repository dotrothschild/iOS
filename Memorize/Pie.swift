//  *** This draws the lines for a pie,
//  *** first slice, last slice and between them the circumference of the pie
//  Pie.swift
//  Memorize
//
//  Created by Shimon Rothschild on 1-03-21.
//

import SwiftUI

struct Pie: Shape { // shape inherits from animatible so don't need to add it, just use animatableData
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    var animatableData: AnimatablePair<Double,Double> { // the start and end angles
        get {
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        // start with middle for drawing lines
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius  = min(rect.width, rect.height) / 2  // this makes the circle radius fit within the smaller size of card
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise
        )
        p.addLine(to: center)
        return p
    }
}
