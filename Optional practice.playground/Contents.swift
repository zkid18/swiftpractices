//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//infix operator??

//MARK: Operator oveloading

var sumWithMultiplication = 1 + 3 - 3 * 2
var arr1 = [1,2]
var arr2 = [2,2]

func add(left:[Int], right:[Int]) -> [Int] {
    
    var result = [Int]()
    
    assert(left.count == right.count, "Array size is equal")
    
    for (key,_) in right.enumerate() {
        
        result.append(left[key] + right[key])
        
    }
    
    return result
}

add(arr1, right: arr2) //[3,4]


infix operator ++ {associativity left precedence 150}

func ++(left:[Int], right:[Int]) -> [Int] {
    
    var result = [Int]()
    
    assert(left.count == right.count, "Array size is equal")
    
    for (key,_) in right.enumerate() {
        
        result.append(left[key] + right[key])
        
    }
    
    return result
}

arr1 ++ arr2 //[3,4]


infix operator ?? {associativity right precedence 110}


func ??<T>(optional: T?, defaultValue: ()-> T) -> T {
    if let x = optional {
        return x
    } else {
        return defaultValue()
    }
}


let cities = ["Paris": 2241, "Madrid": 3165, "Amsterdam": 827, "Berlin": 3562]
var defaultValue = 1000

var madridPopulation = cities["Madrid"] ?? defaultValue


//MARK Combine optional binding to handle None Case
func populationDescriptionForCity(city: String) -> String? {
    guard let population = cities[city] else { return nil }
    return "The population of Madrid is \(population * 1000)"
}

populationDescriptionForCity("Madrid")

//MARK Use map to optionals
func incrementOptionals(optional: Int?) -> Int? {
    return optional.map {$0 + 1}
}




