//
//  CellNoteView.swift
//  BlockNote
//
//  Created by Kovs on 29.11.2021.
//

import SwiftUI
import CoreData

///
/// this file should contain types of showing blocks, like textBlock, listBlock, vocabularyBlock e.t.c.
/// I also need to upgrade it by time and add new balues in CD like Date, links and other things
///
///
///


struct EmptyBlockTest: View {
    
    @ObservedObject var notes: Note
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray)
                .frame(width: UIScreen.main.bounds.width - 40, height: 80)
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: 80)
    }
}


struct CellNoteView: View {
    
    @ObservedObject var notes: Note
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CellNoteView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let note = Note(context: moc)
        note.noteIsMarked = true
        note.noteLevel = "N5"
        note.noteName = "Test name"
        
        return NavigationView {
            CellNoteView(notes: note)
        }
    }
}
