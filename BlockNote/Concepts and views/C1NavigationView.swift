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
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeNow = ""
    let hour = Calendar.current.component(.hour, from: Date())
    @State var greeting: String = ""
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
                    .frame(height: UIScreen.main.bounds.height / 2.2)
                    
                    // MARK: - Content
                    VStack(alignment: .trailing) {
                        Text("GAV \(greeting)")
                            .foregroundColor(.white)
                            .bold()// or timeNow?
                            .onReceive(timer) { _ in
                                self.greeting = dateFormatter.string(from: Date())
                            }
                        //.onAppear(perform: {
                        
                        //})
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
enum greetingVariation {
    case morning
        case afternoon
            case evening
                case night
    
    var greetingText: String {
        switch self {
        case .morning:
            return String("Good morning!☀️")
        case .afternoon:
            return String("Have a great day! ⛅️")
        case .evening:
            return String("Time for the rest 🌇")
        case .night:
            return String("Have a good night ✨")
        }
    }
}

struct C1NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        C1NavigationView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
