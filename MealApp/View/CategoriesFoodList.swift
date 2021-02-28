//
//  CategoriesFoodList.swift
//  MealApp
//
//  Created by Isha on 12/09/20.
//  Copyright © 2020 Isha. All rights reserved.
//

import SwiftUI
import ASCollectionView_SwiftUI
import Combine

struct CategoriesFoodList: View {
    var categorytitle: String
    @ObservedObject var viewModel: CategoryFoodListViewModel
    @State var expandedItem = MealDetailView(mealId: "", viewModel: MealDetailViewModel())
    
    let itemHeight:CGFloat = 500
    let SVWidth = UIScreen.main.bounds.width - 40
    var body: some View {
        ZStack {
            Color.appBackgroundColor.edgesIgnoringSafeArea(.all)
            ScrollView{
                ForEach(viewModel.categoriesMealData, id: \.self){ thisItem in
                    GeometryReader { geo -> AnyView in
                        return AnyView(
                    ZStack {
                        MealView(dataItems: thisItem, imageLoader: ImageLoader(urlString: thisItem.strMealThumb))
                    }.cornerRadius(15).foregroundColor(.white)
                    .shadow(color: .init(red: 0.1, green: 0.1, blue: 0.1)
                      , radius: 11 , x: 0, y: 4)
                        )
                }.background(Color.clear.opacity(0.4))
                    .frame(height:self.itemHeight)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
            }
            }
        }
         .navigationBarTitle("MealApp", displayMode: .inline)
            .onAppear {
                self.viewModel.getFoodList(title: self.categorytitle)
        }
    }
}
struct MealView: View {
    let dataItems: MealList
    @ObservedObject var imageLoader:ImageLoader
    let SVWidth = UIScreen.main.bounds.width - 40
    let itemHeight:CGFloat = 500
    var body: some View {
        Image(uiImage: self.imageLoader.data != nil ? UIImage(data:self.imageLoader.data!)! : UIImage())
            .resizable()
            .scaledToFill()
            .frame(width: self.SVWidth, height: itemHeight)
            .foregroundColor(.yellow)
            .clipped()
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(self.dataItems.strMeal)
                    .foregroundColor(Color.white)
                    .frame(height: 50)
                    .font(.custom("Helvetica Neue", size: 20))
                Spacer()
            }.background(Color.black.opacity(0.5))
        }
    }
}

struct CategoriesFoodList_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesFoodList(categorytitle: "", viewModel: CategoryFoodListViewModel())
    }
}
