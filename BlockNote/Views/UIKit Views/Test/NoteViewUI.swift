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
    
    var blocks: [String]
    
    func makeUIView(context: Context) -> UITableView {
        let collectionView = UITableView(frame: .zero, style: .plain)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = context.coordinator
        collectionView.delegate = context.coordinator
        
        return collectionView
    }
    
    func updateUIView(_ uiView: UITableView, context: Context) {
        // nothing
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(blocks: blocks)
    }
    
    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
        var blocks: [String]
        
        init(blocks: [String]) {
            self.blocks = blocks
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            self.blocks.count
        }
        
        // MARK: - Work on cells and add a SwiftUI view here
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            //let view = // PLACE a SwiftUI view here!!!
            let view = Text(blocks[indexPath.row]).frame(height: 50)
            let controller = UIHostingController(rootView: view)
            
            
            
            let tableCellViewContent = controller.view!
            
            tableCellViewContent.translatesAutoresizingMaskIntoConstraints = false
            tableViewCell.contentView.addSubview(tableCellViewContent)
            
            tableCellViewContent.topAnchor.constraint(equalTo: tableViewCell.contentView.topAnchor).isActive            = true
            tableCellViewContent.leftAnchor.constraint(equalTo: tableViewCell.contentView.leftAnchor).isActive          = true
            tableCellViewContent.rightAnchor.constraint(equalTo: tableViewCell.contentView.rightAnchor).isActive        = true
            tableCellViewContent.bottomAnchor.constraint(equalTo: tableViewCell.contentView.bottomAnchor).isActive      = true
            
            return tableViewCell
        }
    }
    
    
    
    
    
}
