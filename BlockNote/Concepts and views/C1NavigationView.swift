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
    /// сделать ColorPicker в виде линии цветных шариков, при наведении пальца на которые пользователь
    /// будет видеть название того или иного цвета
    /// посмотрите свои уроки за неделю, которые вы прошли
    /// "время повторить уроки!"
    ///  окошко при удалении
    ///  окно приветствия как в сбере (со сменой дизайна в зависимости от времени суток)
    /// task page with two islands: incompleted and completed tasks
//

struct C1NavigationView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(key: "noteID", ascending: true)]) var notes: FetchedResults<Note>
    
    @FetchRequest(entity: GroupType.entity(), sortDescriptors: [NSSortDescriptor(key: "number", ascending: true)]) var types: FetchedResults<GroupType>
    
    @State var isEditing = false
    
    @State private var noteName: String = ""
    
    let hour = Calendar.current.component(.hour, from: Date())
    @State var greeting: String = "BlockNote"
    
    let dateFormatter = DateFormatter()
    @State var time = Timer.publish(every: 0, on: .main, in: .tracking).autoconnect()
    @State var showBar = false
    
    @State var typeName: String = ""
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    func deleteGroup(at offsets: IndexSet) {
        for index in offsets {
            let type = types[index]
            viewContext.delete(type)
        }
        do {
            try self.viewContext.save()
        } catch {
            print("something happened on deleting the group!")
        }
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            
            // MARK: - TabBar
                BarButton()
                    
            
            Color.darkBack
                ScrollView(.vertical, showsIndicators: false) {
                    HStack {
                        // empty space
                    }
                    .frame(height: 90)
                    
                    
                    // MARK: - Greeting
                    GeometryReader { geometry in
                        HStack {
                            Spacer()
                            VStack(alignment: .center) {
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
                                            greeting = "Good evening 🌇"
                                        }
                                        else {
                                            greeting = "Have a good night ✨"
                                        }
                                        
                                    })
                                    .animation(.easeInOut)
                            }
                            .onReceive(self.time) { (_) in
                                // to see if user scrolled downwards and doesn't see the greeting:
                                let Y = geometry.frame(in: .global).minY
                                if -Y > (UIScreen.main.bounds.height / 8) - 80 {
                                    self.showBar = true
                                } else {
                                    self.showBar = false
                                }
                            }
                            Spacer()
                        }
                        // end of HStack
                    }
                    .frame(height: 40)
                    
                    
                    // MARK: - Block for statistics
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.lightPart)
                            .frame(width: UIScreen.main.bounds.width - 85, height: 200)
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                        Button(action: {
                            addItem()
                        }) {
                            Text("Add group")
                        }
                    }
                    .frame(height: 250)
                    
                    
                    // MARK: - Buttons
                    VStack {
                        HStack {
                            Text("List of groups")
                                .font(.system(size: 22))
                                .bold()
                            Spacer()
                            // MARK: - Edit button
                            Button(action: {
                                // put the action here:
                                
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.lightPart)
                                        .frame(width: 35, height: 35)
                                    Image(systemName: "pencil")
                                        .foregroundColor(.white)
                                }
                            }
                            
                            // MARK: - Changing view button
                            Button(action: {
                                
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.lightPart)
                                        .frame(width: 35, height: 35)
                                    Image(systemName: "lineweight")
                                        .foregroundColor(.white)
                                }
                            }
                            
                        }
                        .frame(width: UIScreen.main.bounds.width - 50)
                        
                        // MARK: - Groups
                        
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(types, id: \.self) { type in
                                GridObject(groupType: type)
                            }
                            .onDelete(perform: deleteGroup) // edit to make it onTap
                        }
                        .padding()
                        
                        
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
            let newGroup = GroupType(context: viewContext)
            
            newNote.name = "Test"
            newNote.level = "N5"
            newNote.typeOfNote?.color = "rosePink"
            // newGroup.color = "rosePink"
            newGroup.name = "Checking.."
            newGroup.number = (types.last?.number ?? 0) + 1
            
            newNote.noteID = (notes.last?.noteID ?? 0) + 1 // makes the order by id of the note
            
            do {
                try self.viewContext.save()
                // noteName = ""
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

struct BluredButtonInTabBar: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(BlurView(style: .prominent))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .frame(width: 90, height: 90)
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
