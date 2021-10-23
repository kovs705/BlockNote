//
//  groupCreate.swift
//  BlockNote
//
//  Created by Kovs on 24.10.2021.
//

import SwiftUI
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
    
    var body: some View {
        ZStack {
            Color.darkBack // background
            
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(returnColorFromString(nameOfColor: color ?? "YellowLemon"))
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
                        Text("15 notes")
                        Spacer()
                    }
                    .padding()
                    // end of VStack
                }
                // end of ZStack
                .frame(width: 170, height: 170)
                .padding(.horizontal)
                
                VStack(alignment: .center) {
                    TextField("Name of a group..", text: $nameOfGroup)
                        .foregroundColor(Color.textForeground)
                        .lineLimit(1)
                        .font(.system(size: 18))
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding()
                
            }
            // main VStack
        }
        // ZStack
    }
    // body
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
