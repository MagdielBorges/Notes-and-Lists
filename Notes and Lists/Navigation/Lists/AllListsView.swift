//
//  AllListsView.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 4/28/22.
//

import SwiftUI

struct AllListsView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ToDoList.creationDate_, ascending: true)], predicate: NSPredicate(format: "isPinned == NO"), animation: .default) var lists: FetchedResults<ToDoList>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ToDoList.creationDate_, ascending: true)], predicate: NSPredicate(format: "isPinned == YES"), animation: .default) var pinnedLists: FetchedResults<ToDoList>
    @EnvironmentObject var store: StorageProvider
    @State private var showingCreateListView = false
    var body: some View {
        List {
            if !pinnedLists.isEmpty {
                Section("Pinned") {
                    ForEach(pinnedLists) { list in
                        AllListsCell(list: list)
                    }
                }
            }
            if lists.isEmpty {
                Text("Create a list with the + button.")
                    .foregroundColor(.secondary)
            }
            Section {
                ForEach(lists) { list in
                    AllListsCell(list: list)
                }
            }
        }
        .navigationTitle("All Lists")
        .toolbar {
            Button(action: {
                showingCreateListView = true
            }){
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showingCreateListView) {
            CreateListView()
        }
    }
}

struct AllListsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AllListsView()
        }
    }
}
