//
//  ItemListObject.swift
//  BlockNote
//
//  Created by Kovs on 09.11.2021.
//

import SwiftUI
import CoreData

/// switch to choose the look of the element depended on its type
/// add more attributes into NoteItem entity
/// work on reordering note items right in NoteView (future)
/// 
///
/// --------------------------------

struct ItemListObjectView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct ItemListObject_Previews: PreviewProvider {
    static var previews: some View {
        ItemListObjectView()
    }
}

// MARK: -
struct ItemListObjectText: View {
    @ObservedObject var note: Note
    @Binding var itemText: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.itemListBackground)
            TextEditor(text: $itemText)
            
            
        }
        
    }
    
}

