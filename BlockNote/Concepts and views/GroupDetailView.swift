//
//  GroupDetailView.swift
//  BlockNote
//
//  Created by Kovs on 30.09.2021.
//

import SwiftUI

struct GroupDetailView: View {
    
    let groupType: GroupType
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
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
                        Text("Nothing yet!")
                        
                        Spacer()
                        Spacer()
                    }
                }
                .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
                .cornerRadius(20)
                .background(Color.offWhite)
                .frame(width: UIScreen.main.bounds.width - 40, height: 70, alignment: .center)
            }
        }
    }
}


/*
struct GroupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GroupDetailView(groupType:)
    }
}
 */
