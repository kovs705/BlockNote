//
//  NoteView.swift
//  BlockNote
//
//  Created by Kovs on 03.10.2021.
//

import SwiftUI
import CoreData

struct NoteView: View {
    
    @ObservedObject var note: Note
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text("Note name: ")
                    .bold()
                Text(note.wrappedNoteName)
            }
            
            HStack {
                Text("Note ID: ")
                    .bold()
                Text("\(note.noteID)")
            }
            
            HStack {
                Text("Note level: ")
                    .bold()
                Text(note.noteLevel ?? "Nothing on level")
            }
            
            HStack {
                Text("Note type: ")
                    .bold()
                Text(note.wrappedNoteType)
            }
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let note = Note(context: moc)
        note.noteIsMarked = true
        note.noteLevel = "N5"
        note.noteName = "Test name"
        
        return NavigationView {
            NoteView(note: note)
        }
    }
}