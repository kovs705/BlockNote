//
//  ObjectColorStruct.swift
//  BlockNote
//
//  Created by Kovs on 22.09.2021.
//

import SwiftUI
import CoreData

struct GridObject: View {
    let groupType: GroupType
    
    //  MARK: - Body of Type
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(returnColorFromString(nameOfColor: groupType.color ?? "YellowLemon"))
                .frame(width: 150, height: 150)
            VStack {
                Spacer()
                HStack {
                    // text content here:
                    Text(groupType.name ?? "Test name")
                    Spacer()
                }
            }
            .padding()
            // end of VStack
        }
        // end of ZStack
        .frame(width: 150, height: 150)
    }
}

func returnColorFromString(nameOfColor: String) -> Color {
    return Color.init(nameOfColor)
}

