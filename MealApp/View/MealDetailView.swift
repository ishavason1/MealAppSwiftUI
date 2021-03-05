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
        VStack {
            VStack{
                ZStack {
                    ImageRow(imageLoader: ImageLoader(urlString: viewModel.mealDetailData.first?.strMealThumb ?? ""))
                }
            }
        .frame(width: screen.width, height: 400)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        ScrollView {
            if viewModel.mealDetailData.count > 0 {
                MealItemView(dataItems: viewModel.mealDetailData[0])
            }
        } .edgesIgnoringSafeArea(.all)
            
        }
        .padding(.bottom)
            .onAppear(perform: {
                self.viewModel.loadMealDetails(mealId)
            })
            .background(Color.appBackgroundColor.edgesIgnoringSafeArea(.all))
        
    }
}

  
struct MealItemView: View {
    let dataItems: MealDetail
    var body: some View {
            VStack(alignment: .leading, spacing: 30.0) {
                Text("Instructions")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(height: 50)
                    .font(.title)
                    .font(.custom("Helvetica Neue", size: 20))
                    Text(self.dataItems.strInstructions)
                    .foregroundColor(Color.white)
                    
                }.cornerRadius(7)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top)
                
                
            }
        }

        struct MealDetailView_Previews: PreviewProvider {
            static var previews: some View {
                MealDetailView(mealId: "", viewModel: MealDetailViewModel())
            }
}

