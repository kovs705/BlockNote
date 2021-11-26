//
//  NotePageViewController.swift
//  BlockNote
//
//  Created by Kovs on 26.11.2021.
//

import SwiftUI
import UIKit

struct NotePageViewController<NotePages: View>: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UITableViewController {
        let table = UITableViewController()
        return table
    }
    
    // MARK: -
    func updateUIViewController(_ uiViewController: UITableViewController, context: Context) {
        // some code
    }
    
    // MARK: - Coordinator
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
    
    var notes: [NotePages]
    
    typealias UIViewControllerType = UITableViewController
    
    
    
    
}

//struct NotePageViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        NotePageViewController()
//    }
//}
