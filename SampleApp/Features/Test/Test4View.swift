//
//  Test4View.swift
//  SamplesApp
//
//  Created by Hidenori Takaku on 12/27/24.
//

import SwiftUI

#Preview {Test4View()}
struct Test4View: View, Previewable {

    var body: some View {
        ScrollView {
            VStack {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: 350, height: 100)
                Rectangle()
                    .foregroundColor(.purple)
                    .frame(width: 350, height: 100)
                HStack {
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(width: 150, height: 150)
                    Rectangle()
                        .foregroundColor(.red)
                        .frame(width: 100, height: 100)
                    Rectangle()
                        .foregroundColor(.yellow)
                        .frame(width: 50, height: 50)
                }
                ZStack {
                    Rectangle()
                        .foregroundColor(.green)
                        .frame(width: 350, height: 200)
                    HStack {
                        VStack {
                            Rectangle()
                                .foregroundColor(.pink)
                                .frame(width: 150, height: 70)
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(width: 150, height: 70)
                        }
                        VStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: 150, height: 70)
                            Rectangle()
                                .foregroundColor(.yellow)
                                .frame(width: 150, height: 70)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Test 4: 図形レイアウト")
        .navigationBarTitleDisplayMode(.inline)
    }

}
