//
//  ContentView.swift
//  WhomYouMet
//
//  Created by Ajay Sangwan on 09/04/25.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()
   
    
    @State private var searchText = ""
    @State private var sortOrder = [SortDescriptor(\Person.name)]
    
    func addPerson() {
        let person = Person(name: "", emailAddress: "", details: "")
        modelContext.insert(person)
        path.append(person)
    }
    
    
    var body: some View {
        NavigationStack(path: $path) {
           PeopleView(searchString: searchText, sortOrder: sortOrder)
            .navigationTitle("WhomYouMet")
            .navigationDestination(for: Person.self) { person in
                EditPersonView(person: person, navigationPath: $path)
            }
            .toolbar {
                ToolbarItem {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort By", selection: $sortOrder) {
                            Text("Name (A-Z)")
                                .tag([SortDescriptor(\Person.name)])
                            Text("Name (Z-A)")
                                .tag([SortDescriptor(\Person.name, order: .reverse)])
                        }
                    }
                }
                ToolbarItem {
                    Button("Add Person", systemImage: "plus", action: addPerson)
                }
            }
            .searchable(text: $searchText, prompt: "search")
        }
    }
}

#Preview {
    do {
        let preview = try Previewer()
        return ContentView()
            .modelContainer(preview.container)
    } catch {
        return Text("failed to create preview \(error.localizedDescription)")
    }
     
}
