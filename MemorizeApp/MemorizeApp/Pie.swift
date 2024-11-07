//
//  Pie.swift
//  MemorizeApp
//
//  Created by Mahadik, Amit on 11/6/24.
//

import SwiftUI
import CoreGraphics

struct Pie: Shape {
    var startAngle: Angle = .zero
    let endAngle: Angle 
    
    func path(in rect: CGRect) -> Path {
        
        let startAngle = startAngle - .degrees(90)
        let endAngle = endAngle - .degrees(90)
        
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(x: center.x + radius * cos(startAngle.radians), y: center.y + radius * sin(startAngle.radians))
        
        var path = Path()
        path.move(to: center)
        path.addLine(to: start)
        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false)
        
        path.addLine(to: center)
        
        return path
        
    }
}
