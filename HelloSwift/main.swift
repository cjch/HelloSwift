//
//  main.swift
//  HelloSwift
//
//  Created by jiechen on 16/1/20.
//  Copyright © 2016年 jiechen. All rights reserved.
//

import Foundation

print("Hello, World!")

//MARK: type
var n = Int(3.14)
print(n)

typealias Volume = Int
var vol:Volume = 100
print(vol)

//MARK: operator
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