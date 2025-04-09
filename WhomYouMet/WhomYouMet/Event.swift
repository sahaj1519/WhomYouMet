//
//  Event.swift
//  WhomYouMet
//
//  Created by Ajay Sangwan on 09/04/25.
//
import SwiftData
import Foundation

@Model
class Event {
    var name: String = ""
    var location: String = ""
    var people: [Person]? = [Person]()
    
    init(name: String, location: String, people: [Person] = [Person]()) {
        self.name = name
        self.location = location
        self.people = people
    }
}
