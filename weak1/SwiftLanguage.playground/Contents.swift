//: Playground - noun: a place where people can play

import UIKit

let somePoint = (4,1)
switch somePoint {
case (0,0):
    print("(0,0) is at the origin")
case (_, 0):
    print("\(somePoint.0), 0) is on the x-axis")
case (0,_):
    print("0, \(somePoint.1) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("out side the box")
}


let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x,y) where x == y:
    print("\(x), \(y) is on the line x == y")
case let (x,y) where x == -y:
    print("\(x), \(y) is on the line x == -y")
case let (x,y):
    print("\(x), \(y) is just some arbitary point")
    
    
}


let puzzleInput = "great minds think alike"
var puzzleOutput = ""
for character in puzzleInput.characters{
    switch character {
    case "a", "e", "i", "o", "u":
        puzzleOutput.append("ㅁ")
        continue
    default:
        puzzleOutput.append(character)
    }

}
print(puzzleOutput)


func greet(person: [String: String]){
    guard let name = person["name"] else {
        return
    }
    print("Hello \(name)!")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you")
        return
    }
    
    print("I hope the weather is nice in \(location).")
}

greet(person: ["name" : "John"])

greet(person: ["name" : "Jane", "location": "Cupertino"])



func greet(person: String) -> String{
    let greeting = "Hello," + person + "!"
    return greeting
}

print(greet(person: "Anna"))

func greetAgain(person: String) -> String{
    return "Hello again" + person + "!"

}

print(greetAgain(person: "Anna"))


func greet(person: String, alreadyGreeted: Bool) -> String{
    if alreadyGreeted{
        return greetAgain(person: person)
    }else {
        return greet(person: person)
    }
}


print(greet(person: "Tim", alreadyGreeted: true))


func minMax(array: [Int]) -> (min: Int, max: Int){
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count]{
        if value < currentMin{
            currentMin = value
        }else if value > currentMax{
            currentMax = value
        }
    }
    
    return (currentMin, currentMax)
    
}

let bounds = minMax(array: [6,3,1,2,3,21,-23,13,4,644])

print("min is \(bounds.min) and max is \(bounds.max)")


let digitNames = [ 0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four", 5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine" ]
let numbers = [16, 58, 510]

let strings = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    }while number > 0
    print(output)
        return output
}


