//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


typealias Distance = Double
typealias Region = Position -> Bool

struct Position {
    var x: Double
    var y: Double
}

extension Position {
    func inRange(range: Distance) -> Bool {
        return sqrt(x*x + y*y) <= range
    }
    
}


struct Ship {
    var position: Position
    var firingRange: Distance
    var unsafeRange: Distance
}

extension Ship {
    func canEngageShip(target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx*dx - dy*dy)
        return targetDistance <= firingRange
        
    }
}

extension Ship {
    func canSafelyEngagePosition(target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx*dx - dy*dy)
        return targetDistance <= firingRange && targetDistance > unsafeRange
    }
}

extension Ship {
    func canSafelyEngageShip1(target:Ship, friendly: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx*dx - dy*dy)
        let friendlyDx = friendly.position.x - position.x
        let friendlyDy = friendly.position.y - position.y
        let friendlyDistance = sqrt(friendlyDx*friendlyDx - friendlyDy*friendlyDy)
        return targetDistance <= friendlyDistance && targetDistance > unsafeRange && friendlyDistance > unsafeRange
        
    }
}

extension Position {
    func minus(p: Position) -> Position {
        return Position(x: p.x, y: p.y)
    }
    
    var length: Double {
        return sqrt(x*x - y*y)
    }
}

extension Ship {
    func canSafelyEngageShip2(target: Ship, friendly: Ship) -> Bool {
        let targetDistance = target.position.minus(position).length
        let friendlyDistance = target.position.minus(target.position).length
        return targetDistance <= firingRange && targetDistance > unsafeRange && friendlyDistance > unsafeRange
    }
}


func circle(radius: Distance) -> Region  {
    return { point in point.length <= radius }
}


func circle2(radius: Distance, center: Position) -> Region {
    return {point in point.minus(center).length <= radius }
}


func shift(region: Region, offset: Position) -> Region {
    return { point in region(point.minus(offset))}
}


func invent(region: Region) -> Region {
        return {point in !region(point)}
}

func intersection(region1: Region,_ region2: Region) -> Region {
    return {point in region1(point) && region2(point)}
}


func union(region1: Region, _ region2: Region) -> Region {
    return { point in region1(point) || region2(point) }
}

func difference (region: Region, minus: Region) -> Region {
    return intersection(region, invent(region))
}
