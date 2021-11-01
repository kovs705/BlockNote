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
    @FetchRequest(entity: GroupType.entity(), sortDescriptors: [NSSortDescriptor(key: "number", ascending: true)]) var types: FetchedResults<GroupType>
    @Environment(\.managedObjectContext) var viewContext
    
    // @ObservedObject var noteList: Note
    
    var body: some View {
        List {
            ForEach(notes, id: \.self) { note in
                
                if note.wrappedNoteName == "" {
                    // if note is just created and doesn't even have a name:
                    HStack {
                        Text("Click to open the note")
                            .foregroundColor(Color.gray)
                            .padding(.horizontal)
                    }
                } else {
                    HStack {
                        Text("\(note.wrappedNoteName)")
                            .font(.system(size: 18))
                            .bold()
                            .foregroundColor(Color.textForeground)
                        Spacer()
                        Spacer()
                        
                        if note.noteIsMarked == true {
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
                            if note.noteIsMarked == false {
                                
                                note.noteIsMarked = true // change the isMarked value to true
                                do {
                                    try self.viewContext.save()
                                } catch {
                                    // MARK: - CHANGE (!!!)
                                    let nsError = error as NSError
                                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                }
                            } else {
                                note.noteIsMarked = false // change the isMarked value to false
                                do {
                                    try self.viewContext.save()
                                } catch {
                                    let nsError = error as NSError
                                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                }
                            }
                        }, label: {
                            // MARK: - ADD LABEL HERE
                            if note.noteIsMarked == true {
                                Label("Mark the note", systemImage: "bookmark.fill")
                                    .foregroundColor(.red)
                            } else {
                                Label("Mark the note", systemImage: "bookmark")
                                    .foregroundColor(.gray)
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
