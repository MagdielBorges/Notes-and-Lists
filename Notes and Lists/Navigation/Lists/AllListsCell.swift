//
//  AllListsCell.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 4/30/22.
//

import SwiftUI

struct AllListsCell: View {
    @EnvironmentObject var store: StorageProvider
    @ObservedObject var list: ToDoList
    @State private var showingDetailSheet = false
    @State private var showingDeleteAlert = false
    var body: some View {
        NavigationLink {
            ListView(list: list)
        } label: {
            VStack(alignment: .leading) {
                Text(list.name)
                Text(list.detail)
                    .lineLimit(2)
                    .foregroundColor(.secondary)
                    .font(.footnote)
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button("Edit Details") {
                showingDetailSheet = true
            }
            .tint(.cyan)
            
            Button("Delete", role: .destructive) {
                showingDeleteAlert = true
            }
            .tint(.red)
        }
        .alert("Delete List?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                store.delete(list)
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

struct AllListsCell_Previews: PreviewProvider {
    static var previews: some View {
        AllListsCell(list: ToDoList.preview)
    }
}
