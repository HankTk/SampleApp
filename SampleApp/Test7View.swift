//
//  Test7View.swift
//  SamplesApp
//
//  Created by Hidenori Takaku on 12/27/24.
//

import SwiftUI

struct ZipCode: Codable {
    var message: String?
    var results: [Result]
    var status: Int
}

struct Result: Codable {
    var address1: String
    var address2: String
    var address3: String
    var kana1: String
    var kana2: String
    var kana3: String
    var prefcode: String
    var zipcode: String
}

struct Test7View: View, Previewable {

    @State private var zipCode = ""
    @State private var results = [Result]()
    @State private var errorMessage = ""
    
    var body: some View {
        VStack {
            TextField("郵便番号を入力してください", text: $zipCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                if validate(zipCode: zipCode) {
                    fetchResults()
                }
            }) {
                Text("Search")
            }
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            List(results, id: \.zipcode) { result in
                VStack(alignment: .leading) {
                    Text("郵便番号: \(result.zipcode + result.prefcode)")
                    Text("都道府県コード: \(result.prefcode)")
                    Text("住所カナ: \(result.kana1 + result.kana2 + result.kana3)")
                    Text("住所: \(result.address1 + result.address2 + result.address3)")
                }
            }
        }
        .navigationTitle("Test 7: 郵便番号検索")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func validate(zipCode: String) -> Bool {
        let zipCodePattern = "^[0-9]{3}-?[0-9]{4}$"
        let zipCodePredicate = NSPredicate(format: "SELF MATCHES %@", zipCodePattern)
        let isValid = zipCodePredicate.evaluate(with: zipCode)
        if !isValid {
            errorMessage = "郵便番号は-なしで7桁で入力してください!"
        } else {
            errorMessage = ""
        }
        return isValid
    }
    
    func fetchResults() {
        guard let url = URL(string: "https://zipcloud.ibsnet.co.jp/api/search?zipcode=\(zipCode)") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(ZipCode.self, from: data)
                    DispatchQueue.main.async {
                        self.results = decodedData.results
                    }
                } catch {
                    print("Failed to decode JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }

}

#Preview {
    Test7View.previewContent()
}

