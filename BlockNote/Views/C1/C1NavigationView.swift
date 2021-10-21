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
    /// MVVM DO IT!!!
    ///
//

struct C1NavigationView: View {
    
    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(key: "noteID", ascending: true)]) var notes: FetchedResults<Note>
    
    @FetchRequest(entity: GroupType.entity(), sortDescriptors: [NSSortDescriptor(key: "number", ascending: true)]) var types: FetchedResults<GroupType>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let dateFormatter = DateFormatter()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State var time = Timer.publish(every: 0, on: .main, in: .tracking).autoconnect()
    
    @StateObject private var C1ViewModel = C1NavViewModel() // MVVM
    
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
                                Text(C1ViewModel.greeting)
                                    .bold()
                                    .lineLimit(1)
                                    .font(.system(size: 28))
                                    .onAppear(perform: {
                                        C1ViewModel.showGreeting()
                                        
                                    })
                                    .animation(.easeInOut)
                            }
                            .onReceive(self.time) { (_) in
                                // to see if user scrolled downwards and doesn't see the greeting:
                                let Y = geometry.frame(in: .global).minY
                                if -Y > (UIScreen.main.bounds.height / 8) - 90 {
                                    withAnimation(.easeInOut) {
                                        C1ViewModel.showBar = true
                                    }
                                } else {
                                    withAnimation(.easeInOut) {
                                        C1ViewModel.showBar = false
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
                            self.addItem()
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
                                C1ViewModel.onDeleting.toggle()
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
                            NavigationLink(destination: NoteListDebug()) {
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
                                    .frame(width: 175, height: 180)
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
                        .offset(y: C1ViewModel.showBar ? UIScreen.main.bounds.height : 0)
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
            // let newNote = Note(context: viewContext)
            let newGroup = GroupType(context: viewContext)
            
            newGroup.groupName = "Checking.."
            newGroup.number = (types.last?.number ?? 0) + 1
            
            do {
                try self.viewContext.save()
                // noteName = ""
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func deleteGroup(at offsets: IndexSet) {
        for index in offsets {
            let type = types[index]
            viewContext.delete(type)
            // MARK: - delete notes of this group with it
        }
        do {
            try self.viewContext.save()
        } catch {
            print("something happened on deleting the group!")
        }
    }
    
}


struct C1NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        C1NavigationView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
