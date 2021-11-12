//
//  C1NoteView.swift
//  BlockNote
//
//  Created by Kovs on 12.11.2021.
//

import SwiftUI
import CoreData

struct C1NoteView: View {
    
    @ObservedObject var note: Note
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Text("Hello")
            }
        }
    }
}

struct C1NoteView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let note = Note(context: moc)
        note.noteIsMarked = true
        note.noteLevel = "N5"
        note.noteName = "Test name"
        
        return NavigationView {
            C1NoteView(note: note)
        }
    }
}
