//
//  EditEventView.swift
//  WhomYouMet
//
//  Created by Ajay Sangwan on 09/04/25.
//

import SwiftUI

struct EditEventView: View {
    @Bindable var event: Event
    
    var body: some View {
        Form {
            TextField("Name of event", text: $event.name)
            TextField("Location", text: $event.location)
        }
        .navigationTitle("Edit Event")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let preview = try Previewer()
        return EditEventView(event: preview.event)
            .modelContainer(preview.container)
    } catch {
        return Text("failed to create preview \(error.localizedDescription)")
    }
}
