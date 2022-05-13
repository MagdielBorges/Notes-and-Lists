//
//  NoteListCell.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 4/30/22.
//

import SwiftUI

struct NoteListCell: View {
    @EnvironmentObject var store: StorageProvider
    @ObservedObject var note: Note
    @State private var isShowingDeleteAlert = false
    var body: some View {
        NavigationLink {
            NoteView(note: note)
        } label: {
            VStack(alignment: .leading) {
                if note.title.isEmpty {
                    Text("Untitled Note")
                        .foregroundColor(.secondary)
                } else {
                    Text(note.title)
                }
                Text(note.text)
                    .foregroundColor(.secondary)
                    .font(.footnote)
                    .lineLimit(2)
                HStack {
                    Spacer()
                    Text(note.creationDate, format: .dateTime)
                        .foregroundColor(.secondary)
                        .font(.footnote)
                }
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: false) {
            Button(action: {
                note.isPinned.toggle()
                store.save()
            }){
                Image(systemName: note.isPinned ? "pin.slash" : "pin")
            }
            .tint(.cyan)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button("Delete"){
                isShowingDeleteAlert = true
            }
            .tint(.red)
        }
        .alert("Delete Note?", isPresented: $isShowingDeleteAlert) {
            Button("Delete", role: .destructive) {
                store.delete(note)
            }
            Button("Cancel", role: .cancel){}
        }
    }
}

struct NoteListCell_Previews: PreviewProvider {
    static var previews: some View {
        NoteListCell(note: Note.preview)
    }
}
