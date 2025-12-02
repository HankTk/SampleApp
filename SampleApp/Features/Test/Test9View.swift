//
//  Test9View.swift
//  SamplesApp
//
//  Created by Hidenori Takaku on 12/27/24.
//

import SwiftUI
import AVKit

#Preview {Test9View()}
struct Test9View: View, Previewable {

    private let player: AVPlayer
    @State var isPlaying: Bool = false

    init() {
        if let url = Bundle.main.url(forResource: "Sample", withExtension: "mp4") {
            player = AVPlayer(url: url)
        } else {
            player = AVPlayer(url: URL(fileURLWithPath: ""))
            print("file does not found")
        }
    }
    
    var body: some View {
        VStack {
           VideoPlayer(player: player)
           Button {
               isPlaying ? player.pause() : player.play()
               isPlaying.toggle()
               player.seek(to: .zero)
           } label: {
               Image(systemName: isPlaying ? "stop" : "play")
                   .padding()
           }
        }
        .onDisappear(perform: {
            player.pause()
        })
        .navigationTitle("Test 9: 動画プレーヤー")
        .navigationBarTitleDisplayMode(.inline)
    }

}
