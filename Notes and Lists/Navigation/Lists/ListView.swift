//
//  ListView.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 4/28/22.
//

import SwiftUI

struct ListView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: StorageProvider
    @ObservedObject var list: ToDoList
    @State private var showingDetailSheet = false
    @State private var showingDeleteAlert = false
    @State private var text = ""
    var body: some View {
        List {
            ForEach(list.itemsOrderedByCreationDate) { item in
                ListItemCell(item: item)
            }
            HStack {
                TextField("New Task", text: $text)
                    .onSubmit {
                        guard !text.isEmpty else { return }
                        withAnimation {
                            store.createItem(in: list, with: text)
                        }
                        text = ""
                    }
                Image(systemName: "plus")
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        guard !text.isEmpty else { return }
                        withAnimation {
                            store.createItem(in: list, with: text)
                        }
                        text = ""
                    }
            }
        }
        .listStyle(.plain)
        .navigationTitle(list.name.isEmpty ? "Untitled List" : list.name)
        .toolbar {
            Menu {
                Button(action: {
                    withAnimation {
                        store.createItem(in: list)
                    }
                }){
                    Label("New Task", systemImage: "plus")
                }
                Button("Edit List Details") {
                    showingDetailSheet = true
                }
                Button("Delete List", role: .destructive) {
                    showingDeleteAlert = true
                }
            } label: {
                Image(systemName: "line.3.horizontal")
            }
        }
        .alert("Delete List?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                withAnimation {
                    store.delete(list)
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to delete this list? This cannot be undone.")
        }
        .sheet(isPresented: $showingDetailSheet) {
            ListDetailView(list: list)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                ListView(list: ToDoList.preview)
            }
            NavigationView {
                ListView(list: ToDoList.preview)
                    .preferredColorScheme(.dark)
            }
        }
    }
}
