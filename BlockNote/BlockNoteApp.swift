//
//  BlockNoteApp.swift
//  BlockNote
//
//  Created by Kovs on 06.09.2021.
//

import SwiftUI

@main
struct BlockNoteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
