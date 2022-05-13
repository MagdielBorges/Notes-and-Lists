//
//  Notes_and_ListsApp.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 4/28/22.
//

import SwiftUI

@main
struct Notes_and_ListsApp: App {
    @StateObject var store = StorageProvider()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .environment(\.managedObjectContext, store.persistentContainer.viewContext)
        }
    }
}
