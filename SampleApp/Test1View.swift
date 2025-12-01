//
//  Test1View.swift
//  SamplesApp
//
//  Created by Hidenori Takaku on 12/27/24.
//

import SwiftUI

struct Test1View: View, Previewable {

    var body: some View {
        VStack {
            Spacer()
            Text("Hello, World!")
                .font(.largeTitle)
            Spacer()
        }
        .navigationTitle("Test 1")
        .navigationBarTitleDisplayMode(.inline)
    }

}

#Preview {
    Test1View()
}

