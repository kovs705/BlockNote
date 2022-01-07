//
//  C1NoteView.swift
//  BlockNote
//
//  Created by Kovs on 12.11.2021.
//

import SwiftUI
import CoreData
import SwiftUIKitView

struct C1NoteView: View {
    
    @ObservedObject var note: Note
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var pickedObjectType = ["Text", "Code"]
    
    
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
        LazyVStack {
            ForEach(note.noteItemArray, id: \.self) { noteItem in
                NoteItemObject(noteItem: noteItem)
            }
            
        }
    }
    
    
    
    func createNoteItem() {
        let newNoteItem = NoteItem(context: viewContext)
        newNoteItem.noteItemName = "New Note Item"
        newNoteItem.noteItemText = "Some text to show in preview of the NoteItem just for debugging bla bla bla"
        newNoteItem.noteItemOrder = (note.noteItemArray.last?.noteItemOrder ?? 0) + 1
        // newNoteItem.noteItemOrder = 1
        newNoteItem.noteItemType = "Text"
        
        
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
