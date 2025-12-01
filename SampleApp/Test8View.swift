//
//  Test8View.swift
//  SamplesApp
//
//  Created by Hidenori Takaku on 12/27/24.
//

import SwiftUI

struct Test8View: View, Previewable {

    @State private var selectedColor = Color.red
    @State private var selectedDate = Date()
    @State private var gaugeValue = 0.5
    @State private var selectedDates: Set<DateComponents> = []
    @State private var textEditorText = "Placeholder"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                    .font(.title)
                
                Button("Button") {
                    // Action
                }
                
                ColorPicker("Title", selection: $selectedColor)
                
                DatePicker(selection: $selectedDate, label: { Text("Date") })
                
                EditButton()
                
                Gauge(value: gaugeValue, in: 0...1) {
                    Text("Label")
                }
                
                MultiDatePicker("Label", selection: $selectedDates)
                
                TextEditor(text: $textEditorText)
                    .frame(height: 100)
            }
            .padding()
        }
        .navigationTitle("Test 8: UIコンポーネント")
        .navigationBarTitleDisplayMode(.inline)
    }

}

#Preview {
    Test8View.previewContent()
}

