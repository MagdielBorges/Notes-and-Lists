//
//  Note - Core Data Extensions.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 4/28/22.
//

import Foundation

extension Note {
    var title: String {
        get { title_ ?? "" }
        set { title_ = newValue }
    }
    var text: String {
        get { text_ ?? "" }
        set { text_ = newValue }
    }
    var creationDate: Date {
        get { creationDate_ ?? Date() }
        set { creationDate_ = newValue }
    }
    
    static var preview: Note {
        let context = StorageProvider().persistentContainer.viewContext
        let note = Note(context: context)
        note.creationDate = Date()
        note.isPinned = false
        note.folder = nil
        note.text = "A preview note"
        note.title = "A preview note"
        return note
    }
}
