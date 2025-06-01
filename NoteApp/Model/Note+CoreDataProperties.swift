//
//  Note+CoreDataProperties.swift
//  NoteApp
//
//  Created by ahmet karadağ on 2.06.2025.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?

}

extension Note : Identifiable {

}
