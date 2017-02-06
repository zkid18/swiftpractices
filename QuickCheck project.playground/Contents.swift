//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


struct ArbitaryInstance<T> {
    let arbitary: () -> T
    let smaller: T -> T?
}

protocol GeneratorType {
    typealias Element
    func next() -> Element?
}

protocol SequenceType {
    typealias Generator: GeneratorType
    func generate() -> Generator
}

//Apply generators
extension GeneratorType {
    mutating func find(predicate: Element -> Bool) -> Element? {
        while let x = self.next() { if predicate(x) {
            return x }
        }
        return nil
    }
}



//protocol, that returns a value of type Self.

protocol Arbitary {
    static func arbitary() -> Self
}

//To shrink counterexamples that were covered by our tests.

protocol Shorten {
    func smaller() -> Self?
}

//Generating randomn Int

extension Int: Arbitary {
    static func arbitary() -> Int {
        return Int(arc4random())
    }
}

extension Int: Shorten {
    func smaller() -> Int? {
        return self == 0 ? nil : self/2
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

extension Array: Shorten {
    func smaller() -> [Element]? {
        guard !isEmpty else { return nil }
        return Array(dropFirst())
    }
}


extension Array where Element:Arbitary {
    static func arbitary() -> [Element] {
        let randomnLenth = Int(arc4random() % 50)
        return tabulate(randomnLenth) { _ in Element.arbitary() }
    }
}

extension String: Shorten {
    func smaller() -> String? {
        return isEmpty ? nil : String(characters.dropFirst())
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


//Practice

Int.arbitary()

100.smaller()

String.arbitary()

String.arbitary()

"London is a capital".smaller()

[1,2,3].smaller()



//Check condition function

func checkOne <A: Arbitary> (message: String, _ property: A -> Bool) -> () {
    
    let numberOfIterations = 2
    
    for i in 0..<numberOfIterations {
        let value = A.arbitary()
        
        guard property(value) else {
            
            print ( " \"\( message)\" doesn't hold: \(value)")
            return
        }
        
    }
    
    print ( " \"\( message)\" passed \(numberOfIterations) tests.")
    
}


//Check String
checkOne("Every String starts with Hello", { (s: String) in
    s.hasPrefix("Hello")
})


func iterateWhile<A>(condition: A-> Bool, initial: A, next: A-> A?) -> A {
    if let x = next(initial) where condition(x) {
        return iterateWhile(condition, initial: x, next: next)
    }
    
    return initial
}




func quickSort(var array: [Int]) -> [Int] {
    if array.isEmpty {return [0]}
    
    let pivot = array.removeAtIndex(0)
    let lesser = array.filter { $0 < pivot }
    let greater = array.filter { $0 > pivot }
    
    return quickSort(lesser) + [pivot] + quickSort(greater)
    
}







