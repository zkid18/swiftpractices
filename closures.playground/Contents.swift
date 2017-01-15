//: Playground - noun: a place where people can play

import UIKit

//Practicing closures

//function
func timesTenFunction(number: Int) -> Int {
    return number*10
}

timesTenFunction(10) //100


//closure
var timesTenClosure: (Int) -> Int = { $0 * 10 }

timesTenClosure(10) //100

func sum(from: Int, to: Int, closure: (Int) -> (Int)) -> Int {
    
    var sum = 0
    for i in from...to {
        sum += closure(i)
    }
    
    return sum
}


sum(10, to: 20, closure: timesTenClosure) //1650
sum(10, to: 20, closure: timesTenFunction) //1650

//shorten version of closure
sum(0, to: 20,closure:{ $0*10} )

//long version of closure
sum(0, to: 20, closure: { number in return number*10 })


//Trailing closure
sum(0, to: 10) { number in
    return number*10
}

sum(0, to: 10) { $0*10 }


//Escaping closures

var completionHandlers: [() -> Void] = []

func functionWithComletionHandler(block: () -> Void) {
    completionHandlers.append(block)
}


//for storing in a variable, defined outside the function
func functionWithCompletionHandlerEscaping(block: @escaping () -> Void) {
    completionHandlers.append(block)
}




