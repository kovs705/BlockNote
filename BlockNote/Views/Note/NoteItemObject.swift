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
    @State var textString = ""
    @FocusState var isInputActive: Bool
    
    var body: some View {
        if noteItem.noteItemType == "textBlock" {
            TextEditor(text: $noteItem.noteItemText) // can be buggy
                // .focused($isInputActive)
                .padding()
                .frame(width: UIScreen.main.bounds.width - 30)
                .cornerRadius(15)
        } else {
            Text(noteItem.wrappedNoteItemName)
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
        newNoteItem.noteItemType = "textBlock"

        
        return NavigationView {
            NoteItemObject(noteItem: newNoteItem)
        }
    }
}
