//
//  ContentView.swift
//  SimpleToDo
//
//  Created by Jacek on 17/06/2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model: ViewModel
    @State private var selectedItems = Set<ToDoItem>()
    @State var editMode = EditMode.inactive
    
    var body: some View {
        List(selection: $selectedItems) {
            ForEach($model.items) { $item in
                NavigationLink {
                    DetailView(item: $item)
                } label: {
                    Label(item.title, systemImage: item.icon)
                }
                .tag(item)

            }
            .onDelete(perform: model.delete)
        }
        .navigationTitle("SimpleToDo")
       
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading, content: EditButton.init)

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: model.add) {
                    Label("Add Item", systemImage: "plus")
                }
            }
            ToolbarItem(placement: .bottomBar) {
                    if editMode == .active {
                        HStack {
                            Spacer()

                            Button(role: .destructive) {
                                model.delete(selectedItems)
                                selectedItems.removeAll()
                            } label: {
                                Label("Delete selected", systemImage: "trash")
                            }
                            .disabled(selectedItems.isEmpty)
                        }
                    }
                }

        }
        .animation(.default, value: model.items)
        .listStyle(.sidebar)
        .environment(\.editMode, $editMode)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: ViewModel())
    }
}
