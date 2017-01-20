//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//value type

struct PointStruct {
    var x: Int
    var y: Int
}

var structPoint = PointStruct(x: 1, y: 2)
var sameStructPoint = structPoint

sameStructPoint.x = 3
structPoint // x = 1 y =2

//class are reference types

class PointClass {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

var classPoint = PointClass(x: 1, y: 2)
var sameClassPoint = classPoint


classPoint.x = 3
classPoint // x =3 y =2


func setStructToOrigin(var point: PointStruct) -> PointStruct {
    point.x = 0
    point.y = 0
    
    return point
}

var structOrigin: PointStruct = setStructToOrigin(structPoint)

func setClassToOrigin(var point: PointClass) -> PointClass {
    point.x = 0
    point.y = 0
    
    return point
}


var classOrigin: PointClass = setClassToOrigin(classPoint)

let immutablePoint = PointStruct(x:2, y:3)
//immutablePoint = PointStruct(x: 3, y: 2) //rejected

let mutablePoint = PointClass(x: 2, y: 3)
//mutablePoint = PointClass(x: 3, y: 2) //rejected




