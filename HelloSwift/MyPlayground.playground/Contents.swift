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
    
    subscript(index: Int) -> Int {
        get {
            if index == 0 {
                return width
            } else {
                return height
            }
        }
        set {
            if index == 0 {
                width = newValue
            } else {
                height = newValue
            }
        }
    }
}

var resolution = Resolution(width: 6, height: 7)

var length = resolution.length
resolution.length = length

resolution.modifyW(10, h: 11)
resolution.modify1W(20, height: 22)

resolution[0] = 14


//MARK: initialization
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "default food")
    }
}

// Ingredient通过自定义的方式提供了Food的所有指定构造器，因此其继承了Food的所有便利构造器
class Ingredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        //必须先初始化quantity，再调用super.init
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
let oneMys = Ingredient()
let oneBak = Ingredient(name: "bake")
let fiveEggs = Ingredient(name: "egg", quantity: 5)

//ShoppingItem 继承Ingredient和Food的指定构造器，同时也继承了他们的便利构造器
class ShoppingItem: Ingredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name) "
        output += purchased ? "purchased" : "not purchased"
        return output
    }
}
let breakList = [
    ShoppingItem(),
    ShoppingItem(name: "bread"),
    ShoppingItem(name: "egg", quantity: 3)
]

for item in breakList {
    print(item.description)
}


