//
//  DrawView.swift
//  KidsDraw
//
//  Created by Alberto Lourenço on 4/7/20.
//  Copyright © 2020 Alberto Lourenco. All rights reserved.
//

import UIKit

struct DrawLine {
    
    var color: UIColor
    var width: Float
    var points: Array<CGPoint>
}

final class DrawView: UIView {
    
    var lineColor: UIColor = .black
    
    private var lines: Array<DrawLine> = []
    private var linesRemoved: Array<DrawLine> = []
    
    override internal func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        lines.forEach { line in
            
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(5)
            context.setLineCap(.round)

            context.addLines(between: line.points)

            context.strokePath()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(DrawLine(color: lineColor, width: 5, points: []))
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard var line = lines.popLast() else { return } // get & remove last line
        guard let point = touches.first?.location(in: nil) else { return }
        
        line.points.append(point)
        lines.append(line)
        linesRemoved.removeAll() // clear redo

        setNeedsDisplay()
    }
    
    //------------------------------------------------
    //  MARK: - Public methods
    //------------------------------------------------
    
    func undo() {
        
        if let line = lines.last {
            linesRemoved.append(line)
            lines.removeLast()
        }
        
        setNeedsDisplay()
    }
    
    func redo() {
        
        if let line = linesRemoved.last {
            lines.append(line)
            linesRemoved.removeLast()
        }
        
        setNeedsDisplay()
    }
    
    func clear() {
        
        lines.removeAll()
        linesRemoved.removeAll()
        
        setNeedsDisplay()
    }
    
    func getImage() -> UIImage? {
        
        if lines.count > 0 {
            
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
            defer { UIGraphicsEndImageContext() }
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
            
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        
        return nil
    }
}
