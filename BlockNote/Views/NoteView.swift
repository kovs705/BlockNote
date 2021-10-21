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
            Text(note.wrappedName)
            Text("\(note.noteID)")
            Text(note.level ?? "Nothing on level")
            Text(note.wrappedType)
            VStack {
                Text(note.typeOfNote?.name ?? "Unknown name of the group")
            }
            .padding(.vertical)
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let note = Note(context: moc)
        note.isMarked = true
        note.level = "N5"
        note.name = "Test name"
        
        return NavigationView {
            NoteView(note: note)
        }
    }
}
