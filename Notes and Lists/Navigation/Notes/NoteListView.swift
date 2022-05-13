//
//  NoteListView.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 4/28/22.
//

import SwiftUI

struct NoteListView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Note.creationDate_, ascending: true)], predicate: NSPredicate(format: "isPinned == NO"), animation: .default) var notes: FetchedResults<Note>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Note.creationDate_, ascending: true)], predicate: NSPredicate(format: "isPinned == YES"), animation: .default) var pinnedNotes: FetchedResults<Note>
    @EnvironmentObject var store: StorageProvider
    var body: some View {
        List {
            if pinnedNotes.isEmpty {
                if notes.isEmpty {
                    Text("Use the + button to create a new note.")
                        .foregroundColor(.secondary)
                }
                ForEach(notes) { note in
                    NoteListCell(note: note)
                }
            } else {
                Section("Pinned") {
                    ForEach(pinnedNotes) { note in
                        NoteListCell(note: note)
                    }
                }
                Section("Notes") {
                    if notes.isEmpty {
                        Text("Use the + button to create a new note.")
                            .foregroundColor(.secondary)
                    }
                    ForEach(notes) { note in
                        NoteListCell(note: note)
                    }
                }
            }
        }
        .navigationTitle("Note List View")
        .toolbar {
            Button(action: {
                store.createNote()
            }){
                Image(systemName: "note.text.badge.plus")
            }
        }
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoteListView()
        }
    }
}
