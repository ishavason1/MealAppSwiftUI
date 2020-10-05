//
//  ContentView.swift
//  MealApp
//
//  Created by Isha on 06/09/20.
//  Copyright © 2020 Isha. All rights reserved.
//

import SwiftUI
import Foundation
import ASCollectionView_SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: CategoryListViewModel
    @ObservedObject var viewFoodModel: CategoryFoodListViewModel
    var body: some View {
        NavigationView {
            ZStack {
                Color.appBackgroundColor.edgesIgnoringSafeArea(.all)
               
                ASCollectionView(data: viewModel.categoriesData, dataID: \.self) { item, _ in
                    NavigationLink(destination: CategoriesFoodList(categorytitle: item.strCategory, viewModel: self.viewFoodModel)) {
                         CollectionView(dataItems: item, imageLoader: ImageLoader(urlString: item.strCategoryThumb)).padding(.top)
                    }.buttonStyle(PlainButtonStyle())
                   
                }
                .layout {
                    .grid(layoutMode: .adaptive(withMinItemSize: 160),
                          itemSpacing: 20,
                          lineSpacing: 20,
                          itemSize: .absolute(160))
                    }
                
            }.navigationBarTitle("Categories", displayMode: .inline)
               
                .onAppear(perform: viewModel.loadData)
            
        }
    }
    
}
    
struct CollectionView: View {
    let dataItems: Categories
    @ObservedObject var imageLoader:ImageLoader
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<1) { items in
                    Image(uiImage: self.imageLoader.data != nil ? UIImage(data:self.imageLoader.data!)! : UIImage())
                        .resizable()
                        .frame(width: 150, height: 100, alignment: .center)
                        .foregroundColor(.yellow)
                        .shadow(radius: 10)
                        .padding(.top)
                }
            }
            HStack {
                Spacer()
                Text(self.dataItems.strCategory)
                Spacer()
            }.padding(.bottom)
        }.background(Color.white)
            .cornerRadius(7)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: CategoryListViewModel(), viewFoodModel: CategoryFoodListViewModel()).environment(\.colorScheme, .light)
    }
}
