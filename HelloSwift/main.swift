//
//  main.swift
//  HelloSwift
//
//  Created by jiechen on 16/1/20.
//  Copyright © 2016年 jiechen. All rights reserved.
//

import Foundation

print("Hello, World!")

//MARK: - type
var n = Int(3.14)
var n1 = 3.141 as Int
print(n, n1)

typealias Volume = Int
var vol:Volume = 100
print(vol)

//MARK: - operator
print("close - close")
for num in 1...3 {
    print(num)
}

print("close - open")
for num in 1..<3 {
    print(num)
}

var str: String?
print(str ?? "nil variable")
str = "non empty variable"
print(str ?? "nil variable")

//MARK: - collection
let sList = ["ab", "ab1"]
var sList1: [String] = ["ab2", "ab3"]
var sList2: Array<String> = ["ab4", "ab5"]
print(sList, sList1, sList2)

let aSet: Set<Character> = ["c", "h", "a"]
let aSet1: Set = ["cc", "hh", "aa"]
print(aSet, aSet1)

let aDict: Dictionary<Int, String> = [1: "aaa"]
var aDict1: [Int: String] = [2: "bbb"]
var aDict2 = [2: "bbb"]
print(aDict, aDict1, aDict2)

//MARK: - switch, where
let point = (4, 4)
switch point {
case (0, 0):
    print("\(point) is at origin")
case (_, 0):
    print("(\(point.0), 0) is at x-axis")
case let (x, y) where x == y:
    print("\(point) is on the line x == y")
case (0, let y):
    print("(0, \(y)) is at y-axis")
case (-2...2, -2...2):
    print("\(point) is inside box")
default:
    print("\(point) is outside box")
}

let wx: Int? = 5
let wy: Int? = -5
if let x = wx, y = wy where x == -y {
    print("(\(x), \(y)) is on the line x == -y")
}

//MARK: - func
func swipInts(inout a: Int, inout b: Int) {
    let temp = a;
    a = b;
    b = temp;
}

var ia = 5, ib = 6
print("before swap: ", ia, ib)
swipInts(&ia, b: &ib)
print("after swap: ", ia, ib)

//MARK: - closure
func compareStr(s1: String, s2: String) -> Bool {
    return s1 > s2
}

let originList = ["I", "have", "an", "apple", "!"]
let rst1 = originList.sort(compareStr)
let rst2 = originList.sort(>)
print("function sort: ", rst1, rst2, separator: "\n")

//以下几种闭包写法是一样的
let rst3 = originList.sort({ (s1: String, s2: String) -> Bool in return s1 > s2 })
let rst4 = originList.sort({ s1, s2 in return s1 > s2 })
let rst5 = originList.sort({ $0 > $1 })
print("closure sort: ", rst3, rst4, rst5, separator: "\n")
