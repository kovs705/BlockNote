//
//  C2NavigationView.swift
//  BlockNote
//
//  Created by Kovs on 04.12.2021.
//

import SwiftUI

struct C2NavigationView: View {
    
    @FetchRequest(entity: GroupType.entity(), sortDescriptors: [NSSortDescriptor(key: "number", ascending: true)]) var types: FetchedResults<GroupType>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State var time = Timer.publish(every: 0, on: .main, in: .tracking).autoconnect()
    // MARK: - !!!
    @StateObject private var C2ViewModel = C2NavViewModel() // MVVM
    
    @State private var showAddGroupSheet: Bool = false
    @State private var color: Color = .greenAvocado
    @State private var nameOfGroup = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.darkBack
                ScrollView(.vertical) {
                    VStack {
                        // empty space
                    }
                    .frame(height: 90)
                    
                    // MARK: - geometryGreeting
                    GeometryReader { geometry in
                        HStack {
                            Spacer()
                            VStack(alignment: .center) {
                                Text(C2ViewModel.greeting)
                                    .bold()
                                    .lineLimit(1)
                                    .font(.system(size: 28))
                                    .onAppear(perform: {
                                        C2ViewModel.showGreeting()
                                        
                                    })
                                    // .animation(.easeInOut)
                            }
                            .onReceive(self.time) { (_) in
                                // to see if user scrolled downwards and doesn't see the greeting:
                                let Y = geometry.frame(in: .global).minY
                                if -Y > (UIScreen.main.bounds.height / 8) - 90 {
                                    withAnimation(.easeInOut) {
                                        C2ViewModel.showBar = true
                                    }
                                } else {
                                    withAnimation(.easeInOut) {
                                        C2ViewModel.showBar = false
                                    }
                                }
                            }
                            Spacer()
                        }
                        // end of HStack
                    }
                    .frame(height: 40)
                    
                    // MARK: - Statistics and Sheet
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.lightPart)
                            .frame(width: UIScreen.main.bounds.width - 85, height: 200)
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                        Button(action: {
                            showAddGroupSheet.toggle()
                            // self.addItem()
                        }) {
                            Text("Add group")
                        }
                    }
                    .frame(height: 250)
                    
                    // MARK: - Buttons
                    HStack {
                        Text("List of groups")
                            .font(.system(size: 22))
                            .bold()
                        Spacer()
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.lightPart)
                                .frame(width: 35, height: 35)
                            Image(systemName: "pencil")
                                .foregroundColor(Color.textForeground)
                        }
                        
//                        NavigationLink(destination: NoteListDebug()) {
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 10)
//                                    .fill(Color.lightPart)
//                                    .frame(width: 35, height: 35)
//                                Image(systemName: "lineweight")
//                                
//                                    .foregroundColor(Color.textForeground)
//                            }
//                        }
                        
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
                                // end of ZStack with GridObject
                            }
                            .buttonStyle(AnimatedButton())
                        }
                        .onDelete(perform: deleteGroup) // edit to make it onTap
                    }
                    .padding()
                    // LazyVGrid
                    
                }
                // ScrollView
            }
            //ZStack
        }
        // NavigationView
        .sheet(isPresented: $showAddGroupSheet) {
            groupCreateView(chosenColor: $color, nameOfGroup: $nameOfGroup)
        }
        .navigationTitle("")
    }
    
    // MARK: - Functions
    private func addItem() {
        withAnimation {
            let newGroup = GroupType(context: viewContext)
            
            newGroup.groupName = "Checking.."
            newGroup.number = (types.last?.number ?? 0) + 1
            newGroup.groupColor = "RedStrawBerry"
            
            do {
                try self.viewContext.save()
                print("Group is added!")
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


struct C2NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        C2NavigationView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
