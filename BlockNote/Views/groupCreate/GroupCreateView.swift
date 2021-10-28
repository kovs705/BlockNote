//
//  groupCreate.swift
//  BlockNote
//
//  Created by Kovs on 24.10.2021.
//

import SwiftUI
import Combine
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
    @Binding var numberOfGroup: Int
    
    @State private var isEditing = false
    
    var body: some View {
        ZStack {
            Color.darkBack // background
            
            VStack(alignment: .center) {
                Text("Create a group..")
                    .padding()
                    .font(.footnote)
                Spacer()
                
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
                
                TextField("Name of a group..", text: $nameOfGroup) { isEditing in
                    self.isEditing = isEditing
                } onCommit: {
                    UIApplication.shared.endEditing()
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
                
                Spacer()
                Spacer()
            }
            // main VStack
        }
        // ZStack
        .ignoresSafeArea(.all)
    }
    // body
}


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

