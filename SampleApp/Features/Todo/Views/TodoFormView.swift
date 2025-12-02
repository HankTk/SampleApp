import SwiftUI

struct TodoFormView: View {
    let title: String
    @Binding var todoTitle: String
    @Binding var todoDescription: String
    @Binding var todoDueDate: Date?
    let onCancel: () -> Void
    let onSave: () -> Void
    @State private var scrollToDescription = false
    @FocusState private var focusedField: Field?
    
    enum Field {
        case title, description
    }
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                Form {
                    Section(header: Text("Title")) {
                        TextField("Title", text: $todoTitle)
                            .id("title")
                            .focused($focusedField, equals: .title)
                            .onChange(of: focusedField) { newValue in
                                if newValue == .description {
                                    withAnimation {
                                        scrollToDescription = true
                                    }
                                }
                            }
                    }
                    
                    Section(header: Text("Description")) {
                        TextEditor(text: $todoDescription)
                            .frame(height: 100)
                            .id("description")
                            .focused($focusedField, equals: .description)
                    }
                    
                    Section(header: Text("Due Date")) {
                        DatePicker("Due Date", selection: Binding(
                            get: { todoDueDate ?? Date() },
                            set: { todoDueDate = $0 }
                        ), displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.graphical)
                        
                        Button("Clear Due Date") {
                            todoDueDate = nil
                        }
                        .foregroundColor(.red)
                    }
                }
                .onChange(of: scrollToDescription) { newValue in
                    if newValue {
                        withAnimation {
                            proxy.scrollTo("description", anchor: .top)
                        }
                        scrollToDescription = false
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarItems(
                leading: Button("Cancel", action: onCancel),
                trailing: Button("Save", action: onSave)
                    .disabled(todoTitle.isEmpty)
            )
        }
    }
}
