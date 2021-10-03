//
//  C1NavigationView.swift
//  BlockNote
//
//  Created by Kovs on 13.09.2021.
//

import SwiftUI
import UIKit
import Combine
import CoreData

// MARK: - Instructions
    ///
    /// 20.09.2021 - Making this istructions-block
    /// think about what to add or how to group Notes
    /// сделать ColorPicker в виде линии цветных шариков, при наведении пальца на которые пользователь
    /// будет видеть название того или иного цвета
    /// посмотрите свои уроки за неделю, которые вы прошли
    /// "время повторить уроки!"
    /// окошко при удалении
    /// окно приветствия как в сбере (со сменой дизайна в зависимости от времени суток)
    /// task page with two islands: incompleted and completed tasks
    /// сделать редактирование групп на отдельной странице (раз уж не хочет работать, лол)
    ///
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
    @State var showBar: Bool = false
    
    @State var typeName: String = ""
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State var onDeleting: Bool = false
    
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
        NavigationView {
            ZStack {
                
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
                                if -Y > (UIScreen.main.bounds.height / 8) - 90 {
                                    withAnimation(.easeInOut) {
                                        self.showBar = true
                                    }
                                } else {
                                    withAnimation(.easeInOut) {
                                        self.showBar = false
                                    }
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
                                self.onDeleting.toggle()
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.lightPart)
                                        .frame(width: 35, height: 35)
                                    Image(systemName: "pencil")
                                        .foregroundColor(Color.textForeground)
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
                                        .foregroundColor(Color.textForeground)
                                }
                            }
                            
                        }
                        .frame(width: UIScreen.main.bounds.width - 50)
                        
                        // MARK: - Groups
                        
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(types, id: \.self) { type in
                                // transition to the DetailView:
                                NavigationLink(destination: GroupDetailView(groupType: type)) {
                                    ZStack {
                                        GridObject(groupType: type)
                                            .foregroundColor(Color.textForeground)
                                            .zIndex(-5)
                                    }
                                    .frame(width: 175, height: 175)
                                }
                                .buttonStyle(AnimatedButton())
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
                
                // MARK: - TabBar
                        VStack {
                            Spacer()
                            BarButton()
                        }
                        // .transition(.move(edge: .bottom))
                        .offset(y: showBar ? UIScreen.main.bounds.height : 0)
                        .animation(.spring())
                        .padding(.vertical)
            }
            .navigationBarHidden(true)
            .ignoresSafeArea(.all)
        }
        .navigationTitle("")
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
    @Environment(\.colorScheme) public var detectTheme
    
    func makeBody(configuration: Self.Configuration) -> some View {
        if detectTheme == .dark {
        configuration.label
            .padding(20)
            .cornerRadius(20)
            .background(BlurView(style: .regular))
            // .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .frame(width: 70, height: 69)
        } else {
            configuration.label
                .padding(20)
                .cornerRadius(20)
                .background(Color.white)
                .frame(width: 70, height: 69)
                .shadow(color: .black.opacity(0.3), radius: 10, y: -5)
        }
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
    static let textForeground = Color("TextForeground")
    
    public static var darkBlue: Color {
        return Color(red: 28 / 255, green: 46 / 255, blue: 74 / 255)
    }
    public static var offWhite: Color {
        return Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
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
 LinearGradient(gradient: Gradient(colors: [.pink, .blue]),
                startPoint: .top,
                endPoint: .bottom)
     .mask(Text("your text"))
 */

/*                                    if onDeleting {
                                        Button(action: {
                                            // deleting action here:
                                            // deleteGroup(at: )
                                        }) {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .fill(Color.red)
                                                    .frame(width: 30, height: 30)
                                                    .zIndex(-4)
                                                Image(systemName: "minus")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 18))
                                                    .zIndex(-4)
                                            }
                                        }
                                        .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(.spring())
                                        .zIndex(-4)
                                    }
 */
