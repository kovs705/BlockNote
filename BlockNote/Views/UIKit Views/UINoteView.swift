//
//  NoteView.swift
//  BlockNote
//
//  Created by Kovs on 29.12.2021.
//

import Foundation
import UIKit
import SwiftUI

struct NoteList<Note, NoteItem, Row: View>: UIViewRepresentable {
    func updateUIView(_ uiView: UITableView, context: Context) {
    }
    
    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView()
        tableView.allowsMultipleSelection = true
        tableView.allowsSelectionDuringEditing = true
        tableView.separatorStyle = .none
        return tableView
    }
    
    private let content: (NoteItem) -> Row
    private let notes: [Note]
    private let noteItems: [NoteItem]
    
    init(_ notes: [Note], _ content: @escaping (NoteItem) -> Row, _ noteItems: [NoteItem]) {
        self.notes = notes
        self.content = content
        self.noteItems = noteItems
    }
    
    
}
