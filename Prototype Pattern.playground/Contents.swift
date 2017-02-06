//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


////Implementing prototype pattern using struc

struct Appointment {
    var name: String
    var day: String
    var place: String
    
    func printDetails(label: String) {
        
        print ("\(label) with \(name) on \(day) at \(place)")
        
    }
}

var beerMeeting = Appointment(name: "Bob", day: "Mon", place: "Pita's bar")
var vodkaMeeting = beerMeeting

beerMeeting.printDetails("Max")
vodkaMeeting.printDetails("Miron")

vodkaMeeting.name = "Maty"
vodkaMeeting.day = "Sun"


//Implementing cloning reference types (won't work as struct)
//We need to inherent class from NSObject and NSCopying for redeclaration of an objects
class AppointmentC: NSObject, NSCopying {
    var name: String
    var day: String
    var place: String
    
    
    init(name: String, day: String, place: String) {
        self.name = name
        self.day = day
        self.place = place
    }
    
    func printDetails(label: String)  {
        print ("\(label) with \(name) on \(day) at \(place)")
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return AppointmentC(name: self.name, day: self.day, place: self.place)
    }
}

var colaMeeting = AppointmentC(name: "Mark", day: "Tue", place: "Papa's place")
var makMeeting = colaMeeting.copy() as! AppointmentC

makMeeting.day = "Thursday"
makMeeting.name = "Dan"

makMeeting.printDetails("First")
colaMeeting.printDetails("Second")

//Shallow Copying
//In following example references to objects are coppied, but not the object themself. Two AppointmentC1 objects refers to the Lo

class Location {
    var name: String
    var address: String
    
    init(name: String, address: String) {
        self.name = name
        self.address = address
    }
}


class AppointmentC1: NSObject, NSCopying {
    var name: String
    var day: String
    var place: Location
    
    
    init(name: String, day: String, place: Location) {
        self.name = name
        self.day = day
        self.place = place
    }
    
    func printDetails(label: String)  {
        print ("\(label) with \(name) on \(day) at \(place.address)")
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return AppointmentC1(name: self.name, day: self.day, place: self.place)
    }
}

var spriteMeeting = AppointmentC1(name: "Leo", day: "Friday", place: Location(name: "Magadan", address: "Rubtchovksaia nabereznai"))
var milkMeeting = spriteMeeting.copy() as! AppointmentC1

milkMeeting.name = "Denis"
milkMeeting.day = "Monday"
milkMeeting.place.address = "Ivanovkaia,4"
milkMeeting.place.name = "Bomba"

spriteMeeting.printDetails("Second")
milkMeeting.printDetails("Second")

// Deep Copying 


class LocationC1: NSObject, NSCopying {
    var name: String
    var address: String
    
    init(name: String, address: String) {
        self.name = name
        self.address = address
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return Location(name: self.name, address: self.address)
    }
}

class AppointmentC2: NSObject, NSCopying {
    var name: String
    var day: String
    var place: LocationC1
    
    
    init(name: String, day: String, place: LocationC1) {
        self.name = name
        self.day = day
        self.place = place
    }
    
    func printDetails(label: String)  {
        print ("\(label) with \(name) on \(day) at \(place.address)")
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return AppointmentC2(name: self.name, day: self.day, place: self.place.copy() as! LocationC1)
    }
}

var mangoMeeting = AppointmentC2(name: "Leo", day: "Friday", place: LocationC1(name: "Magadan", address: "Rubtchovksaia nabereznai"))
//var appleMeeting = mangoMeeting.copy() as! AppointmentC2


//appleMeeting.name = "Denis"
//appleMeeting.day = "Monday"
//appleMeeting.place.address = "Ivanovkaia,4"
//appleMeeting.place.name = "Bomba"
//
//mangoMeeting.printDetails("Third")
//appleMeeting.printDetails("Fourth")


//Copying Arrays

class Person: NSObject, NSCopying {
    
    var name: String
    var country: String
    
    init(name: String, country: String) {
        self.name = name
        self.country = country
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return Person(name: self.name, country: self.country)
    }
}


var people = [Person(name: "Joe", country: "France"), Person(name: "Bob", country: "USA")]
var otherpeople = people

people[0].country = "UK"
print("Country: \(otherpeople[0].country)")


//Separating Object Creation from Object Use

class Message {
    var to: String
    var subject: String
    
    init(to: String, subject: String) {
        self.to = to
        self.subject = subject
    }
}

class MessageLogger {
    var messages: [Message] = []
    
    func logMessage(msg: Message) {
        messages.append(Message(to: msg.to, subject: msg.subject))
    }
    
    func processMessages(callBack: Message -> Void) {
        for msg in messages {
            callBack(msg)
        }
    }
}

class DetailedMessage: Message {
    
    var from: String
    
    init(to: String, subject: String, from: String) {
        self.from = from
        super.init(to: to, subject: subject)
    }
    
}


var logger = MessageLogger()

var message = Message(to: "Kris", subject: "Hello")
logger.logMessage(message)

message.to = "Bob"
message.subject = "Are you free for diner?"
logger.logMessage(DetailedMessage(to: "Alice", subject: "Hallo!", from: "John"))


logger.processMessages({msg -> Void in
    if let detailed = msg as? DetailedMessage {
        print("Detailed Message - To: \(detailed.to) From: \(detailed.from)"
            + " Subject: \(detailed.subject)")
    } else {
        print("Message - To: \(msg.to) Subject: \(msg.subject)")
    }
})


//Applying Prototype Pattern to Messages


class MessageC1: NSObject, NSCopying {
    var to: String
    var subject: String
    
    init(to: String, subject: String) {
        self.to = to
        self.subject = subject
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return Message(to: self.to, subject: self.subject)
    }
}

class MessageLoggerC1 {
    var messages: [MessageC1] = []
    
    func logMessage(msg: MessageC1) {
        messages.append(msg.copy() as! MessageC1)
    }
    
    func processMessages(callBack: MessageC1 -> Void) {
        for msg in messages {
            callBack(msg)
        }
    }
}

class DetailedMessageC1: MessageC1 {
    var from: String
    
    init(to: String, subject: String, from: String) {
        self.from = from
        super.init(to: to, subject: subject)
    }
    
    override func copyWithZone(zone: NSZone) -> AnyObject {
        return DetailedMessage(to: self.to, subject: self.subject, from: self.from)
    }
    
}

var loggerC1 = MessageLoggerC1()

var messageC1 = MessageC1(to: "Kris", subject: "Hello")
loggerC1.logMessage(messageC1)

messageC1.to = "Bob"
messageC1.subject = "Are you free for diner?"
loggerC1.logMessage(DetailedMessageC1(to: "Alice", subject: "Hallo!", from: "John"))


loggerC1.processMessages({msg -> Void in
    if let detailed = msg as? DetailedMessageC1 {
        print("Detailed Message - To: \(detailed.to) From: \(detailed.from)"
            + " Subject: \(detailed.subject)")
    } else {
        print("Message - To: \(msg.to) Subject: \(msg.subject)")
    }
})

