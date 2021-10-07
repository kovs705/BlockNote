//
//  ListForGroupDetail.swift
//  BlockNote
//
//  Created by Kovs on 07.10.2021.
//

import SwiftUI
import CoreData

struct ListForGroupDetail: View {
    
    // @ObservedObject var noteList: Note
    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(key: "noteID", ascending: true)]) var notes: FetchedResults<Note>
    @Environment(\.managedObjectContext) var viewContext
    // @ObservedObject var noteList: Note
    
    var body: some View {
        List {
            ForEach(notes, id: \.self) { note in
                
                if note.wrappedName == "" {
                    // if note is just created and doesn't even have a name:
                    HStack {
                        Text("Click to open the note")
                            .foregroundColor(Color.gray)
                            .padding(.horizontal)
                    }
                } else {
                    HStack {
                        Text("\(note.wrappedName)")
                            .font(.system(size: 18))
                            .bold()
                            .foregroundColor(Color.textForeground)
                        Spacer()
                        Spacer()
                        
                        if note.isMarked == true {
                            VStack {
                                // put a red flag here:
                                Image(systemName: "bookmark.fill")
                                    .foregroundColor(.red)
                                    .font(.system(size: 20))
                                Spacer()
                            }
                        }
                        
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.gray)
                            .font(.system(size: 18))
                            .padding()
                    }
                    // MARK: - Context menu
                    .contextMenu {
                        Button(action: {
                            if note.isMarked == false {
                                
                                note.isMarked = true // change the isMarked value to true
                                do {
                                    try self.viewContext.save()
                                } catch {
                                    // MARK: - CHANGE (!!!)
                                    let nsError = error as NSError
                                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                }
                            } else {
                                note.isMarked = false // change the isMarked value to false
                                do {
                                    try self.viewContext.save()
                                } catch {
                                    let nsError = error as NSError
                                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                }
                            }
                        }, label: {
                            // MARK: - ADD LABEL HERE
                            if note.isMarked == true {
                                Label("Mark the note", systemImage: "bookmark.fill")
                            } else {
                                Label("Mark the note", systemImage: "bookmark")
                            }
                        })
                    }
                    .frame(height: 40)
                    // end
                }
                // end of If statement
            }
            // end of ForEach
        }
        .padding(.horizontal)
    }
}
/*
struct ListForGroupDetail_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let note = Note(context: moc)
        return NavigationView {
            ListForGroupDetail(noteList: note)
        }
    }
}
 */
