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
    @State private var showingDetail = false
   
    var body: some View {
        NavigationView {
            ZStack {
                Color.appBackgroundColor.edgesIgnoringSafeArea(.all)
                BreakFastMenu()
//                ASCollectionView(data: viewModel.categoriesData, dataID: \.self) { item, _ in
//
//                    NavigationLink(destination: CategoriesFoodList(categorytitle: item.strCategory, viewModel: self.viewFoodModel)) {
//                         CollectionView(dataItems: item, imageLoader: ImageLoader(urlString: item.strCategoryThumb)).padding(.top)
//                    }.buttonStyle(PlainButtonStyle())
//
//                }
//                .layout {
//                    .grid(layoutMode: .adaptive(withMinItemSize: 160),
//                          itemSpacing: 20,
//                          lineSpacing: 20,
//                          itemSize: .absolute(160))
//                    }
                
            }
            .navigationBarTitle("Menu", displayMode: .large)
           
                //.onAppear(perform: viewModel.loadData)
            
        }
    }
    
}

struct BreakFastMenu: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        let x = proxy.frame(in: .global).minX
        let diff = abs(x)
        if diff < 100 {
            scale = 1 + (100 - diff) / 500
        }
        return scale
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                    Text("Breakfast")
                    .font(.headline)
                    .foregroundColor(.white)
                                            
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: 30){
                        ForEach(menu[0].items) { num in
                            GeometryReader { proxy in
                                let scale = getScale(proxy: proxy)
                                Image(num.mainImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200)
                                    .clipped()
                                    .cornerRadius(5)
                                    .shadow(radius: 5 )
                                  .scaleEffect(CGSize(width: scale, height: scale))
                            }
                                
                            .frame(width: 200, height: 200)
                               
                        }
                    }.padding()
                        
                }
                Text("Breakfast")
                .font(.headline)
                .foregroundColor(.white)
                    .padding(.top)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(menu[0].items) { num in
                            GeometryReader { proxy in
                            Image(num.mainImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200)
                                .clipped()
                                .cornerRadius(5)
                                .shadow(radius: 5)
                                .scaleEffect(CGSize(width: 1, height: 1))
                                .rotation3DEffect(
                                    Angle(degrees: Double(proxy.frame(in: .global).minX)),
                                    axis: (x: 0.0, y: 10.0, z: 0.0)
                                    
                                    )
                        }
                            .frame(width: 200, height: 200)
                        }
                        
                    }
                    
                }
            }.padding()
            
            
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
