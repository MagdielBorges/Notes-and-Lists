//
//  ItemDetailView.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 4/30/22.
//

import SwiftUI

struct ItemDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: StorageProvider
    @ObservedObject var item: ToDoItem
    @State private var showingDeleteAlert = false
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextEditor(text: $item.text)
                }
                Section("Details") {
                    TextEditor(text: $item.detail)
                }
                Toggle(isOn: $item.isCompleted) {
                    Text("Mark as Completed")
                }
                Section {
                    Button("Delete Task", role: .destructive) {
                        showingDeleteAlert = true
                    }
                }
            }
            .navigationTitle("Edit Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
            .alert("Delete Task?", isPresented: $showingDeleteAlert) {
                Button("Delete", role: .destructive) {
                    store.delete(item)
                    dismiss()
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(item: ToDoItem.preview)
    }
}
