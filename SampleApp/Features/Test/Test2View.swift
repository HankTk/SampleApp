//
//  Test2View.swift
//  SamplesApp
//
//  Created by Hidenori Takaku on 12/27/24.
//

import SwiftUI

#Preview {Test2View()}
struct Test2View: View, Previewable {

    @State private var randomNumber = 1
    @State private var timer: Timer?
    @State private var isRolling = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                Image(systemName: "die.face.\(randomNumber)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width/2)
                    .padding()
                Spacer()
                Button {
                    playDice()
                } label: {
                    Text("サイコロを振る")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .disabled(isRolling)
                Spacer()
            }
            .padding()
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .navigationTitle("Test 2: サイコロ")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func playDice() {
        print("ボタンが押されたよ")
        isRolling = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            randomNumber = Int.random(in: 1...6)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            timer?.invalidate()
            timer = nil
            isRolling = false
        }
    }

}
