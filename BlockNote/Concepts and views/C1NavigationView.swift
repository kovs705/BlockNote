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
    // @State var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    // @State var timeNow = ""
    let hour = Calendar.current.component(.hour, from: Date())
    @State var greeting: String = "Haveeee a great day! ⛅️"
    let dateFormatter = DateFormatter()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                ScrollView(.vertical) {
                    // MARK: - Header
                    GeometryReader { geometry in
                        // place a black header here:
                        ZStack {
                            Color.green
                            
                        }
                        .offset(y: geometry.frame(in: .global).minY > 0 ? -geometry.frame(in: .global).minY : 0)
                        .frame(height: geometry.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / 2.2 + geometry.frame(in: .global).minY : UIScreen.main.bounds.height / 2.2)
                    }
                    // .frame(height: UIScreen.main.bounds.height / 2.2)
                    .frame(height: 200)
                    
                    // MARK: - Content
                    VStack(alignment: .trailing) {
                        Text("\(greeting)")
                            .foregroundColor(.white)
                            
                            .onAppear(perform: {
                                if hour < 4 || hour > 23 {
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
                                    greeting = "Have a great day! ⛅️"
                                }
                                
                            })
                        
                    }
                    .padding()
                    .cornerRadius(20)
                    
                    Spacer()
                }
                .edgesIgnoringSafeArea(.top)
                // end of ScrollView
            }
            // end of ZStack
            .navigationBarHidden(true)
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

struct C1NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        C1NavigationView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
