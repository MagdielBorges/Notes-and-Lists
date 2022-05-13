//
//  ListDetailView.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 5/2/22.
//

import SwiftUI

struct ListDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: StorageProvider
    @ObservedObject var list: ToDoList
    @State private var showingDeleteAlert = false
    var body: some View {
        NavigationView {
            Form {
                TextField("List Name", text: $list.name)
                Section("Details") {
                    TextEditor(text: $list.detail)
                }
                Button("Delete List", role: .destructive) {
                    showingDeleteAlert = true
                }
            }
            .navigationTitle("List Details")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Delete List?", isPresented: $showingDeleteAlert) {
                Button("Delete", role: .destructive) {
                    store.delete(list)
                    dismiss()
                }
                Button("Cancel", role: .cancel) {}
            }  message: {
                Text("Are you sure you want to delete this list? This cannot be undone.")
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        store.save()
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ListDetailView(list: ToDoList.preview)
    }
}
