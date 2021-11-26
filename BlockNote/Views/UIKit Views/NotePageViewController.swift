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
    
    var notes: [NotePages]
    typealias UIViewControllerType = UITableViewController
    
    // MARK: - Make
    func makeUIViewController(context: Context) -> UITableViewController {
        let table = UITableViewController()
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
    
    
    
    
    
    
}

//struct NotePageViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        NotePageViewController()
//    }
//}
