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
            Text(note.wrappedNoteName)
            Text("\(note.noteID)")
            Text(note.noteLevel ?? "Nothing on level")
            Text(note.wrappedNoteType)
            VStack {
                Text(note.typeOfNote?.groupName ?? "Unknown name of the group")
            }
            .padding(.vertical)
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
