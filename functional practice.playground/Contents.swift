//: Playground - noun: a place where people can play

import UIKit


typealias Distance = Double

//the Region type will refer to functions transforming a Position to a Bool
typealias Region = Position -> Bool

struct Position {
    var x: Double
    var y: Double
}


//check wether point is in circle
extension Position {
    func inRange(range: Distance) -> Bool {
        return sqrt(x*x + y*y) <= range
    }
    
}

// in case if ship has other position, than origin
struct Ship {
    var position: Position
    var firingRange: Distance
    var unsafeRange: Distance
}


//Test if another ship is on range
extension Ship {
    func canEngageShip(target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx*dx - dy*dy)
        return targetDistance <= firingRange
        
    }
}


//For avoiding targeting ships if they are too close to you
extension Ship {
    func canSafelyEngagePosition(target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx*dx - dy*dy)
        return targetDistance <= firingRange && targetDistance > unsafeRange
    }
}


//For avoiding tarheting ships if they are to close to each other
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

//to maintatin the complexity of code, make methods for static calculation
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

//MARK: Refactoring

//circules, centered around origin
func circle(radius: Distance) -> Region  {
    return { point in point.length <= radius }
}


//circules, shifting from center
func circle2(radius: Distance, center: Position) -> Region {
    return {point in point.minus(center).length <= radius }
}


func shift(region: Region, offset: Position) -> Region {
    return { point in region(point.minus(offset))}
}

//method for defining a new region by inventing a region
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

//refactored method
extension Ship {
    func canSafelyEngageShip(target: Ship, friendly: Ship) -> Bool {
        let rangeRegion = difference(circle(firingRange), minus: circle(unsafeRange))
        let firingRegion = shift(rangeRegion, offset: position)
        let friendlyRegion = shift(circle(unsafeRange), offset: friendly.position)
        let resultRegion = difference(firingRegion, minus: friendlyRegion)
        return resultRegion(target.position)
    }
}