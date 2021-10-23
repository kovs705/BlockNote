//
//  NoteListDebug.swift
//  BlockNote
//
//  Created by Kovs on 06.10.2021.
//

import SwiftUI

struct NoteListDebug: View {
    @FetchRequest(entity: GroupType.entity(), sortDescriptors: [NSSortDescriptor(key: "number", ascending: true)]) var types: FetchedResults<GroupType>
    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(key: "noteID", ascending: true)]) var notes: FetchedResults<Note>
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            List {
                ForEach(types, id: \.self) { type in
                    
                    Section(header: Text("\(type.wrappedGroupName)")) {
                        
                        ForEach(notes, id: \.self) { note in
                            
                            NavigationLink(destination: NoteView(note: note)) {
                                HStack {
                                    Text("\(note.wrappedNoteName)")
                                }
                                // body
                            }
                            // NavigationLink
                        }
                        // note ForEach
                    }
                    // section ForEach
                    
                }
                .onDelete(perform: deleteItems)
                // type ForEach
            }
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { types[$0] }.forEach(viewContext.delete) // cascade deleting?

            do {
                try self.viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
