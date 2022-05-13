//
//  CreateListView.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 5/1/22.
//

import SwiftUI

struct CreateListView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: StorageProvider
    @State private var name = ""
    @State private var detail = ""
    var body: some View {
        NavigationView {
            Form {
                TextField("List Name", text: $name)
                Section("Details") {
                    TextEditor(text: $detail)
                }
            }
            .navigationTitle("Create a List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        guard !name.isEmpty else { return }
                        store.createList(name: name, detail: detail)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct CreateListView_Previews: PreviewProvider {
    static var previews: some View {
        CreateListView()
    }
}
