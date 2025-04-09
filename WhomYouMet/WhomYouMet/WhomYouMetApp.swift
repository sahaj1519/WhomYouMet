//
//  WhomYouMetApp.swift
//  WhomYouMet
//
//  Created by Ajay Sangwan on 09/04/25.
//
import SwiftData
import SwiftUI

@main
struct WhomYouMetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Person.self)
        }
    }
}
