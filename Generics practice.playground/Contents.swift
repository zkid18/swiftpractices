//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


let arrs = [1,2,4,5,6]

func incrementArray(xs:[Int]) -> [Int] {
    
    var newArr: [Int] = []
    
    for x in xs {
        newArr.append(x+10)
    }
    
    return newArr
    
}

incrementArray(arrs)


func doubleArray(xs: [Int]) -> [Int] {
    var newArr: [Int] = []
    
    for x in xs {
        newArr.append(x*2)
    }
    
    return newArr
}

doubleArray(arrs)


//MARK Make code more flexible
func computelnArray(xs: [Int], transform: Int->Int) -> [Int] {
    
    var newArr: [Int] = []
    
    for x in xs {
        newArr.append(transform(x))
    }
    
    return newArr
}

var increment: (Int) -> Int = {$0+10}
var double: (Int) -> Int = {$0*2}

computelnArray(arrs, transform: increment)
computelnArray(arrs, transform: double)

//or 

func doubleArray2(xs: [Int]) -> [Int] {
    
    return computelnArray(xs, transform: { x in x*2})
}


//Still not flexible
func computeBoolArray(xs: [Int], transform: Int -> Bool) -> [Bool] {
    var newArr: [Bool] = []
    
    for x in xs {
        newArr.append(transform(x))
    }
    
    return newArr
}


var lowerTwo: (Int) -> Bool = {$0<2}

computeBoolArray(arrs, transform: lowerTwo)


//MARK Make it far more flexible
func genericComputeArray1<T> (xs: [Int], transform: Int -> T) -> [T] {
    var newArr: [T] = []
    
    for x in xs {
        newArr.append(transform(x))
    }
    
    return newArr
}


genericComputeArray1(arrs, transform: lowerTwo)
genericComputeArray1(arrs, transform: double)


//MARK: Practicing in-build generic functions
//1. Filter

let exampleFiles = ["README.md", "HelloWorld.swift", "FlappyBird.swift"]

func filterArr(files: [String]) -> [String] {
    
    var result:[String] = []
    
    for file in files {
        if file.hasSuffix("swift") {
            result.append(file)
        }
    }
    
    return result
}

func filterArr2(files: [String]) -> [String] {
    return files.filter { file in file.hasSuffix("swift") }
}
filterArr(exampleFiles)
filterArr2(exampleFiles)


//2. Reduce

func sum(xs: [Int]) -> Int {
    var result = 0
    
    for x in xs {
        result += x
    }
    
    return result
}

func sumGen(xs: [Int]) -> Int {
    return xs.reduce(0, combine: {result, x in result + x})
}

sum(arrs)
sumGen(arrs)

func concat(xs: [String]) -> String {
    var result: String = ""
    
    for x in xs {
        result += x
    }
    
    return result
}

func concatGen(xs: [String]) -> String {
    return xs.reduce("", combine: +)
}

concat(exampleFiles)
concatGen(exampleFiles)


//3. Put all together

struct City {
    let name: String
    let population: Int
}


let paris = City(name: "Paris", population: 2241000)
let madrid = City(name: "Madrid", population: 3165000)
let amsterdam = City(name: "Amsterdam", population: 827000)
let berlin = City(name: "Berlin", population: 3562000)

// print a list of cities with at least one million inhabitants, together with their total populations

let cities = [paris, madrid, amsterdam, berlin]

cities
    .filter {city in city.population > 1000000}
    .reduce("City Population") {result, c in return result + "\n" + "\(c.name)" + "\(c.population)" }








