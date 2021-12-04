//
//  NoteItemObject.swift
//  BlockNote
//
//  Created by Kovs on 04.12.2021.
//

import SwiftUI
import CoreData

struct NoteItemObject: View {
    
    @ObservedObject var noteItem: NoteItem
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct NoteItemObject_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let newNoteItem = NoteItem(context: moc)
        newNoteItem.noteItemName = "Preview note name"
        newNoteItem.noteItemText = "Some text to show in preview of the NoteItem just for debugging bla bla bla"
        newNoteItem.noteItemOrder = 1
        
        return NavigationView {
            NoteItemObject(noteItem: newNoteItem)
        }
    }
}
