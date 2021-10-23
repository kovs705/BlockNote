//
//  groupCreateModel.swift
//  BlockNote
//
//  Created by Kovs on 24.10.2021.
//

import Foundation
import SwiftUI

final class GOP: ObservableObject {
    @Published var color: String = "GreenAvocado"
    
}

struct GridObjectPreview: View {
    @StateObject private var groupCreateModel = GOP()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(returnColorFromString(nameOfColor: groupCreateModel.color ?? "YellowLemon"))
                .frame(width: 175, height: 175)
            VStack {
                Spacer()
                HStack {
                    // name of the group:
                    Text("Test name")
                        .bold()
                        .lineLimit(2)
                    Spacer()
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
    }
}
