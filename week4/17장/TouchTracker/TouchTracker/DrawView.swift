//
//  DrawView.swift
//  TouchTracker
//
//  Created by byung-soo kwon on 2017. 7. 24..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var currentLines: [NSValue:Line] = [:]
    var finishedLines: [Line] = []
    
    @IBInspectable var finishedLineColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentLineColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineThickness: CGFloat = 10.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // 선에 대한 설정들
    func strokeLine(line: Line) {
        let path = UIBezierPath()
        path.lineWidth = lineThickness
        path.lineCapStyle = CGLineCap.round
        degreeColor(line: line)
        finishedLineColor.setStroke()
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    // 그리자
    override func draw(_ rect: CGRect) {
        for line in finishedLines {
            strokeLine(line: line)
        }
        
        // 현재 라인이라면 빨강
        currentLineColor.setStroke()
        for (_, line) in currentLines {
            strokeLine(line: line)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        for touch in touches {
            let location = touch.location(in: self)
            let newLine = Line(begin: location, end: location)
            // UITouch 문서에서 UITouch 객체를 절대 리테인 하지 말라고 함
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.location(in: self)
            degreeColor(line: currentLines[key]!)
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key] {
                line.end = touch.location(in: self)
                finishedLines.append(line)
                currentLines.removeValue(forKey: key)
            }
        }
        setNeedsDisplay()
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        currentLines.removeAll()
        setNeedsDisplay()
    }
    
    func degreeColor(line: Line){
        let radian = atan2(-(line.end.y - line.begin.y), line.end.x - line.begin.x)
        let degree = radian * 180 / CGFloat.pi
        print(degree)
        switch degree {
        case -180 ... -90:
            finishedLineColor = UIColor.brown
        case -89 ... 0:
            finishedLineColor = UIColor.red
        default:
            finishedLineColor = UIColor.darkGray
        }
    }
}
