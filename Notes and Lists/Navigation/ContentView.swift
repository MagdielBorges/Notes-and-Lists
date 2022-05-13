//
//  ContentView.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 4/28/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        if horizontalSizeClass == .regular {
            NavigationView {
                SidebarView()
                NoteListView()
                Text("Select Something from the menu.")
                    .foregroundColor(.secondary)
            }
        } else {
            TabsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
