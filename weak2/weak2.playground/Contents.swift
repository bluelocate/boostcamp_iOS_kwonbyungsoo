//: Playground - noun: a place where people can play

import UIKit


class Counter{
    var count = 0
    func increment(){
        //self는 현재 인스턴스를 참조
        count += 1
    }
    
    func increment(by amount: Int){
        count += amount
        
        print(count)
    }
    func reset(){
        count = 0
    }
}

let counter = Counter()

counter.increment() // count = 1
counter.increment(by: 5) // count = 6
counter.reset() // count = 0


struct Point{
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double){
        x += deltaX
        y += deltaY
    }
    
    //위 코드와 차이점이란?
    mutating func moveBy2(x deltaX:Double, y deltaY: Double){
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}

var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 3.1, y: 3.4)


enum TriStateSwitch{
    case off, low, high
    mutating func next(){
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off

        }
    }
}

var ovenLight = TriStateSwitch.low
ovenLight.next()