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
    @ObservedObject var groupType: GroupType
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                // MARK: - TopBar Statistics
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(returnColorFromString(nameOfColor: groupType.color ?? "GreenAvocado"))
                        .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
                        .cornerRadius(20)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 70, alignment: .center)
                    
                    HStack {
                        Text("Number of words: ")
                            .bold()
                            .font(.system(size: 16))
                            .foregroundColor(Color.textForeground)
                        Text("\(groupType.typesArray.count)") // that should work, I guess..
                            .font(.system(size: 16))

                        Spacer()
                        
                        Text("You've learned: ")
                            .foregroundColor(Color.textForeground)

                            .bold()
                            .font(.system(size: 16))
                        Text("Nothing yet! Keep working on code, Eugene")
                            .font(.system(size: 14))
                        
                        Spacer()
                    }
                    .padding()
                    
                }
                .frame(width: UIScreen.main.bounds.width - 30, height: 90, alignment: .center)
                
                List {
                    ForEach(groupType.typesArray, id: \.self) { note in
                        HStack {
                            Text("\(note.wrappedName)")
                                .font(.system(size: 18))
                                .bold()
                                .foregroundColor(Color.textForeground)
                            Spacer()
                            Spacer()
                            
                            if note.isMarked == true {
                                VStack {
                                    // put a red flag here:
                                    Image(systemName: "bookmark.fill")
                                        .foregroundColor(.red)
                                        .font(.system(size: 20))
                                    Spacer()
                                }
                            }
                            
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.gray)
                                .font(.system(size: 18))
                                .padding()
                        }
                        .contextMenu {
                            Button(action: {
                                if note.isMarked == false {
                                    
                                    note.isMarked = true // change the isMarked value to true
                                    do {
                                        try self.viewContext.save()
                                    } catch {
                                        // MARK: - CHANGE (!!!)
                                        let nsError = error as NSError
                                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                    }
                                } else {
                                    note.isMarked = false // change the isMarked value to false
                                    do {
                                        try self.viewContext.save()
                                    } catch {
                                        let nsError = error as NSError
                                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                    }
                                }
                            }, label: {
                                
                            })
                        }
                        .frame(height: 40)
                    }
                }
                .padding(.horizontal)
                
            }
        }
        .navigationBarItems(trailing: Button(action: {
            // to add a new Note
            
        }) {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 20))
        })
        .navigationTitle(groupType.wrappedName)
    }
}

// /*
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
//  */
