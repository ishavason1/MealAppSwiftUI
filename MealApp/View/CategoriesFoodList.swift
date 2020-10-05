//
//  CategoriesFoodList.swift
//  MealApp
//
//  Created by Isha on 12/09/20.
//  Copyright © 2020 Isha. All rights reserved.
//

import SwiftUI
import ASCollectionView_SwiftUI

struct CategoriesFoodList: View {
    var categorytitle: String
    @ObservedObject var viewModel: CategoryFoodListViewModel
    @State private var data = [MealList]()
    var body: some View {
        ZStack {
            Color.appBackgroundColor.edgesIgnoringSafeArea(.all)
            List {
                ForEach(viewModel.categoriesMealData.indices, id: \.self) { index in
                    ZStack {
                        MealView(dataItems: self.viewModel.categoriesMealData[index], imageLoader: ImageLoader(urlString: self.viewModel.categoriesMealData[index].strMealThumb))
                        NavigationLink(destination: MealDetailView(mealId: self.viewModel.categoriesMealData[index].idMeal)) {
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .listStyle(GroupedListStyle())
            
        }.navigationBarTitle("MealApp", displayMode: .inline)
            .onAppear {
                self.viewModel.loadList(title: self.categorytitle)
        }
    }
}
struct MealView: View {
    let dataItems: MealList
    @ObservedObject var imageLoader:ImageLoader
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<1) { items in
                    GeometryReader { geo in
                        Image(uiImage: self.imageLoader.data != nil ? UIImage(data:self.imageLoader.data!)! : UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width, height: 500)
                            .foregroundColor(.yellow)
                            .shadow(radius: 10)
                            .padding(.top)
                        
                    }
                }
            }.frame(height: 200 )
            HStack {
                Spacer()
                Text(self.dataItems.strMeal)
                    .foregroundColor(Color.white)
                    .frame(height: 50)
                    .font(.custom("Helvetica Neue", size: 20))
                Spacer()
            }.background(Color.black.opacity(0.5))
                
                .padding(.top)
        }.background(Color.white)
            .cornerRadius(7)
    }
}

struct CategoriesFoodList_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesFoodList(categorytitle: "", viewModel: CategoryFoodListViewModel())
    }
}
