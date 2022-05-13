//
//  TabsView.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 5/1/22.
//

import SwiftUI

struct TabsView: View {
    var body: some View {
        TabView {
            NavigationView{
                NoteListView()
            }
                .tabItem {
                    Label("Notes", systemImage: "note")
                }
            NavigationView {
                AllListsView()
            }
                .tabItem {
                    Label("Lists", systemImage: "list.bullet")
                }
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
