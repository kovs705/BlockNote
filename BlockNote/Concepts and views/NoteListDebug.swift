//
//  NoteListDebug.swift
//  BlockNote
//
//  Created by Kovs on 06.10.2021.
//

import SwiftUI

struct NoteListDebug: View {
    
    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(key: "noteID", ascending: true)]) var notes: FetchedResults<Note>
    
    var body: some View {
        VStack {
            List {
                ForEach(notes, id: \.self) { note in
                    HStack {
                        Text(note.wrappedName)
                    }
                }
            }
        }
    }
}
