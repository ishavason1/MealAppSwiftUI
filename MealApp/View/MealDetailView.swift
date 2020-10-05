//
//  MealDetailView.swift
//  MealApp
//
//  Created by Isha on 16/09/20.
//  Copyright © 2020 Isha. All rights reserved.
//

import SwiftUI

struct MealDetailView: View {
    var mealId: String
    @State private var data = [MealDetail]()
    var body: some View {
        ScrollView {
            if data.count > 0 {
                MealItemView(dataItems: data[0], imageLoader: ImageLoader(urlString: data.first?.strMealThumb ?? ""))
            }
        }.padding(.bottom)
            .onAppear(perform: loadData)
            .background(Color.appBackgroundColor.edgesIgnoringSafeArea(.all))
        
    }
    
    func loadData() {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(MealInfo.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        
                        // update our UI
                        self.data = decodedResponse.meals ?? []
                        print(self.data)
                    }
                    
                    // everything is good, so we can exit
                    return
                }
            }
        }.resume()
        
    }
}

struct MealItemView: View {
    let dataItems: MealDetail
    @ObservedObject var imageLoader:ImageLoader
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<1) { items in
                    GeometryReader { geo in
                        Image(uiImage: self.imageLoader.data != nil ? UIImage(data:self.imageLoader.data!)! : UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geo.size.width, height: 300)
                            .foregroundColor(.yellow)
                            .shadow(radius: 10)
                            .padding(.top)
                        
                    }
                }
            }.frame(height: 300 )
                .cornerRadius(7)
            VStack {
                Spacer()
                Text("Instructions")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(height: 50)
                    .font(.title)
                    .font(.custom("Helvetica Neue", size: 20))
                Spacer()
    
                    Text(self.dataItems.strInstructions)
                    .foregroundColor(Color.white)
                    
                }.cornerRadius(7)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top)
                
                
            }
        }
}
        struct MealDetailView_Previews: PreviewProvider {
            static var previews: some View {
                MealDetailView(mealId: "")
            }
}

