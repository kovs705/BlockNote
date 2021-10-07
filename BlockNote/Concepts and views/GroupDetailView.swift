//
//  GroupDetailView.swift
//  BlockNote
//
//  Created by Kovs on 30.09.2021.
//

import SwiftUI
import CoreData

    /// create a button to mark the note as completed
    /// make a list of the nortes inside a group
    /// make the button to delete the group with all the notes inside (ask a user to delete in or not)
    /// make an ability to put a red flag on notes that are important
    /// --------------------------------

struct GroupDetailView: View {
    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(key: "noteID", ascending: true)]) var notes: FetchedResults<Note>
    @ObservedObject var groupType: GroupType
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.colorScheme) public var detectTheme
    
    @State var funcWithNavLink: Bool = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                // MARK: - TopBar Statistics
                GeometryReader { geometry in
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(returnColorFromString(nameOfColor: groupType.color ?? "GreenAvocado"))
                            .cornerRadius(20)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 150, alignment: .center)
                            .shadow(color: returnColorFromString(nameOfColor: groupType.color ?? "GreenAvocado"), radius: 10, y: 5)
                        
                        // MARK: - Words and Numbers
                        HStack {
                            VStack {
                                Spacer()
                                Text("Notes: ")
                                    .bold()
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.textForeground)
                                
                                Spacer()
                                
                                Text("You've completed: ")
                                    .foregroundColor(Color.textForeground)
                                    
                                    .bold()
                                    .font(.system(size: 16))
                                Spacer()
                            }
                            VStack {
                                Spacer()
                                Text("\(groupType.typesArray.count)") // that should work, I guess..
                                    .font(.system(size: 16))
                                Spacer()
                                Text("Nothing yet!")
                                    .font(.system(size: 14))
                                    .padding(.horizontal)
                                Spacer()
                            }
                            
                            Spacer()
                            
                            // MARK: - Buttons
                            VStack {
                                Button(action: {
                                // action to open Tasks of the group:
                                    
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(returnColorFromString(nameOfColor: groupType.color ?? "GreenAvocado"))
                                            .frame(width: 75, height: 75)
                                            .shadow(color: .black.opacity(0.25), radius: 10, y: 5)
                                        Image(systemName: "list.bullet.rectangle")
                                            .font(.system(size: 32))
                                            .foregroundColor(Color.textForeground)
                                    }
                                }
                                .buttonStyle(AnimatedButton())
                                Button(action: {
                                    // action to create an empty note:
                                    createNote()
                                    // MARK: Put a navigationLink here:
                                    // 
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(returnColorFromString(nameOfColor: groupType.color ?? "GreenAvocado"))
                                            .frame(width: 75, height: 75)
                                            .shadow(color: .black.opacity(0.25), radius: 10, y: 5)
                                        Image(systemName: "plus")
                                            .font(.system(size: 32))
                                            .foregroundColor(Color.textForeground)
                                    }
                                }
                                .buttonStyle(AnimatedButton())
                            }
                            Spacer()
                        }
                        .padding()
                        
                    }
                    .frame(width: UIScreen.main.bounds.width - 30, height: 150, alignment: .center)
                    // end of ZStack
                }
                .padding()
                // MARK: - List of notes
                ListForGroupDetail()
                    .frame(width: UIScreen.main.bounds.width - 30)
                
            }
        }
        .navigationBarItems(trailing: Button(action: {
            // to add a new Note
            // MARK: - Do something with it
        }) {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 20))
        })
        .navigationTitle(groupType.wrappedName)
    }
    // MARK: - Functions
    func createNote() {
        withAnimation {
            let newNote = Note(context: self.viewContext)
            // newNote.typeOfNote = GroupType(context: self.viewContext)
            // newNote.typeOfNote?.name = self.groupType.wrappedName // name of the group will be the same as on the page, which is opened by user
            
            newNote.name = "" // note name
            newNote.level = "" // note lvl or whatever it can be for user
            newNote.noteID = (notes.last?.noteID ?? 0) + 1 // note id, which will place notes in the right order
            newNote.isMarked = false // note isn't marked yet, so user can do it later
            
            do {
                try self.viewContext.save()
                
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

// MARK: - Preview
struct GroupDetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let groupType = GroupType(context: moc)
        groupType.name = "Test Group name"
        groupType.color = "greenAvocado"
        
        return NavigationView {
            GroupDetailView(groupType: groupType)
        }
    }
}
