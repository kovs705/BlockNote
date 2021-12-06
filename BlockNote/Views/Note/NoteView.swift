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

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct NoteView: View {
    
    @ObservedObject var note: Note
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    
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
                
                    ForEach(note.noteItemArray, id: \.self) { noteItem in
                        // NoteItemObject(noteItem: noteItem)
                        UITextViewContainer(noteItem: noteItem)
                        
                    }
                
            }
            // VStack
        }
        // ScrollView
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: buttonBack)
        .navigationBarItems(trailing: buttonCreate)
    }
    
    func createNoteItem() {
        let newNoteItem = NoteItem(context: viewContext)
        newNoteItem.noteItemName = "New Note Item"
        newNoteItem.noteItemText = "Some text to show in preview of the NoteItem just for debugging bla bla bla"
        // newNoteItem.noteItemOrder = (note.noteItemArray.last?.noteItemOrder ?? 0) + 1
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


//struct NoteView: View {
//
//    @ObservedObject var note: Note
//    // @ObservedObject var note = noteList()
//    @State private var text = ""
//
//    var body: some View {
//        VStack (alignment: .leading) {
//            HStack {
//                Text(note.wrappedNoteName)
//                    .font(.title)
//                    .bold()
//                    .padding(.horizontal)
//                Button(action: {
//                    if note.noteItemArray.isEmpty {
//                        print("NOTHING INSIDE")
//                    } else {
//                        print("It has noteItems inside, keep on working!")
//                    }
//                }) {
//                    Text("Check")
//                }
//            }
//            Divider()
//                .padding(10)
//
//            Text("Lorem ipsum dolor sit amet, vocent adipiscing ad qui. Ei eam munere electram, eum repudiare percipitur delicatissimi in. Impetus malorum laoreet ad vim, an vix semper consulatu necessitatibus. Vix virtute recteque ex, ius cu posse praesent imperdiet. Vide vidisse definitionem per cu, no eam congue veniam tantas. Vix eruditi intellegat eu, mea falli admodum tacimates eu. Pro senserit corrumpit eu. Et gubergren constituto pri, mel veniam labore dictas id. Vim sale incorrupte cu, duo in nominavi epicurei, ei iudico deseruisse mea.")
//
////            List {
////                ForEach(note.noteItemArray, id: \.self) { noteItem in
////                    if noteItem.type == .emptyBlockTest {
////                        Text("Nothing to show or the note doesn't have a typeeee)))")
////                    } else {
////                        Text("Nothing to show or the note doesn't have a type)))")
////                    }
////                }
////                .id(UUID())
////                .frame(width: UIScreen.main.bounds.width - 30, height: 500)
////                .listSectionSeparatorTint(Color.black)
////            }
//            List {
//                if note.noteItemArray.isEmpty {
//                    emptySection
//                } else {
//                    notesSection
//                }
//            }
//
//        }
//
//    }
//
//    var emptySection: some View {
//        Section {
//            Text("No files found")
//                .font(.system(size: 55))
//            Text("Text")
//        }
//    }
//    var notesSection: some View {
//        Section {
//            ForEach(note.noteItemArray) { item in
//                Text(item.noteItemName ?? "")
//            }
//        }
//    }
//
//}
//
//struct NoteView_Previews: PreviewProvider {
//
//    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//
//    static var previews: some View {
//        let note = Note(context: moc)
//        note.noteIsMarked = true
//        note.noteLevel = "N5"
//        note.noteName = "Test name"
//
//        return NavigationView {
//            NoteView(note: note)
//        }
//    }
//}
