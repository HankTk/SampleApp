//
//  ItemDetail.swift
//  SampleApp
//
//

import SwiftUI
import WebKit

struct ItemDetail: View {
    let title: String
    let url: String

    var body: some View {
        WebView(url: URL(string: url)!)
        .navigationBarTitle(Text(title), displayMode: .inline)
    }
}

struct WebView : UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView(frame: .zero)
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let req = URLRequest(url: url)
        uiView.load(req)
    }
}

#Preview {
    ItemDetail(title: "テスト", url: "https://www.apple.com")
}
