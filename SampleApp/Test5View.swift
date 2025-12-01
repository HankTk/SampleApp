//
//  Test5View.swift
//  SamplesApp
//
//  Created by Hidenori Takaku on 12/27/24.
//

import SwiftUI
import MapKit

struct Test5View: View, Previewable {

    @State var showText = false
    @State var showMap = false
    
    var body: some View {
        VStack {
            Spacer()
            if showText {
                Text("🚀 Hello World! 🌎")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                
                if let image = UIImage(named: "Ubie") {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .onTapGesture {
                            showMap.toggle()
                        }
                } else {
                    Image(systemName: "map.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            showMap.toggle()
                        }
                }
                
                Text("Click the logo and see what happens")
                    .font(.headline)
                    .foregroundColor(.gray)
            } else {
                Button(action: {
                    showText.toggle()
                }) {
                    Text("Click and see what happens")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .padding(.top, 100)
            }
            Spacer()
        }
        .sheet(isPresented: $showMap, content: {
            MapView(address: "〒103-0022 東京都中央区日本橋室町１丁目５−３ 福島ビル 6階")
        })
        .navigationTitle("Test 5: 地図表示")
        .navigationBarTitleDisplayMode(.inline)
    }

}

struct MapView: UIViewRepresentable {
    var address: String
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let placemarks = placemarks,
                  let location = placemarks.first?.location else { return }
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            
            uiView.addAnnotation(annotation)
            uiView.centerCoordinate = annotation.coordinate
            
            let region = MKCoordinateRegion(center: annotation.coordinate,
                                            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
            
            uiView.setRegion(region, animated: true)
        }
    }
}

#Preview {
    Test5View.previewContent()
}

