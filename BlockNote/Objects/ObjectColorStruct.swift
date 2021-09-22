//
//  ObjectColorStruct.swift
//  BlockNote
//
//  Created by Kovs on 22.09.2021.
//

import SwiftUI
import CoreData

struct GridObject: View {
    /*
    enum ObjectColor {
        // about 5-8 pastel
        case rosePink
            case greenAvocado
                case blueBerry
                    case yellowLemon
                        case redStrawberry
                            case purpleBlackBerry
                                case greyCloud
                                    case brownSugar
        // different-colored circles with the color names when you put your finger on it
        
        var ObjectColorString: String {
            switch self {
            case .rosePink:
                return String("rosePink")
            case .greenAvocado:
                return String("greenAvocado")
            case .blueBerry:
                return String("blueBerry")
            case .yellowLemon:
                return String("yellowLemon")
            case .redStrawberry:
                return String("redStrawberry")
            case .purpleBlackBerry:
                return String("purpleBlackBerry")
            case .greyCloud:
                return String("greyCloud")
            case .brownSugar:
                return String("brownSugar")
            }
        }
    }
 */
    
    
   /*
    struct ObjectStruct {
        var color: ObjectColor
    }
 */
    
    // @Binding var exactColor: ObjectStruct
    let groupType: GroupType
    
    //  MARK: - Body of Type
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(returnColorFromString(nameOfColor: groupType.color!))
                .frame(width: 100, height: 100)
            VStack {
                Spacer()
                HStack {
                    // text content here:
                    Text(groupType.name ?? "Test name")
                    Spacer()
                }
            }
            // end of VStack
        }
        // end of ZStack
        .frame(width: 100, height: 100)
    }
}

func returnColorFromString(nameOfColor: String) -> Color {
    return Color.init(nameOfColor)
}

