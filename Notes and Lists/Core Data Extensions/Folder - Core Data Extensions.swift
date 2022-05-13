//
//  Folder - Core Data Extensions.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 4/28/22.
//

import Foundation

extension Folder {
    var name: String {
        get { name_ ?? "" }
        set { name_ = newValue }
    }
    var creationDate: Date {
        get { creationDate_ ?? Date() }
        set { creationDate_ = newValue }
    }
    
    static var preview: Folder {
        let context = StorageProvider().persistentContainer.viewContext
        let folder = Folder(context: context)
        folder.name = ""
        folder.notes = []
        folder.creationDate = Date()
        folder.isFavorited = false
        return folder
    }
}
