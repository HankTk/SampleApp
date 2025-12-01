//
//  MainView.swift
//  SamplesApp
//
//  Created by Hidenori Takaku on 12/27/24.
//

import SwiftUI

#Preview {MainView()}
struct MainView: View, Previewable {
    
    static var previewWrappedInNavigation: Bool {
        false
    }
    
    private struct TestItem: Identifiable {
        let id: Int
        let title: String
        let destination: AnyView
        
        init<V: View>(id: Int, title: String, destination: V) {
            self.id = id
            self.title = title
            self.destination = AnyView(destination)
        }
    }
    
    private let testItems: [TestItem] = [
        TestItem(id: 1, title: "Test 1: Hello World", destination: Test1View()),
        TestItem(id: 2, title: "Test 2: サイコロ", destination: Test2View()),
        TestItem(id: 3, title: "Test 3: ランダム数字選択", destination: Test3View()),
        TestItem(id: 4, title: "Test 4: 図形レイアウト", destination: Test4View()),
        TestItem(id: 5, title: "Test 5: 地図表示", destination: Test5View()),
        TestItem(id: 6, title: "Test 6: 画像ピッカー", destination: Test6View()),
        TestItem(id: 7, title: "Test 7: 郵便番号検索", destination: Test7View()),
        TestItem(id: 8, title: "Test 8: UIコンポーネント", destination: Test8View()),
        TestItem(id: 9, title: "Test 9: 動画プレーヤー", destination: Test9View())
    ]

    var body: some View {
        NavigationStack {
            List {
                Section {
                    viewLinks()
                }
                .listRowBackground(Color.white)
                .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            }
            .navigationTitle("Samples App")
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .background(Color.black.ignoresSafeArea(.all))
        .ignoresSafeArea(.all)
    }
    
    @ViewBuilder
    private func viewLinks() -> some View {
        ForEach(testItems) { item in
            NavigationLink(item.title, destination: item.destination)
                .frame(minHeight: 50)
        }
    }

}
