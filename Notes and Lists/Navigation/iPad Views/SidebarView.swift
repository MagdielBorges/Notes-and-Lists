//
//  SidebarView.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 5/1/22.
//

import SwiftUI

struct SidebarView: View {
    var body: some View {
        List {
            NavigationLink {
                NoteListView()
            } label: {
                Label("Notes", systemImage: "note.text")
            }
            NavigationLink {
                AllListsView()
            } label: {
                Label("Lists", systemImage: "list.bullet")
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("Menu")
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
