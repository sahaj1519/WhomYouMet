//
//  EditPersonView.swift
//  WhomYouMet
//
//  Created by Ajay Sangwan on 09/04/25.
//
import PhotosUI
import SwiftData
import SwiftUI

struct EditPersonView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var person: Person
    @Binding var navigationPath: NavigationPath
    
    @State private var selectedPhoto: PhotosPickerItem?
    
    @Query(sort: [
        SortDescriptor(\Event.name),
        SortDescriptor(\Event.location)
    ]) var events: [Event]
    
    func addEvent() {
        let event = Event(name: "", location: "")
        modelContext.insert(event)
        navigationPath.append(event)
        
    }
    
    func loadPhoto() {
        Task { @MainActor in
            person.photo = try await selectedPhoto?.loadTransferable(type: Data.self)
        }
    }
    
    var body: some View {
        Form {
            Section {
                if let imageData = person.photo, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
                PhotosPicker(selection: $selectedPhoto, matching: .images) {
                    Label("Select a photo", systemImage: "person")
                }
            }
            Section {
                TextField("Name", text: $person.name)
                    .textContentType(.name)
                
                TextField("Email Address", text: $person.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            Section("Where did you meet them?") {
                Picker("Met at", selection: $person.metAt) {
                    Text("Unknown Event")
                        .tag(Optional<Event>.none)
                    
                    if events.isEmpty == false {
                        Divider()
                        
                        ForEach(events) { event in
                            Text(event.name)
                                .tag(Optional(event))
                        }
                    }
                }
                
                Button("Add a new event", action: addEvent)
            }
            
            Section("Notes") {
                TextField("Details about this person", text: $person.details, axis: .vertical)
                    
            }
        }
        .navigationTitle("Edit person")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Event.self) { event in
            EditEventView(event: event)
        }
        .onChange(of: selectedPhoto, loadPhoto)
    }
}

#Preview {
    do {
        let preview = try Previewer()
        return EditPersonView(person: preview.person, navigationPath: .constant(NavigationPath()))
            .modelContainer(preview.container)
    } catch {
        return Text("failed to create preview \(error.localizedDescription)")
    }

}
