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

struct NoteView: View {
    
    @ObservedObject var note: Note
    
    var body: some View {
        ScrollView {
            VStack {
                Text(note.wrappedNoteName)
                    .bold()
                    .font(.title)
                Divider()
                    .padding(10)
                
                ForEach(note.noteItemArray, id: \.self) { noteItem in
                    Text(noteItem.wrappedNoteItemName)
                }
                
            }
            // VStack
        }
        // ScrollView
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
