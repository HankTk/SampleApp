//
//  MainView.swift
//  SamplesApp
//
//  Created by Hidenori Takaku on 12/27/24.
//

import SwiftUI

struct MainView: View, Previewable {
    
    static var previewWrappedInNavigation: Bool {
        false
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink("Test 1: Hello World", destination: Test1View())
                    NavigationLink("Test 2: サイコロ", destination: Test2View())
                    NavigationLink("Test 3: ランダム数字選択", destination: Test3View())
                    NavigationLink("Test 4: 図形レイアウト", destination: Test4View())
                    NavigationLink("Test 5: 地図表示", destination: Test5View())
                    NavigationLink("Test 6: 画像ピッカー", destination: Test6View())
                    NavigationLink("Test 7: 郵便番号検索", destination: Test7View())
                    NavigationLink("Test 8: UIコンポーネント", destination: Test8View())
                    NavigationLink("Test 9: 動画プレーヤー", destination: Test9View())
                }
                .listRowBackground(Color.white)
            }
            .navigationTitle("Samples App")
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .background(Color.black.ignoresSafeArea(.all))
        .ignoresSafeArea(.all)
    }

}

#Preview {
    MainView.previewContent()
}
