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
    // @ObservedObject var note: Note
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                // MARK: - TopBar Statistics
                ZStack {
                    HStack {
                        Text("Number of words: ")
                            .bold()
                            .font(.system(size: 18))
                        Text("\(groupType.typesArray.count)") // that should work, I guess..
                        
                        Spacer()
                        
                        Text("You've learned: ")
                            .bold()
                            .font(.system(size: 18))
                        Text("Nothing yet! Keep working on code, Eugene")
                        
                        Spacer()
                        Spacer()
                    }
                }
                .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
                .cornerRadius(20)
                .background(returnColorFromString(nameOfColor: groupType.color ?? "GreenAvocado"))
                .frame(width: UIScreen.main.bounds.width - 40, height: 70, alignment: .center)
                
                List {
                    ForEach(groupType.typesArray, id: \.self) { note in
                        HStack {
                            Text("\(note.wrappedName)")
                                .font(.system(size: 18))
                                .bold()
                                .foregroundColor(Color.textForeground)
                            Spacer()
                            VStack {
                                // put a red flag here:
                                
                                Spacer()
                            }
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.gray)
                                .font(.system(size: 18))
                        }
                        .frame(height: 40)
                    }
                }
                .padding(.horizontal)
                
            }
        }
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
