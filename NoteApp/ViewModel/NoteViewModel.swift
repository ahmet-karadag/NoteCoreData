//
//  NoteViewModel.swift
//  NoteApp
//
//  Created by ahmet karadağ on 1.06.2025.
//

import Foundation
import CoreData

class NoteViewModel: ObservableObject {
    @Published var notes: [Note] = []
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
            self.context = context
            fetchNotes()
            
            NotificationCenter.default.addObserver(forName: .NSManagedObjectContextObjectsDidChange, object: context, queue: .main) { [weak self] _ in
                self?.fetchNotes()
            }
        }
    func fetchNotes() {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Note.date, ascending: true)]
        
        do{
            notes = try context.fetch(request)
        }catch{
            print("❌ Failed to fetch notes: \(error.localizedDescription)")
        }
    }
    
    func addNote(title: String){
        let newNote = Note(context: context)
        newNote.id = UUID()
        newNote.title = title
        newNote.date = Date()
        
        saveChanges()
        fetchNotes()
    }
    private func saveChanges(){
        do{
            try context.save()
        }catch {
            print("❌ Failed to save changes: \(error.localizedDescription)")
        }
    }
    func deleteNote(at offsets: IndexSet){
        offsets.forEach { index in
            let note = notes[index]
            context.delete(note)
        }
        saveChanges()
        fetchNotes()
    }
}
