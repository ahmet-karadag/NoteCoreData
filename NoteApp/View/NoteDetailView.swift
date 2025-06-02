//
//  NoteDetailView.swift
//  NoteApp
//
//  Created by ahmet karadağ on 2.06.2025.
//

import SwiftUI

struct NoteDetailView: View {
    @ObservedObject var note: Note
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss//bu view kapatmak için
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Form{
            Section(header: Text("Title")){
                TextField("Enter Note Title", text: Binding(get: {
                    note.title ?? ""
                }, set: {note.title = $0}))
            }
            Section{
                if let date = note.date {
                    Text("created at: \(date.formatted(date: .long, time: .shortened))")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Note Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("save"){
                    do{
                        try context.save()
                        presentationMode.wrappedValue.dismiss()
                    }catch{
                        print("❌ Failed to save: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

/*
#Preview {
    NoteDetailView()
}*/
