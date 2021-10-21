//
//  NoteListDebug.swift
//  BlockNote
//
//  Created by Kovs on 06.10.2021.
//

import SwiftUI

struct NoteListDebug: View {
    
    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(key: "noteID", ascending: true)]) var notes: FetchedResults<Note>
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            List {
                ForEach(notes, id: \.self) { note in
                    HStack {
                        Text("\(note.wrappedNoteName)")
                    }
                }
                .onDelete(perform: deleteItems)
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
