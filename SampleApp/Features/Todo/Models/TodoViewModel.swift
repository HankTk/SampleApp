import Foundation
import SwiftUI
import Combine

class TodoViewModel: ObservableObject {
    
    @Published var todoItems: [TodoItem] = [] {
        didSet {
            saveItems()
        }
    }
    
    private let itemsKey = "todoItems"
    
    init() {
        loadItems()
    }
    
    func addTodo(title: String) {
        let newTodo = TodoItem(title: title)
        todoItems.append(newTodo)
    }
    
    func addTodo(title: String, description: String) {
        let newTodo = TodoItem(title: title, description: description)
        todoItems.append(newTodo)
    }
    
    func addTodo(title: String, description: String, dueDate: Date?) {
        let newTodo = TodoItem(title: title, description: description, dueDate: dueDate)
        todoItems.append(newTodo)
    }
    
    func toggleTodo(_ todo: TodoItem) {
        if let index = todoItems.firstIndex(where: { $0.id == todo.id }) {
            todoItems[index].isCompleted.toggle()
        }
    }
    
    func deleteTodo(_ todo: TodoItem) {
        todoItems.removeAll { $0.id == todo.id }
    }
    
    func updateTodo(_ todo: TodoItem, newTitle: String) {
        if let index = todoItems.firstIndex(where: { $0.id == todo.id }) {
            todoItems[index].title = newTitle
        }
    }
    
    func updateTodo(_ todo: TodoItem, newTitle: String, newDescription: String) {
        if let index = todoItems.firstIndex(where: { $0.id == todo.id }) {
            todoItems[index].title = newTitle
            todoItems[index].description = newDescription
        }
    }
    
    func updateTodo(_ todo: TodoItem, newTitle: String, newDescription: String, newDueDate: Date?) {
        if let index = todoItems.firstIndex(where: { $0.id == todo.id }) {
            todoItems[index].title = newTitle
            todoItems[index].description = newDescription
            todoItems[index].dueDate = newDueDate
        }
    }
    
    func moveTodo(from source: IndexSet, to destination: Int, in filteredItems: [TodoItem]) {
        let itemsToMove = source.map { filteredItems[$0] }
        
        let destinationIndex: Int
        if destination >= filteredItems.count {
            destinationIndex = todoItems.count
        } else {
            let destinationItem = filteredItems[destination]
            destinationIndex = todoItems.firstIndex(where: { $0.id == destinationItem.id }) ?? todoItems.count
        }
        
        var updatedItems = todoItems
        for item in itemsToMove {
            if let index = updatedItems.firstIndex(where: { $0.id == item.id }) {
                updatedItems.remove(at: index)
            }
        }
        
        if destinationIndex <= updatedItems.count {
            updatedItems.insert(contentsOf: itemsToMove, at: destinationIndex)
        } else {
            updatedItems.append(contentsOf: itemsToMove)
        }
        
        todoItems = updatedItems
    }
    
    private func saveItems() {
        if let encoded = try? JSONEncoder().encode(todoItems) {
            UserDefaults.standard.set(encoded, forKey: itemsKey)
        }
    }
    
    private func loadItems() {
        if let data = UserDefaults.standard.data(forKey: itemsKey),
           let decoded = try? JSONDecoder().decode([TodoItem].self, from: data) {
            todoItems = decoded
        }
    }
    
}
