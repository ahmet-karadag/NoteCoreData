//
//  ContentView.swift
//  NoteApp
//
//  Created by ahmet karadağ on 1.06.2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel: NoteViewModel
    
    @State private var isShowAddNote: Bool = false
    @State private var newNoteTitle: String = ""
    
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: NoteViewModel(context: context))
    }

    var body: some View {
       NavigationStack {
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note)
                        .onDisappear {
                            viewModel.fetchNotes()  // Detay ekranı kapandığında liste yenilensin
                        }
                    ) {
                        VStack(alignment: .leading) {
                            Text(note.title ?? "No title")
                                .font(.headline)
                            if let date = note.date {
                                Text(date, style: .date)
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowAddNote = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .alert("New Title", isPresented: $isShowAddNote) {
                        TextField("Note Title", text: $newNoteTitle)
                        Button("Add") {
                            viewModel.addNote(title: newNoteTitle)
                            newNoteTitle = ""
                        }
                        Button("Cancel", role: .cancel) {
                            newNoteTitle = ""
                        }
                    } message: {
                        Text("Enter a title for your new note.")
                    }
                }
            }
            .onAppear {
                viewModel.fetchNotes()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        ContentView(context: context)
    }
}
