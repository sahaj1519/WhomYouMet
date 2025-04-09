//
//  PeopleView.swift
//  WhomYouMet
//
//  Created by Ajay Sangwan on 09/04/25.
//
import SwiftData
import SwiftUI

struct PeopleView: View {
    @Environment(\.modelContext) var modelContext
    @Query var people: [Person]
    
    func deletePeople(offset: IndexSet) {
        for index in offset {
            let person = people[index]
            modelContext.delete(person)
        }
    }
    
    init(searchString: String = "", sortOrder: [SortDescriptor<Person>] = []) {
        _people = Query(filter: #Predicate { person in
            if searchString.isEmpty {
                true
            } else {
                person.name.localizedStandardContains(searchString)
                || person.emailAddress.localizedStandardContains(searchString)
                || person.details.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }
    
    var body: some View {
        List{
            ForEach(people) { person in
                NavigationLink(value: person) {
                    Text(person.name)
                }
            }
            .onDelete(perform: deletePeople)
        }
    }
}

#Preview {
    do {
        let preview = try Previewer()
        return PeopleView()
            .modelContainer(preview.container)
    } catch {
        return Text("failed to create preview \(error.localizedDescription)")
    }

}
