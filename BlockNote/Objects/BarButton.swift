//
//  BarButton.swift
//  BlockNote
//
//  Created by Kovs on 23.09.2021.
//

import SwiftUI

struct BarButton: View {
    
    // 4 buttons: Themes, Search, Tasks, Settings:
    
    var body: some View {
        HStack {
            
            Button(action: {
                // Themes:
            }) {
                ZStack {
                    VStack {
                        
                    }
                }
            }
            .buttonStyle(BluredButtonInTabBar())
            // end of the Themes button
            
            
        }
        .background(BlurView(style: .regular))
        .cornerRadius(20)
        .frame(width: UIScreen.main.bounds.width - 30, height: 110)
    }

}

struct BarButton_Previews: PreviewProvider {
    static var previews: some View {
        BarButton()
    }
}
