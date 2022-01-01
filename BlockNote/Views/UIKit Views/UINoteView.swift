//
//  NoteView.swift
//  BlockNote
//
//  Created by Kovs on 29.12.2021.
//

import Foundation
import UIKit
import SwiftUI
import CoreData

struct NoteList<Note, NoteItem, Row: View>: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator(notes, content)
    }
    
    // MARK: - Make/Update
    func updateUIView(_ uiView: UITableView, context: Context) {
        // context.coordinator.data = notes
        uiView.reloadData()
    }
    
    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView()
        tableView.allowsMultipleSelection = true
        tableView.allowsSelectionDuringEditing = true
        tableView.separatorStyle = .none
        return tableView
    }
    
    // MARK: - Properties
    private let content: (NoteItem) -> Row
    private let notes: [NoteItem]
    
    // MARK: - init
    init(_ notes: [NoteItem], _ content: @escaping (NoteItem) -> Row) {
        self.notes = notes
        self.content = content
    }
    
    // MARK: - Coordinator
    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
        private let content: (NoteItem) -> Row
        private let notes: [NoteItem]
        
        init(_ notes: [NoteItem], _ content: @escaping (NoteItem) -> Row) {
            self.notes = notes
            self.content = content
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            notes.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            UITableViewCell()
        }
        
    }
    
    
    
}
