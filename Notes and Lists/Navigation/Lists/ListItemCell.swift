//
//  ListItemCell.swift
//  Notes and Lists
//
//  Created by Magdiel Borges on 4/30/22.
//

import SwiftUI

struct ListItemCell: View {
    @EnvironmentObject var store: StorageProvider
    @ObservedObject var item: ToDoItem
    @State private var showingDetailSheet = false
    @FocusState var focusState
    var body: some View {
        HStack(alignment: .top){
            Image(systemName: item.isCompleted ? "circle.inset.filled" : "circle")
                .foregroundColor(.accentColor)
                .imageScale(.large)
                .padding(.top)
                .padding(.trailing)
                .onTapGesture {
                    withAnimation {
                        item.isCompleted.toggle()
                        store.save()
                    }
                }
            VStack(alignment: .leading) {
                ZStack(alignment: .leading) {
                    TextEditor(text: $item.text)
                        .focused($focusState)
                        .foregroundColor(item.isCompleted ? .secondary : .primary)
                    Text(item.text.isEmpty ? "New Task" : item.text)
                        .foregroundColor(item.text.isEmpty ? .secondary : .clear)
                        .onTapGesture {
                            focusState = true
                        }
                }
                Text(item.detail)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                HStack {
                    Spacer()
                    Text(item.creationDate, format: .dateTime)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button("Delete", role: .destructive){
                withAnimation {
                    store.delete(item)
                }
            }
                .tint(.red)
            Button(action: {
                showingDetailSheet = true
            }){
                Image(systemName: "info.circle")
            }
            .tint(.cyan)
        }
        .sheet(isPresented: $showingDetailSheet) {
            ItemDetailView(item: item)
        }
    }
}

struct ListItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ListItemCell(item: ToDoItem.preview)
    }
}
