//
//  Creating Entities.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 4/29/22.
//

import Foundation

extension StorageProvider {
    //MARK: - Creating a Note
    func createNote() {
        let note = Note(context: persistentContainer.viewContext)
        note.creationDate = Date()
        note.text = ""
        note.title = ""
        note.folder = nil
        note.isPinned = false
        save()
    }
    func createNote(in folder: Folder) {
        let note = Note(context: persistentContainer.viewContext)
        note.creationDate = Date()
        note.text = ""
        note.title = ""
        note.folder = folder
        note.isPinned = false
        save()
    }
    //MARK: - Creating a Folder
    func createFolder(name: String) {
        let folder = Folder(context: persistentContainer.viewContext)
        folder.creationDate = Date()
        folder.name = name
        folder.isFavorited = false
        folder.notes = []
        save()
    }
    //MARK: - Creating a List
    func createList(name: String, detail: String) {
        let list = ToDoList(context: persistentContainer.viewContext)
        list.creationDate = Date()
        list.name = name
        list.detail = detail
        list.isPinned = false
        list.items = []
        save()
    }
    //MARK: - Creating a List Item
    func createItem(in list: ToDoList) {
        let item = ToDoItem(context: persistentContainer.viewContext)
        item.text = ""
        item.detail = ""
        item.creationDate = Date()
        item.isCompleted = false
        item.list = list
        save()
    }
    
    func createItem(in list: ToDoList, with text: String) {
        let item = ToDoItem(context: persistentContainer.viewContext)
        item.text = text
        item.detail = ""
        item.creationDate = Date()
        item.isCompleted = false
        item.list = list
        save()
    }
}
