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
    @ObservedObject var viewModel: MealDetailViewModel
    var body: some View {
        ScrollView {
            if viewModel.mealDetailData.count > 0 {
                MealItemView(dataItems: viewModel.mealDetailData[0], imageLoader: ImageLoader(urlString: viewModel.mealDetailData.first?.strMealThumb ?? ""))
            }
        }.padding(.bottom)
            .onAppear(perform: {
                self.viewModel.loadMealDetails(mealId)
            })
            .background(Color.appBackgroundColor.edgesIgnoringSafeArea(.all))
        
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
                MealDetailView(mealId: "", viewModel: MealDetailViewModel())
            }
}

