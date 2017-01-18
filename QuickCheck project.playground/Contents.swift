//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


protocol Arbitary {
    static func arbitary() -> Self
}

//Generating randomn Int

extension Int: Arbitary {
    static func arbitary() -> Int {
        return Int(arc4random())
    }
}

extension Int {
    static func random(from from:Int, to: Int) -> Int {
        return from + (Int(arc4random()) % (to - from))
    }
}

extension String: Arbitary {
    static func arbitary() -> String {
        let randomnLeth = Int.random(from: 0, to: 40)
        let randomnCharacter = tabulate(randomnLeth, transform: { _ in
            Character.arbitary()
        })
        
        return String(randomnCharacter)
    }
    
}

//Generating randomn String

extension Character:Arbitary {
    static func arbitary() -> Character {
        return Character(UnicodeScalar(Int.random(from: 60, to: 95)))
    }
}

func tabulate<A>(times: Int, transform: Int -> A) -> [A] {
    return (0..<times).map(transform)
}



Int.arbitary()

String.arbitary()

String.arbitary()
