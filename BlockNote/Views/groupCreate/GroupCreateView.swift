//
//  groupCreate.swift
//  BlockNote
//
//  Created by Kovs on 24.10.2021.
//

import SwiftUI
import Combine
import CoreData

// MARK: - instructions
    /// create a colorPicker for GridObject
    /// create a preview of GridObject with the name, color, number of notes and other things (like type, or lvl)
    ///
    ///
    ///
//

struct groupCreateView: View {
    
    @Binding var color: String
    @Binding var nameOfGroup: String
    
    @FetchRequest(entity: GroupType.entity(), sortDescriptors: [NSSortDescriptor(key: "groupName", ascending: true)]) var types: FetchedResults<GroupType>
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isEditing = false
    
    var body: some View {
        ZStack {
            Color.darkBack // background
            
            VStack(alignment: .center) {
                Text("Create a group..")
                    .padding()
                    .font(.footnote)
                Spacer()
                
                // MARK: - Preview
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(returnColorFromStringForPreview(nameOfColor: color))
                        .frame(width: 175, height: 175)
                    VStack {
                        Spacer()
                        if nameOfGroup == "" {
                            HStack {
                                // name of the group:
                                Text("Test name")
                                    .bold()
                                    .lineLimit(2)
                                Spacer()
                            }
                        } else {
                            HStack {
                                // name of the group:
                                Text("\(nameOfGroup)")
                                    .bold()
                                    .lineLimit(2)
                                Spacer()
                            }
                        }
                        
                        // number of notes inside:
                        HStack {
                            Text("15 notes")
                            Spacer()
                        }
                    }
                    .padding()
                    // end of VStack
                }
                // end of ZStack
                .frame(width: 170, height: 170)
                .padding(.horizontal)
                
                // MARK: - TextField
                TextField("Name of a group..", text: $nameOfGroup) { isEditing in
                    self.isEditing = isEditing
                } onCommit: {
                    UIApplication.shared.endEditing()
                    // create group:
                    addNewGroup(nameOfGroup: nameOfGroup)
                }
                .frame(height: 55)
                .textFieldStyle(PlainTextFieldStyle())
                .padding([.horizontal], 4)
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(isEditing ? Color.textForeground : Color.gray))
                .padding([.horizontal], 24)
                .padding() // 18 - limit of characters
                .foregroundColor(Color.textForeground)
                .lineLimit(1)
                .font(.system(size: 18))
                
                // MARK: - Create group button
                
                
                Spacer()
                Spacer()
            }
            // main VStack
        }
        // ZStack
        .ignoresSafeArea(.all)
    }
    // body
    
    // MARK: - Add new group func
    func addNewGroup(nameOfGroup: String) {
        
        withAnimation {
            let newGroup = GroupType(context: viewContext)
            
            for type in types { // for each group in CoreData:
                if nameOfGroup == type.groupName { // if the name is equal as an existing name
                    newGroup.groupName = "THE SAME GROUP"
                } else if nameOfGroup == "" { // or this name is empty
                    newGroup.groupName = "Unknown group"
                } else {
                    newGroup.groupName = nameOfGroup
                }
            }
            
            if nameOfGroup == "" {
                newGroup.groupName = "Unknown group"
            } else {
                newGroup.groupName = nameOfGroup
            }
            
            newGroup.number = (types.last?.number ?? 0) + 1
            newGroup.noteTypes = [] // for future notes?
            
            // MARK: - function for colorPicker
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
}

// MARK: - Color picker


func returnColorFromStringForPreview(nameOfColor: String) -> Color {
    if nameOfColor == "" {
        let nameOfColor = "GreenAvocado"
        return Color.init(nameOfColor)
    } else {
        return Color.init(nameOfColor)
    }
}


/*
struct groupCreate_Previews: PreviewProvider {
    
    let color = "GreenAvocado"
    let nameOfGroup = "Test NAme"
    let numberOfGroup = 123
    
    static var previews: some View {
        groupCreateView(color: color, nameOfGroup: nameOfGroup, numberOfGroup: numberOfGroup)
    }
}
 */

