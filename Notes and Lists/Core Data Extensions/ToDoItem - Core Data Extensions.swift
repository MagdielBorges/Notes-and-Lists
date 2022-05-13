//
//  ToDoItem - Core Data Extensions.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 4/28/22.
//

import Foundation

extension ToDoItem {
    var text: String {
        get { text_ ?? "" }
        set { text_ = newValue }
    }
    var detail: String {
        get { detail_ ?? "" }
        set { detail_ = newValue }
    }
    var creationDate: Date {
        get { creationDate_ ?? Date() }
        set { creationDate_ = newValue }
    }
    
    static var preview: ToDoItem {
        let context = StorageProvider().persistentContainer.viewContext
        let item = ToDoItem(context: context)
        item.text = ""
        item.list = nil
        item.creationDate = Date()
        item.detail = ""
        item.isCompleted = false
        return item
    }
}
