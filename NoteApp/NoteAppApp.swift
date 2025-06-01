//
//  NoteAppApp.swift
//  NoteApp
//
//  Created by ahmet karadağ on 1.06.2025.
//

import SwiftUI

@main
struct NoteAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(context: persistenceController.container.viewContext)
        }
    }
}
