//
//  C1NavigationView.swift
//  BlockNote
//
//  Created by Kovs on 13.09.2021.
//

import SwiftUI
import UIKit
import Combine

struct C1NavigationView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(key: "noteID", ascending: true)]) var notes: FetchedResults<Note>
    
    @State private var noteName: String = ""
    
    let hour = Calendar.current.component(.hour, from: Date())
    @State var greeting: String = "BlockNote"
    
    let dateFormatter = DateFormatter()
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var showHeader = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.darkBack
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    HStack {
                        // empty space
                    }
                    .frame(height: 100)
                    
                    VStack {
                        Text(greeting)
                            .onAppear(perform: {
                                withAnimation {
                                    if hour < 4 {
                                        greeting = "Have a good night ✨"
                                    }
                                    else if hour < 12 {
                                        greeting = "Good morning!☀️"
                                    }
                                    else if hour < 18 {
                                        greeting = "Have a great day! ⛅️"
                                    }
                                    else if hour < 23 {
                                        greeting = "Time for the rest 🌇"
                                    }
                                    else {
                                        greeting = "Have a good night ✨"
                                    }
                                }
                            })
                    }
                    
                })
                
            }
            // end of ZStack
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
        }
        // end of NavView
    }
    
    // MARK: - Functions
    private func addItem() {
        withAnimation {
            let newNote = Note(context: viewContext)
            newNote.name = self.noteName
            newNote.level = "N5"
            
            newNote.noteID = (notes.last?.noteID ?? 0) + 1 // makes the order by id of the note
            
            do {
                try self.viewContext.save()
                noteName = ""
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}
// MARK: - Extensions
extension View {
    public func gradientForegroundColor(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing))
            .mask(self)
    }
}

extension Color {
    static let darkBack = Color("DarkBackground")
}

struct C1NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        C1NavigationView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

/*
 .onAppear(perform: {
     if hour < 4 {
         greeting = "Have a good night ✨"
     }
     else if hour < 12 {
         greeting = "Good morning!☀️"
     }
     else if hour < 18 {
         greeting = "Have a great day! ⛅️"
     }
     else if hour < 23 {
         greeting = "Time for the rest 🌇"
     }
     else {
         greeting = "Have a good night ✨"
     }
 })
 */


/*
 .onReceive(self.time) { (_) in
     // to see if user scrolled downwards and doesn't see the header:
     let Y = geometry.frame(in: .global).minY
     if -Y > (UIScreen.main.bounds.height / 3) - 50 {
         self.showHeader = true
     } else {
         self.showHeader = false
     }
     
 }
 */
