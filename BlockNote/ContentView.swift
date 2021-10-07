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
        NavigationView {
            VStack {
                
                TextField("Note name...", text: $noteName, onCommit: {
                    addItem()
                })
                .padding()
                .frame(width: UIScreen.main.bounds.width - 80, height: 55)
                .contentShape(Rectangle())
                .background(Color.white)
                .font(.system(size: 18))
                .cornerRadius(20)
                
                .lineLimit(1)
                
                List {
                    ForEach(notes, id: \.self) { note in
                        Text(note.name ?? "Unknown name")
                    }
                    .onDelete(perform: deleteItems)
                }
            }
        }
        // end of NavigationView
    }

    private func addItem() {
        withAnimation {
            let newNote = Note(context: viewContext)
            newNote.name = self.noteName
            newNote.level = "N5"
            
            newNote.noteID = (notes.last?.noteID ?? 0) + 1 // makes the order by id of the note

            do {
                try self.viewContext.save()
                noteName = ""
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { notes[$0] }.forEach(viewContext.delete)

            do {
                try self.viewContext.save()
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
