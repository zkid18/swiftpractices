//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


struct Parser <Token, Results> {
    let p: ArraySlice<Token> -> AnySequence<(Results, ArraySlice<Token>)>
}

extension ArraySlice {
    var decompose: (Element, [Element])? {
        return isEmpty ? nil : (self[startIndex], Array(self.dropFirst()))
    }
}

func one<A>(x:A) -> AnySequence<A> {
    return AnySequence(GeneratorOfOne(x))
}

extension AnySequence {
    var none: AnySequence {
        return AnySequence(self.none)
    }
}

typealias Calculator = Parser <Character, Int>


func operator0(character: Character, _ evaluate: (Int, Int) -> Int, _ operand: Calculator) -> Calculator {
    return curry { evaluate($0, $1) } </> 
}