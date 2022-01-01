//
//  NoteItemObject.swift
//  BlockNote
//
//  Created by Kovs on 04.12.2021.
//

import SwiftUI
import CoreData
import CodeEditor

//  case textBlock
//  case codeBlock

//  case vocabularyBlock
//  case countDownBlock
//  case emptyBlockTest
//  case NavLink to the next View with tasks, its own color/theme etc

struct NoteItemObject: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var noteItem: NoteItem
    @State var textString = ""
    @FocusState var isInputActive: Bool
    
    var body: some View {
        if noteItem.noteItemType == "textBlock" {
            TextBlockObject(noteItem: noteItem) // 'Usual' block for the text
        } else if noteItem.noteItemType == "codeBlock" {
            CodeBlockObject(noteItem: noteItem)
        } else {
            Text(noteItem.wrappedNoteItemName)
        }
        
    }
    
    struct TextBlockObject: View {
        @ObservedObject var noteItem: NoteItem
        
        var body: some View {
            ZStack {
                TextEditor(text: $noteItem.noteItemText) // can be buggy
                // .focused($isInputActive)
                    .padding(5)
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .cornerRadius(15)
                    .font(.system(size: 17))
            }
            .cornerRadius(10)
            .background(Color.darkBack)
        }
    }
    
    struct CodeBlockObject: View {
        @ObservedObject var noteItem: NoteItem
        
        var body: some View {
            CodeEditor(source: $noteItem.noteItemText)
                .padding(5)
                .frame(width: UIScreen.main.bounds.width - 30)
                .cornerRadius(15)
                .font(.system(size: 17))
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
