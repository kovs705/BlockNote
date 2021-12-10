//
//  UITextViewContainer.swift
//  BlockNote
//
//  Created by Kovs on 06.12.2021.
//

import SwiftUI
import CoreData

struct UITextViewContainer: UIViewRepresentable {
    @ObservedObject var noteItem: NoteItem
    // let text: String
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.font = .systemFont(ofSize: 16)
        return textView
    }
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<Self>) {
        if uiView.frame.size != .zero {
            uiView.isScrollEnabled = false
        }
        uiView.text = self.noteItem.noteItemText
    }
    
}




//struct UITextViewContainer_Previews: PreviewProvider {
//
//    static var previews: some View {
//        UITextViewContainer()
//    }
//}
