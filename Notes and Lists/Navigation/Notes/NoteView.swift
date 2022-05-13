//
//  NoteView.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 4/28/22.
//

import SwiftUI

struct NoteView: View {
    @EnvironmentObject var store: StorageProvider
    @Environment(\.dismiss) var dismiss
    @FocusState var focusState
    @ObservedObject var note: Note
    @State private var showingDeleteAlert = false
    var body: some View {
        VStack {
            ScrollView {
                TextField("Note Title", text: $note.title)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                ZStack(alignment: .leading){
                    TextEditor(text: $note.text)
                        .focused($focusState)
                    Text("Write something here...")
                        .padding(8)
                        .foregroundColor(note.text.isEmpty ? .secondary : .clear)
                        .onTapGesture {
                            focusState = true
                        }
                }
                Spacer()
                
            }
            Text("Created on: \(note.creationDate, format: .dateTime)")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .navigationTitle("Note View")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button("Delete", role: .destructive){
                    showingDeleteAlert = true
                }
            }
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button("Done") {
                        focusState = false
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Note?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                store.delete(note)
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NoteView(note: Note.preview)
                .previewDevice("iPhone 13 Pro Max")
            NoteView(note: Note.preview)
                .preferredColorScheme(.dark)
                .previewDevice("iPhone 13 Pro Max")
        }
    }
}
