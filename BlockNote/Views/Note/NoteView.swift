//
//  NoteView.swift
//  BlockNote
//
//  Created by Kovs on 03.10.2021.
//

import SwiftUI
import CoreData
import SwiftUIX


struct NoteView: View {
    
    // @ObservedObject var note: Note
    // @State private var text = ""
    
    var body: some View {
        NavigationView {
            CocoaScrollView(.vertical) {
                Text("Hello")
            }
            .frame(height: 300)
            
        }
    }
}

//        ScrollView(.vertical) {
//            // MARK: - Title and Divider
//            VStack(alignment: .leading) {
//                Text(note.wrappedNoteName)
//                    .font(.title)
//                    .bold()
//                    .padding(.horizontal)
//                Divider()
//                    .padding(10)
//
//            }
//
//        }
        
//        ZStack {
//            Text("ae")
//        }
//        .background(Color.greenAvocado)
//            .frame(height: 50)
//        ScrollView {
//            Text("HEllo")
//        }
//        .frame(height: 400)
//
//        ScrollView {
//            VStack(alignment: .center) {
//                HStack {
//                    Text("Note name: ")
//                        .bold()
//                    Text(note.wrappedNoteName)
//                }
//
//                HStack {
//                    Text("Note ID: ")
//                        .bold()
//                    Text("\(note.noteID)")
//                }
//
//                HStack {
//                    Text("Note level: ")
//                        .bold()
//                    Text(note.noteLevel ?? "Nothing on level")
//                }
//
//                HStack {
//                    Text("Note type: ")
//                        .bold()
//                    Text(note.wrappedNoteType)
//                }
//            }
//        }
//        .background(Color.rosePink)
//        .frame(height: 300)
        
    // }
// }

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
