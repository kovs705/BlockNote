//
//  EmptyView.swift
//  BlockNote
//
//  Created by Kovs on 26.11.2021.
//

import SwiftUI
import CoreData
// import SwiftUIKitView

// struct NotePage<NotePages: View>: View {
struct NotePage: View {
    
    // var notes: [NotePages]
    @ObservedObject var notes: Note
    
    var body: some View {
        
        // add Plus button to create Cell test with EmptyBlockTest!!!!!!!!!!!
        NotePageViewController(notesPages: [notes], notes: notes)
            
    }
}

struct EmptyView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let note = Note(context: moc)
        note.noteIsMarked = true
        note.noteLevel = "N5"
        note.noteName = "Test name"
        
        return NavigationView {
            NotePage(notes: note)
        }
    }
}
