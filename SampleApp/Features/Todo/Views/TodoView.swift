import SwiftUI

struct TodoView: View, Previewable {
    @StateObject private var viewModel = TodoViewModel()
    @State private var newTodoTitle = ""
    @State private var newTodoDescription = ""
    @State private var newTodoDueDate: Date?
    @State private var editingTodo: TodoItem?
    @State private var editingTitle = ""
    @State private var editingDescription = ""
    @State private var editingDueDate: Date?
    @State private var showingAddSheet = false
    @State private var showingEditSheet = false
    @State private var showingDeleteConfirmation = false
    @State private var todoToDelete: TodoItem?
    @State private var selectedTab = 0
    
    static var previewWrappedInNavigation: Bool {
        false
    }
    
    init() {
        // Previewable protocol requirement
    }
    
    var activeTodos: [TodoItem] {
        viewModel.todoItems.filter { !$0.isCompleted }
    }
    
    var completedTodos: [TodoItem] {
        viewModel.todoItems.filter { $0.isCompleted }
    }
    
    var overdueTodos: [TodoItem] {
        let now = Date()
        return viewModel.todoItems.filter { todo in
            if let dueDate = todo.dueDate {
                return !todo.isCompleted && dueDate < now
            }
            return false
        }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                TodoListView(
                    todos: activeTodos,
                    viewModel: viewModel,
                    editingTodo: $editingTodo,
                    editingTitle: $editingTitle,
                    editingDescription: $editingDescription,
                    editingDueDate: $editingDueDate,
                    showingEditSheet: $showingEditSheet,
                    todoToDelete: $todoToDelete,
                    showingDeleteConfirmation: $showingDeleteConfirmation
                )
                .navigationTitle("Active TODOs")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showingAddSheet = true }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .tabItem {
                Label("Active", systemImage: "list.bullet")
            }
            .tag(0)
            
            NavigationView {
                TodoListView(
                    todos: completedTodos,
                    viewModel: viewModel,
                    editingTodo: $editingTodo,
                    editingTitle: $editingTitle,
                    editingDescription: $editingDescription,
                    editingDueDate: $editingDueDate,
                    showingEditSheet: $showingEditSheet,
                    todoToDelete: $todoToDelete,
                    showingDeleteConfirmation: $showingDeleteConfirmation
                )
                .navigationTitle("Completed TODOs")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showingAddSheet = true }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .tabItem {
                Label("Completed", systemImage: "checkmark.circle")
            }
            .tag(1)
            
            NavigationView {
                TodoListView(
                    todos: viewModel.todoItems,
                    viewModel: viewModel,
                    editingTodo: $editingTodo,
                    editingTitle: $editingTitle,
                    editingDescription: $editingDescription,
                    editingDueDate: $editingDueDate,
                    showingEditSheet: $showingEditSheet,
                    todoToDelete: $todoToDelete,
                    showingDeleteConfirmation: $showingDeleteConfirmation
                )
                .navigationTitle("All TODOs")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showingAddSheet = true }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .tabItem {
                Label("All", systemImage: "tray.full")
            }
            .tag(2)
            
            NavigationView {
                TodoListView(
                    todos: overdueTodos,
                    viewModel: viewModel,
                    editingTodo: $editingTodo,
                    editingTitle: $editingTitle,
                    editingDescription: $editingDescription,
                    editingDueDate: $editingDueDate,
                    showingEditSheet: $showingEditSheet,
                    todoToDelete: $todoToDelete,
                    showingDeleteConfirmation: $showingDeleteConfirmation
                )
                .navigationTitle("Expired TODOs")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showingAddSheet = true }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .tabItem {
                Label("Expired", systemImage: "exclamationmark.triangle")
            }
            .tag(3)
        }
        .sheet(isPresented: $showingAddSheet) {
            TodoFormView(
                title: "New TODO",
                todoTitle: $newTodoTitle,
                todoDescription: $newTodoDescription,
                todoDueDate: $newTodoDueDate,
                onCancel: {
                    showingAddSheet = false
                    resetNewTodoForm()
                },
                onSave: {
                    viewModel.addTodo(title: newTodoTitle, description: newTodoDescription, dueDate: newTodoDueDate)
                    showingAddSheet = false
                    resetNewTodoForm()
                }
            )
        }
        .sheet(isPresented: $showingEditSheet) {
            TodoFormView(
                title: "Edit TODO",
                todoTitle: $editingTitle,
                todoDescription: $editingDescription,
                todoDueDate: $editingDueDate,
                onCancel: {
                    showingEditSheet = false
                },
                onSave: {
                    if !editingTitle.isEmpty, let todo = editingTodo {
                        viewModel.updateTodo(todo, newTitle: editingTitle, newDescription: editingDescription, newDueDate: editingDueDate)
                        showingEditSheet = false
                    }
                }
            )
        }
    }
    
    private func resetNewTodoForm() {
        newTodoTitle = ""
        newTodoDescription = ""
        newTodoDueDate = nil
    }
}

#Preview {
    TodoView()
}
