//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

//MARK: enum
enum Direction: String {
    case East
    case South
    case West
    case North
}

var dct = Direction.East
dct = .South
let drw = dct.rawValue

switch dct {
case .East:
    print("east direction")
default:
    print("other direction")
}

enum Product {
    case Name(String)
    case ID(Int)
}
var product = Product.Name("cake")
product = .ID(99)

switch product {
case let .Name(name):
    print(name)
case let .ID(id):
    print(id)
}

enum Week: Int {
    case Sun = 0, Mon
}

var wk = Week.Mon
var rv = wk.rawValue

var nDay = Week(rawValue: 2)
var nDay1 = Week(rawValue: 0)


struct Resolution {
    var width = 0
    var height = 0
    
    var length:Int {
        get {
            return min(width, height)
        }
        set {
            width = newValue
            height = newValue
        }
    }
    
    var minLength: Int {
        return min(width, height);
    }
    
    mutating func modifyW(w: Int, h: Int) {
        width = w
        height = h
    }
    mutating func modify1W(w: Int, height h: Int) {
        self = Resolution(width: w, height: h)
    }
}
var resolution = Resolution(width: 6, height: 7)

var length = resolution.length
resolution.length = length

resolution.modifyW(10, h: 11)
resolution.modify1W(20, height: 22)



