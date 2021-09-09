//
//  ContentView.swift
//  BlockNote
//
//  Created by Kovs on 06.09.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(key: "noteID", ascending: true)]) var notes: FetchedResults<Note>
    
    @State private var noteName: String = ""

    var body: some View {
        VStack {
            
            TextField("Note name...", text: $noteName, onCommit: {
                addItem()
            })
            .padding()
            
            List {
                ForEach(notes, id: \.self) { note in
                    Text(note.name ?? "Unknown name")
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                #if os(iOS)
                EditButton()
                #endif
                
                Button(action: addItem) {
                    Label("Add new Note!", systemImage: "plus")
                }
            }
        }
        // end of the toolbar
    }

    private func addItem() {
        withAnimation {
            let newNote = Note(context: viewContext)
            newNote.name = self.noteName
            newNote.level = "N5"
            
            newNote.noteID = (notes.last?.noteID ?? 0) + 1 // makes the order by id of the note

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            self.noteName = ""
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { notes[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
