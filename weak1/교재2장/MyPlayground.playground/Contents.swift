//: Playground - noun: a place where people can play

import UIKit


var str = "Hello, playground"
str = "Hello, Swift"
let constStr = str
//constStr = "Hello, world" 는 안됨

var nextYear: Int
var bodyTemp: Float
var hasPet: Bool

//var arrayOfInts: Array<Int>
var arrayOfInts: [Int]

//var dictionaryOfCapitalsByCountry: Dictionary<String,String>
var dictionaryOfCapitalsByCountry: [String: String]

var winningLotteryNumbers: Set<Int>

let number = 42
let fmStation = 91.1

//이니셜라이저
let meaningOfLife = String(number)

//서브스크립팅
var countingUp = ["one", "two"]
let secondElement = countingUp[1]
countingUp.count
countingUp.append("three")


let nameByParkingSpace = [13: "Alice", 27: "Bob"]
let space13Assignee: String? = nameByParkingSpace[13]
let space42Assignee: String? = nameByParkingSpace[42]

if let space13Assignee = nameByParkingSpace[13]{
    print("Key 13 is assigned in the dictionary!")
}

//튜플 사용
for (space, name) in nameByParkingSpace{
    let permit = "Space \(space): \(name)"
}

//타입별 기본값
let emptyString = String()
emptyString.isEmpty
let emptyArrayOfInts = [Int]()
let emptySetOfFloats = Set<Float>()

let defaultNumber = Int()
let defaultBool = Bool()

let availableRooms = Set([205,411,412])

let defaultFloat = Float()
let floatFromLiteral = Float(3.14)

let easyPi = 3.14
let floatFromDouble = Float(easyPi)
let floatingPi: Float = 3.14

//옵셔널 바인딩
var reading1: Float?
var reading2: Float?
var reading3: Float?

reading1 = 9.8
reading2 = 9.2
reading3 = 9.7
//let avgReading = (reading1 + reading2 + reading3) / 3
//let avgReading = (reading1! + reading2! + reading3!) / 3

if let r1 = reading1, let r2 = reading2, let r3 = reading3{
    let avgReading = (r1 + r2 + r3) / 3
}else {
    let errorString = "Instrument reported a reading that was nil."
}


enum PieType{
    case Apple
    case Cherry
    case Pecan
}
let favoritePie = PieType.Apple

let name: String
switch favoritePie {
case .Apple:
    name = "Apple"
case .Cherry:
    name = "Cherry"
case .Pecan:
    name = "Pecan"

}









