//
//  C1NavigationView.swift
//  BlockNote
//
//  Created by Kovs on 13.09.2021.
//

import SwiftUI
import UIKit
import Combine

// MARK: - Instructions
    ///
    /// 20.09.2021 - Making this istructions-block
    /// think about what to add or how to group Notes
    ///
    ///
    ///
//

struct C1NavigationView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(key: "noteID", ascending: true)]) var notes: FetchedResults<Note>
    
    @State private var noteName: String = ""
    
    let hour = Calendar.current.component(.hour, from: Date())
    @State var greeting: String = "BlockNote"
    
    let dateFormatter = DateFormatter()
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var showHeader = false
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.darkBack
                ScrollView(.vertical, showsIndicators: false) {
                    HStack {
                        // empty space
                    }
                    .frame(height: 90)
                    // MARK: - Greeting
                    VStack {
                        Text(greeting)
                            .bold()
                            .lineLimit(1)
                            .font(.system(size: 28))
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
                            .animation(.easeInOut)
                    }
                    .frame(height: 40)
                    // MARK: - Block for statistics
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.lightPart)
                            .frame(width: UIScreen.main.bounds.width - 85, height: 200)
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .frame(height: 250)
                    
                    
                    // MARK: - Grouped notes
                    VStack {
                        HStack {
                            Text("List of groups")
                                .font(.system(size: 22))
                                .bold()
                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.width - 50)
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(notes, id: \.self) { note in
                                
                            }
                        }
                        
                        
                        // end of HStack
                    }
                    // end of VStack
                    
                }
                .ignoresSafeArea(.all)
                // end of VStack
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(.all)
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
    static let lightPart = Color("LightPart")
    
    // pastel colors:
    static let rosePink = Color("RosePink")
    static let greenAvocado = Color("GreenAvocado")
    static let blueBerry = Color("BlueBerry")
    static let yellowLemon = Color("YellowLemon")
    static let redStrawBerry = Color("RedStrawBerry")
    static let purpleBlackBerry = Color("PurpleBlackBerry")
    static let greyCloud = Color("GreyCloud")
    static let brownSugar = Color("BrownSugar")
    
    public static var darkBlue: Color {
        return Color(red: 28 / 255, green: 46 / 255, blue: 74 / 255)
    }
    public static var veryDarkBlue: Color {
        return Color(red: 10 / 255, green: 20 / 255, blue: 50 / 255)
    }
    public static var darkGold: Color {
        return Color(red: 133 / 255, green: 94 / 255, blue: 60 / 255)
    }
}

struct C1NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        C1NavigationView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

// MARK: - GridItem object
struct GridObject : View{
    
    enum ObjectColor {
        // about 5-8 pastel
        case rosePink; case greenAvocado; case blueBerry
        case yellowLemon; case redStrawberry
        case purpleBlackBerry; case greyCloud; case brownSugar
        // different-colored circles with the color names when you put your finger on it
        
        var ObjectColorString: Color {
            switch self {
            case .rosePink:
                return Color.rosePink
            case .greenAvocado:
                return Color.greenAvocado
            case .blueBerry:
                return Color.blueBerry
            case .yellowLemon:
                return Color.yellowLemon
            case .redStrawberry:
                return Color.redStrawBerry
            case .purpleBlackBerry:
                return Color.purpleBlackBerry
            case .greyCloud:
                return Color.greyCloud
            case .brownSugar:
                return Color.brownSugar
            }
        }
    }
    
    struct ObjectColorStruct {
        var color: ObjectColor
    }
    @Binding var objectStructColor: ObjectColorStruct
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(objectStructColor.color.ObjectColorString)
        }
        .frame(width: 100, height: 100)
    }
}


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
