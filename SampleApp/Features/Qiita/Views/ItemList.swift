//
//  ItemList.swift
//  SampleApp
//
//

import SwiftUI

#Preview {ItemList()}
struct ItemList: View, Previewable {
    @ObservedObject var fetcher = ApiFetcher()
    @State var keyword: String = ""
    @State var showingDetail = false
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search", text: $keyword) {
                    self.fetcher.fetchItems(query: self.keyword)
                }
                .padding(16)
                .textFieldStyle(.roundedBorder)               
                
                List(fetcher.items) { item in
                    NavigationLink(
                        destination: ItemDetail(
                            title: item.title,
                            url: item.url
                        )
                    ) {
                        ItemRow(item: item)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
            }
            .navigationBarTitle(Text("Qiita 検索"))
        }
    }
}
