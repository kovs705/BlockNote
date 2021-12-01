//
//  NotePageViewController.swift
//  BlockNote
//
//  Created by Kovs on 26.11.2021.
//

import SwiftUI
import UIKit
import CoreData

struct NotePageViewController<NotePages: Note>: UIViewControllerRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, notes: notes)
    }
    
    var notesPages: [NotePages]
    @ObservedObject var notes: Note
    
    typealias UIViewControllerType = UITableViewController
    
    // MARK: - Make
    func makeUIViewController(context: Context) -> UITableViewController {
        let table = UITableViewController(style: .plain)
        table.title = "TEST"
        table.tableView.dataSource = context.coordinator
        return table
    }
    
    // MARK: - Update
    func updateUIViewController(_ uiViewController: UITableViewController, context: Context) {
        // some code
    }
    
    // MARK: - Coordinator
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
    
    class Coordinator: NSObject, UITableViewDataSource {
        var parent: NotePageViewController
        var notes: Note
        
        init(_ tableViewController: NotePageViewController, notes: Note) {
            parent = tableViewController
            self.notes = notes
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if self.notes.noteItemArray.count == 0 {
                print("Nothing to count!")
            }
            let count = self.notes.noteItemArray.count
            
            return count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "CellTest", for: indexPath) as! HostingCell
            
            // SwiftUI text to check how everything works:
            let textTest = Text("TEST TO CHECK HOW EVERYTHING WORKS").frame(height: 50)
            if tableViewCell.host == nil {
                print("Nothing on cells to show!")
                
                let controller = UIHostingController(rootView: AnyView(textTest))
                tableViewCell.host = controller
                
                let tableCellViewContent = controller.view!
                
                tableCellViewContent.translatesAutoresizingMaskIntoConstraints = false
                tableViewCell.contentView.addSubview(tableCellViewContent)
                
                tableCellViewContent.topAnchor.constraint(equalTo: tableViewCell.contentView.topAnchor).isActive            = true
                tableCellViewContent.leftAnchor.constraint(equalTo: tableViewCell.contentView.leftAnchor).isActive          = true
                tableCellViewContent.rightAnchor.constraint(equalTo: tableViewCell.contentView.rightAnchor).isActive        = true
                tableCellViewContent.bottomAnchor.constraint(equalTo: tableViewCell.contentView.bottomAnchor).isActive      = true
            } else {
                tableViewCell.host?.rootView = AnyView(buttonTest())
            }
            tableViewCell.setNeedsLayout()
            return tableViewCell
            
        }
        
    }
    
}
