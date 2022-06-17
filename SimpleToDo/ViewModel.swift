//
//  ViewModel.swift
//  SimpleToDo
//
//  Created by Jacek on 17/06/2022.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var items: [ToDoItem] {
        didSet {
            save()
        }
    }

    private let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedItems")

    init() {
        do {
            let data = try Data(contentsOf: savePath)
            items = try JSONDecoder().decode([ToDoItem].self, from: data)
        } catch {
            items = []
        }
    }

    func save() {
        print("Saving!")
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }

func add() {
    let newItem = ToDoItem()
    items.append(newItem)
}

func delete(_ offsets: IndexSet) {
    items.remove(atOffsets: offsets)
}

func delete(_ selected: Set<ToDoItem>) {
    items.removeAll(where: selected.contains)
}
}
