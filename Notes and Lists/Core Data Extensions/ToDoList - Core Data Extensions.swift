//
//  ToDoList - Core Data Extensions.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 4/28/22.
//

import Foundation

extension ToDoList {
    var name: String {
        get { name_ ?? "" }
        set { name_ = newValue }
    }
    var detail: String {
        get { detail_ ?? "" }
        set { detail_ = newValue }
    }
    var creationDate: Date {
        get { creationDate_ ?? Date() }
        set { creationDate_ = newValue }
    }
    var items: Set<ToDoItem> {
        get { items_ as? Set<ToDoItem> ?? [] }
        set { items_ = newValue as NSSet }
    }
    var itemsOrderedByCreationDate: [ToDoItem] {
        items.sorted { first, second in
            first.creationDate < second.creationDate
        }
    }
    
    static var preview: ToDoList {
        let context = StorageProvider().persistentContainer.viewContext
        let list = ToDoList(context: context)
        list.name = ""
        list.creationDate = Date()
        list.detail = ""
        list.isPinned = false
        list.items = []
        return list
    }
}
