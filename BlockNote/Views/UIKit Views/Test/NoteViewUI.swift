//
//  NoteViewUI.swift
//  BlockNote
//
//  Created by Kovs on 28.11.2021.
//

import SwiftUI
import UIKit
import CoreData

class HostingCell: UITableViewCell { // just to hold hosting controller
    var host: UIHostingController<AnyView>?
}

struct NoteList: UIViewRepresentable {
    
    @ObservedObject var notes: Note
    
    // var blocks: [String]
    
    func makeUIView(context: Context) -> UITableView {
        let collectionView = UITableView(frame: .zero, style: .plain)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = context.coordinator
        collectionView.delegate = context.coordinator
        collectionView.register(HostingCell.self, forCellReuseIdentifier: "Cell")
        return collectionView
    }
    
    func updateUIView(_ uiView: UITableView, context: Context) {
        // nothing
    }
    
    func makeCoordinator() -> Coordinator {
        // Coordinator(blocks: blocks, notes: notes)
        Coordinator(notes: notes)
    }
    
    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
        // var blocks: [String]
        var notes: Note
        
//        init(blocks: [String], notes: Note) {
//            self.blocks = blocks
//            self.notes = notes
//        }
        init(notes: Note) {
            self.notes = notes
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // self.blocks.count
            self.notes.accessibilityElementCount()
        }
        
        // MARK: - Work on cells and add a SwiftUI view
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HostingCell
            
            // MARK: - here
            // let view = Text(blocks[indexPath.row]).frame(height: 50)
            
            // SwiftUI test view (just the text):
            // for note in notes {
            let viewTest = CellNoteView(notes: notes)
            // }
            
            
            if tableViewCell.host == nil {
                // let controller = UIHostingController(rootView: AnyView(view))
                let controller = UIHostingController(rootView: AnyView(viewTest))
                tableViewCell.host = controller
                
                let tableCellViewContent = controller.view!
                
                tableCellViewContent.translatesAutoresizingMaskIntoConstraints = false
                tableViewCell.contentView.addSubview(tableCellViewContent)
                
                tableCellViewContent.topAnchor.constraint(equalTo: tableViewCell.contentView.topAnchor).isActive            = true
                tableCellViewContent.leftAnchor.constraint(equalTo: tableViewCell.contentView.leftAnchor).isActive          = true
                tableCellViewContent.rightAnchor.constraint(equalTo: tableViewCell.contentView.rightAnchor).isActive        = true
                tableCellViewContent.bottomAnchor.constraint(equalTo: tableViewCell.contentView.bottomAnchor).isActive      = true
            } else {
                // other cell, show anything another but SwiftUI too:
                // tableViewCell.host?.rootView = AnyView(view)
                tableViewCell.host?.rootView = AnyView(viewTest)
            }
            tableViewCell.setNeedsLayout()
            return tableViewCell
        }
        
    }
    // end of Coordinator

}
