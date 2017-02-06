//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

enum LookUpError: ErrorType {
    case CapitalNotFound
    case PopulationNotFound
}

enum PopualtionResult {
    case Success(Int)
    case Error(LookUpError)
}

enum Add<T,U> {
    case InLeft(T)
    case InRight(T)
}


let exampleSuccess: PopualtionResult = .Success(100)

let mayors = [

    "Madrid": "Carmena", "Amsterdam": "van der Laan", "Berlin": "Müller", "Paris": "Hiago"

]

struct City {
    var name: String
    var population: Int
}

//The ismorphism of two types

enum add<T,U> {
    case addRight(T)
    case addLeft(U)
}

enum Zero {}


struct Times<T,U> {
    let fst: T
    let snd: U
}

typealias One = ()

//Creating binary search tree

func empty<Element>() -> [Element] {
    return []
}

func isEmpty<Element>(set: [Element]) -> Bool {
    return set.isEmpty
}

func contains<Element: Equatable>(x: Element, _ set: [Element]) -> Bool {
    return set.contains(x)
}

func insert<Element: Equatable> (x: Element, _ set: [Element] ) -> [Element] {
    return contains(x, set) ? set: [x] + set
 }

indirect enum BinarySearchTree<Element: Comparable> {
    case Leaf
    case Node(BinarySearchTree<Element>, Element, BinarySearchTree<Element>)
}


let leaf: BinarySearchTree<Int> = .Leaf
let five: BinarySearchTree<Int> = .Node(leaf, 5, leaf)


extension BinarySearchTree {
    init() {
        self = .Leaf
    }
    
    init(_ value: Element) {
        self = .Node(.Leaf, value, .Leaf)
    }
}


extension BinarySearchTree {
    var count: Int {
        switch self {
        case .Leaf:
            return 0
        case let .Node(left, _, right):
            return 1 + left.count + right.count
            
        }
    }
}


extension BinarySearchTree {
    var elements: [Element] {
        switch self {
        case .Leaf:
            return []
        case let .Node(left, x , right):
            return left.elements + right.elements + [x]
        
        }
    }
}

extension BinarySearchTree {
    var isEmpty: Bool {
        if case .Leaf = self {
            return true
        }
        
        return false
        
    }
}

extension SequenceType {
    func all(predicate: Generator.Element -> Bool) -> Bool {
        for x in self where !predicate(x) {
            return false
        }
        
        return true
    }
}


extension BinarySearchTree {
    func hasOccured(x: Element) -> Bool {
        switch self {
        case .Leaf:
            return false
        case let .Node(_, y, _) where x==y :
            return true
        case let .Node(left, y, _) where x<y :
            return left.hasOccured(x)
        case let .Node(_, y, right) where x>y:
            return right.hasOccured(x)
        default:
            fatalError()
        }
    }
}


extension BinarySearchTree {
    mutating func inser(x: Element) {
        switch self {
        case .Leaf:
            self = BinarySearchTree(x)
        case .Node(var left, var y, var right):
            if x<y {left.inser(x)}
        case .Node(var left, var y, var right):
            if x>y {right.inser(x) }
        default:
            fatalError()
                
        }
    }
}


extension Array {
    var decomposite: (Element, [Element])? {
        return isEmpty ? nil : (self[startIndex], Array(self.dropFirst()))
    }
}

var sampleArr = [1,2,5,8,9]
print(sampleArr.decomposite)



//recursive sum of two arrays
func sum(xs: [Int]) -> Int {
    guard let (head, tail) = xs.decomposite else { return 0 }
    return head + sum(tail)
}

var arr1 = [1,2,4]
var arr2 = [3,4,2]

var a = sum(arr1)
a


func qsort(input: [Int]) -> [Int] {
    
    guard let(pivot, rest) = input.decomposite else {return []}
    let lesser = rest.filter { $0 < pivot }
    let greater = rest.filter { $0 > pivot }
    return qsort(lesser) + [pivot] + qsort(greater)

}


let input = [4,5,7,9,10,33,29]

qsort(input)


struct Trie<Element: Hashable> {
    let isElement: Bool
    let children: [Element: Trie]
    
}

extension Trie {
    init() {
        isElement = false
        children = [:]
    }
}


//extension for flatten tuple into array
extension Trie {
    var elements: [[Element]] {
        var result: [[Element]] = isElement ? [[]]: []
        
        for (key, value) in children {
            result += value.elements.map { [key] + $0}
        }
        
        return result
    }
}



extension Trie {
    func lookup(key: [Element]) -> Bool {
        guard let (head, tail) = key.decomposite else {return isElement}
        guard let subchild = children[head] else { return false}
        return subchild.lookup(tail)
    }
}


extension Trie {
    func withPrefix(prefix: [Element]) -> Trie<Element>? {
        guard let (head, tail) = prefix.decomposite else { return self }
        guard let remainder = children[head] else { return nil }
        return remainder.withPrefix(tail)
    }
}


extension Trie {
    func autocomplete(key: [Element]) -> [[Element]] {
        return withPrefix(key)?.elements ?? []
    }
}

extension Trie {
    init (_ key: [Element]) {
        if let (head, tail) = key.decomposite {
            let children = [head: Trie(key)]
            self = Trie(isElement: false, children: children)
        } else {
            self = Trie(isElement: true, children: [:])
        }
    }
}


extension Trie {
    mutating func insert(key: [Element]) -> Trie<Element> {
        guard let (head, tail) = key.decomposite else { return Trie(isElement: true, children: children) }
        
        var newChildren = children
        if var newTrie = children[head] {
            newChildren[head] = newTrie.insert(tail)
        } else {
            newChildren[head] = Trie(tail)
        }
        
        return Trie(isElement: false, children: newChildren)
        
    }
}



//func buildStringTie(words: [String]) -> Trie<Character> {
//    let emptyTrie = Trie<Character>()
//    
//    return words.reduce(emptyTrie) { trie, word in
//        trie.insert(Array(word.characters)) }
//}



func autocompleteTie(knownWords: Trie<Character>, word: String) -> [String] {
    let chars = Array(word.characters)
    let completed = knownWords.autocomplete(chars)
    
    return completed.map { chars in word + String(chars) }
}

