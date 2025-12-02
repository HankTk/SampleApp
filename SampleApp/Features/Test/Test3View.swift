//
//  Test3View.swift
//  SamplesApp
//
//  Created by Hidenori Takaku on 12/27/24.
//

import SwiftUI

#Preview {Test3View()}
struct Test3View: View, Previewable {

    @State private var num1 = "0"
    @State private var num2 = "0"
    @State private var arrayOfMessage = Array(1...60).map { "\($0)" }
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            HStack(spacing: 20) {
                Text(num1)
                    .font(.system(size: 24))
                    .frame(width: 60, height: 60)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                Text(num2)
                    .font(.system(size: 24))
                    .frame(width: 60, height: 60)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            
            Button(action: {
                btnAction()
            }) {
                Text("Click Me!")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Test 3: ランダム数字選択")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func btnAction() {
        var workingArray = arrayOfMessage
        
        var randomNumber = Int.random(in: 0...(workingArray.count - 1))
        num1 = workingArray[randomNumber]
        workingArray.remove(at: randomNumber)
        
        randomNumber = Int.random(in: 0...(workingArray.count - 1))
        num2 = workingArray[randomNumber]
    }

}
