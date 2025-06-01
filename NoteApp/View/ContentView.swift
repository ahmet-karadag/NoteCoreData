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
    
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: NoteViewModel(context: context))
    }

    var body: some View {
       NavigationStack {
            List {
                ForEach(viewModel.notes){ note in
                    VStack(alignment: .leading) {
                        Text(note.title ?? "No title")
                            .font(.headline)
                        if let date = note.date {
                            Text(date, style: .date)
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding(.vertical,5)
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.addNote(title: "New Note")
                    } label: {
                        Image(systemName: "plus")
                    }

                }
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
