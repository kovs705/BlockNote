//
//  ContentView.swift
//  BlockNote
//
//  Created by Kovs on 06.09.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(key: "noteID", ascending: true)], predicate: nil) var notes: FetchedResults<Note>
    @FetchRequest(entity: GroupType.entity(), sortDescriptors: [NSSortDescriptor(key: "number", ascending: true)], predicate: nil) var groups: FetchedResults<GroupType>
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // MARK: - Groups
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(groups, id: \.self) { group in
                            NavigationLink(destination: GroupDetailView(groupType: group)) {
                                Text(group.wrappedGroupName)
                                    .font(.system(size: 17))
                            }
                        }
                    }
                    .padding()
                    
                }
                // VStack
            }
            .frame(width: UIScreen.main.bounds.width - 20, height: 700)
            
            // scroll
            .navigationBarItems(trailing: Button(action: {
                addItem()
            }) {
                Image(systemName: "plus")
            })
            // ZStack
        }
        .ignoresSafeArea(.all)
        // NaView
        
    }

    private func addItem() {
        withAnimation {
            let newGroup = GroupType(context: viewContext)
            
            newGroup.groupName = "Checking.."
            newGroup.number = (groups.last?.number ?? 0) + 1
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

    private func deleteGroups(offsets: IndexSet) {
        withAnimation {
            offsets.map { groups[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


//import SwiftUI
//import CoreData
//
//struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(key: "noteID", ascending: true)]) var notes: FetchedResults<Note>
//
//    @State private var noteName: String = ""
//
//    var body: some View {
//        NavigationView {
//            VStack {
//
//                TextField("Note name...", text: $noteName, onCommit: {
//                    addItem()
//                })
//                .padding()
//                .frame(width: UIScreen.main.bounds.width - 80, height: 55)
//                .contentShape(Rectangle())
//                .background(Color.white)
//                .font(.system(size: 18))
//                .cornerRadius(20)
//
//                .lineLimit(1)
//
//                List {
//                    ForEach(notes, id: \.self) { note in
//                        Text(note.noteName ?? "Unknown name")
//                    }
//                    .onDelete(perform: deleteItems)
//                }
//            }
//        }
//        // end of NavigationView
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newNote = Note(context: viewContext)
//            newNote.noteName = self.noteName
//            newNote.noteLevel = "N5"
//
//            newNote.noteID = (notes.last?.noteID ?? 0) + 1 // makes the order by id of the note
//
//            do {
//                try self.viewContext.save()
//                noteName = ""
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { notes[$0] }.forEach(viewContext.delete)
//
//            do {
//                try self.viewContext.save()
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}
//
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
