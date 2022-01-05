//
//  NoteItemObject.swift
//  BlockNote
//
//  Created by Kovs on 04.12.2021.
//

import SwiftUI
import CoreData
import CodeEditor

//  case Test
//  case Code

//  case TaskBlock          -------- in progress

//  case vocabularyBlock
//  case countDownBlock
//  case emptyBlockTest
//  case NavLink to the next View with tasks, its own color/theme etc

struct NoteItemObject: View {
    
    #warning("Work in Figma")
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var noteItem: NoteItem
    @State var textString = ""
    @FocusState var isInputActive: Bool
    
    @State private var height: CGFloat = .zero
    // @State private var noteItemText: String
    
    var body: some View {
        // MARK: - TextBlock
        if noteItem.noteItemType == "Text" {
            ZStack {
                #warning("Working on TextBlockObject!!!")
                Text(self.$noteItem.noteItemText.wrappedValue)
                
                TextEditor(text: $noteItem.noteItemText) // can be buggy
                // .focused($isInputActive)
                    .padding(5)
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .cornerRadius(15)
                    .font(.system(size: 17))
                
                    .frame(minHeight: height)
            }
            .onPreferenceChange(ViewHeightKey.self) { height = $0 }
            // .frame(height: $noteItem.noteItemText * 20))
            
            .cornerRadius(10)
            .background(Color.darkBack)
        // MARK: - CodeBlock
        } else if noteItem.noteItemType == "Code" {
            CodeEditor(source: $noteItem.noteItemText)
                .padding(5)
                .frame(width: UIScreen.main.bounds.width - 30)
                .cornerRadius(15)
                .font(.system(size: 17))
        // MARK: - TaskBlock
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
        newNoteItem.noteItemType = "Text"

        
        return NavigationView {
            NoteItemObject(noteItem: newNoteItem)
        }
    }
}
