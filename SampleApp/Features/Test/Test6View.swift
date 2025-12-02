//
//  Test6View.swift
//  SamplesApp
//
//  Created by Hidenori Takaku on 12/27/24.
//

import PhotosUI
import SwiftUI

#Preview {Test6View()}
struct Test6View: View, Previewable {

    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    var body: some View {
        VStack {
            PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
                .padding()
            
            selectedImage?
                .resizable()
                .scaledToFit()
        }
        .onChange(of: pickerItem) { Task {
            selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
        }
        }
        .navigationTitle("Test 6: 画像ピッカー")
        .navigationBarTitleDisplayMode(.inline)
    }

}
