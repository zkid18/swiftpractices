//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

protocol GeneratorType {
    typealias Element
    func next() -> Element?
}

protocol SequenceType {
    typealias Generator: GeneratorType
    func generate() -> Generator
}


class CountdownGenerator: GeneratorType {
    
    var element: Int
    
    init <T>(array: [T]) {
        self.element = array.count - 1
    }
    
    func next() -> Int? {
        return self.element < 0 ? nil : element--
    }
    
}

//define a sequence that generates a series of array indexes

struct ReverseSequence<T>: SequenceType {
    var array: [T]
    
    init (array: [T]) {
        self.array = array
    }
    
    func generate() -> CountdownGenerator {
        return CountdownGenerator(array: array)
    }
}

class PowerGenerator: GeneratorType {
    var power: NSDecimalNumber = 1
    let two: NSDecimalNumber = 2
    
    func next() -> NSDecimalNumber? {
        power = power.decimalNumberByMultiplyingBy(two)
        return power
    }
}

class FileLinesGenerator: GeneratorType {
    typealias Element = String
    
    var lines: [String] = []
    
    init (filename: String) throws {
        let contents: String = try String(contentsOfFile: filename)
        let newLine = NSCharacterSet.newlineCharacterSet()
        lines = contents.componentsSeparatedByCharactersInSet(newLine)
    }
    
    func next() -> Element? {
        guard !lines.isEmpty else {return nil}
        let nextLine = lines.removeAtIndex(0)
        return nextLine
    }
}

extension PowerGenerator {
    func findPower(prdicate: NSDecimalNumber -> Bool) -> NSDecimalNumber {
        while let x = next() {
            if prdicate(x) {
                return x
            }
        }
        
        return 0
    }
}

extension GeneratorType {
    func findPower(predicate: Element-> Bool) -> Element? {
        while let x = self.next() {
            if predicate(x) {
                return x
            }
        }
        
        return nil
    }
    
}

let arrSample = ["A","B","C"]

let generator = CountdownGenerator(array: arrSample)

let reverseSequence = ReverseSequence(array: arrSample)
let reverseGenerator = reverseSequence.generate()

while let i = generator.next() {
    print("Element \(i) of array is \(arrSample[i])")
}

print(PowerGenerator().findPower { $0.integerValue > 1000 })


while let j = reverseGenerator.next() {
    print("Element \(j) of array is \(reverseGenerator)")
}




