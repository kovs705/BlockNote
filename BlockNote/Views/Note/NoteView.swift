//
//  NoteView.swift
//  BlockNote
//
//  Created by Kovs on 03.10.2021.
//

//
//  NoteView.swift
//  BlockNoteDebug
//
//  Created by Kovs on 04.12.2021.
//

import SwiftUI
import CoreData
import UIKit

struct NoteView: View {
    
    @ObservedObject var note: Note
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: - Gesture
    @GestureState var swipeToTheRight = false
//    var swipeGesture: some Gesture {
//        // UISwipeGestureRecognizer()
//    }
    
    var buttonBack: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .font(.system(size: 19))
                .foregroundColor(returnColorFromString(nameOfColor: note.typeOfNote?.groupColor ?? "GreenAvocado"))
        }
    }
    // "chevron.left.circle.fill"
    var buttonCreate: some View {
        Button(action: {
            createNoteItem()
        }) {
            Image(systemName: "plus")
                .font(.system(size: 19))
                .foregroundColor(returnColorFromString(nameOfColor: note.typeOfNote?.groupColor ?? "GreenAvocado"))
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(note.wrappedNoteName)
                    .bold()
                    .font(.title)
                    .padding(.horizontal)
                
                Divider()
                    .foregroundColor(Color.gray)
                    .padding(.horizontal)
                
                List {
                    ForEach(note.noteItemArray, id: \.self) { noteItem in
                        NoteItemObject(noteItem: noteItem)
                        
                        // UITextViewContainer(noteItem: noteItem)
                        //
                    }
                    
                }
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        // isInputActive = false
                        hideKeyboard()
                        print("Saved!")
                        try? viewContext.save()
                    }
                }
            }
            // VStack
        }
        
        // MARK: - Swipe to the right to close the view:
    
        // ScrollView
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: buttonBack)
        .navigationBarItems(trailing: buttonCreate)
    }
    
    func createNoteItem() {
        let newNoteItem = NoteItem(context: viewContext)
        newNoteItem.noteItemName = "New Note Item"
        newNoteItem.noteItemText = "Some text to show in preview of the NoteItem just for debugging bla bla bla"
        newNoteItem.noteItemOrder = (note.noteItemArray.last?.noteItemOrder ?? 0) + 1
        // newNoteItem.noteItemOrder = 1
        newNoteItem.noteItemType = "textBlock"
        
        
        self.note.addObject(value: newNoteItem, forKey: "noteItems")
        
        do {
            try self.viewContext.save()
            print("NoteItem is added!")
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct NoteView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let note = Note(context: moc)
        note.noteIsMarked = false
        note.noteName = "Preview Name"
        note.noteType = "Preview type"
        
        return NavigationView {
            NoteView(note: note)
        }
    }
}

