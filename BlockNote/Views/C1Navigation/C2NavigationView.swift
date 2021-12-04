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
    @StateObject private var C1ViewModel = C1NavViewModel() // MVVM
    
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
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(types, id: \.self) { type in
                            // transition to the DetailView:
                            NavigationLink(destination: GroupDetailView(groupType: type)) {
                                
                                // TODO: - sort objects to avoid the same types:
                                
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
