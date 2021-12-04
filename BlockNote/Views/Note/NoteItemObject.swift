//
//  NoteItemObject.swift
//  BlockNote
//
//  Created by Kovs on 04.12.2021.
//

import SwiftUI
import CoreData

//  case textBlock
//  case vocabularyBlock
//  case countDownBlock
//  case emptyBlockTest

struct NoteItemObject: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var noteItem: NoteItem
    
    var body: some View {
        if noteItem.type == .textBlock {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.darkBack)
                TextEditor(text: $noteItem.noteItemText) // can be buggy
                    .onSubmit {
                        try? viewContext.save()
                    }
            }
        }
        
    }
}

struct NoteItemObject_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let newNoteItem = NoteItem(context: moc)
        newNoteItem.noteItemName = "Preview note name"
        newNoteItem.noteItemText = "Some text to show in preview of the NoteItem just for debugging bla bla bla"
        newNoteItem.noteItemOrder = 1
        newNoteItem.type = .textBlock
        
        return NavigationView {
            NoteItemObject(noteItem: newNoteItem)
        }
    }
}
