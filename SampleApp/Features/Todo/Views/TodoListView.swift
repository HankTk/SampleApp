import SwiftUI

struct TodoListView: View {
    let todos: [TodoItem]
    let viewModel: TodoViewModel
    @Binding var editingTodo: TodoItem?
    @Binding var editingTitle: String
    @Binding var editingDescription: String
    @Binding var editingDueDate: Date?
    @Binding var showingEditSheet: Bool
    @Binding var todoToDelete: TodoItem?
    @Binding var showingDeleteConfirmation: Bool
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        Group {
            if todos.isEmpty {
                VStack {
                    Spacer()
                    Text("No todos")
                        .font(.title2)
                        .foregroundColor(.gray)
                    Spacer()
                }
            } else {
                List {
                    ForEach(todos) { todo in
                        TodoRowView(
                            todo: todo,
                            viewModel: viewModel,
                            editingTodo: $editingTodo,
                            editingTitle: $editingTitle,
                            editingDescription: $editingDescription,
                            editingDueDate: $editingDueDate,
                            showingEditSheet: $showingEditSheet
                        )
                    }
                    .onMove { from, to in
                        viewModel.moveTodo(from: from, to: to, in: todos)
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            viewModel.deleteTodo(todos[index])
                        }
                    }
                }
                .environment(\.editMode, .constant(editMode?.wrappedValue ?? .inactive))
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    editMode?.wrappedValue = editMode?.wrappedValue == .active ? .inactive : .active
                }) {
                    Text(editMode?.wrappedValue == .active ? "Done" : "Edit")
                }
            }
        }
    }
}

struct TodoRowView: View {
    let todo: TodoItem
    let viewModel: TodoViewModel
    @Binding var editingTodo: TodoItem?
    @Binding var editingTitle: String
    @Binding var editingDescription: String
    @Binding var editingDueDate: Date?
    @Binding var showingEditSheet: Bool
    
    private var isOverdue: Bool {
        guard let dueDate = todo.dueDate, !todo.isCompleted else { return false }
        return dueDate < Date()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(todo.isCompleted ? .green : .gray)
                
                VStack(alignment: .leading) {
                    Text(todo.title)
                        .strikethrough(todo.isCompleted)
                        .font(.headline)
                    
                    if !todo.description.isEmpty {
                        Text(todo.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    if let dueDate = todo.dueDate {
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(isOverdue ? .red : .blue)
                            Text(dueDate.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption2)
                                .foregroundColor(isOverdue ? .red : .blue)
                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    editingTodo = todo
                    editingTitle = todo.title
                    editingDescription = todo.description
                    editingDueDate = todo.dueDate
                    showingEditSheet = true
                }) {
                    Text("Details")
                        .foregroundColor(.blue)
                        .font(.caption)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.toggleTodo(todo)
        }
        .listRowBackground(isOverdue ? Color.red.opacity(0.1) : Color(white: 0.92))
    }
}
