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
class ExpandedItem: ObservableObject{
    @Published var expandedItem: MealList = MealList(strMeal: "", strMealThumb: "", idMeal: "")
    @Published var expandedScreen_returnPoint: CGRect = CGRect(x: 0, y: 0, width: 0.0, height: 0.0)
    @Published var expandedScreen_startPoint: CGRect = CGRect(x: 0, y: 0, width: 0.0, height: 0.0)
    @Published var expandedScreen_shown: Bool = false
    @Published var expandedScreen_willHide: Bool = false
    @Published var dataItems: MealDetail?
}
let screen = UIScreen.main.bounds
struct CategoriesFoodList: View {
    @State var show = false
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    var categorytitle: String
    @ObservedObject var viewModel: CategoryFoodListViewModel
    
    var body: some View {
        
        ZStack {
            Color.appBackgroundColor.edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false){
                VStack(spacing: 30) {
                    Text(categorytitle)
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        .blur(radius: active ? 20 : 0)
                    ForEach(viewModel.categoriesMealData.indices, id: \.self){ index in
                    GeometryReader { geometry in
                        ThumbnailView(
                            show: self.$show,
                            active: self.$active,
                            index: index,
                            activeIndex: self.$activeIndex,
                            activeView: self.$activeView,
                            dataItem: self.viewModel.categoriesMealData[index]
                        )
                        .offset(y: self.show ? -geometry.frame(in: .global).minY : 0)
                        .opacity(self.activeIndex != index && self.active ? 0 : 1)
                        .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                        .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                    }
                    .frame(height: 280)
                    .frame(maxWidth: self.show ? .infinity : screen.width - 60)
                    .zIndex(self.show ? 1 : 0)
                    .background(Color.clear.opacity(0.4))
            }
                }
            }.statusBar(hidden: active ? true : false)
        }
            .onAppear {
                self.viewModel.getFoodList(title: self.categorytitle)
        }
    }
}
    
struct ThumbnailView: View {
    @Binding var show: Bool
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    let dataItem: MealList
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack {
                ImageRow(imageLoader: ImageLoader(urlString: dataItem.strMealThumb))
            }
            .frame(width: show ? screen.width : screen.width - 60, height: show ? 460 : 280)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                if self.show {
                    self.activeIndex = self.index
                } else {
                    self.activeIndex = -1
                }
            }
            if show {
                MealDetailView(mealId: dataItem.idMeal, viewModel: MealDetailViewModel())
                    .background(Color.white)
                    .animation(nil)
                
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .onTapGesture {
                    self.show = false
                    self.active = false
                    self.activeIndex = -1
                }
                .offset(x: -16, y: 100)
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
               
            }
        }
        .frame(height: show ? screen.height : 280)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ImageRow: View {
    let itemHeight:CGFloat = 500
    let SVWidth = UIScreen.main.bounds.width - 40
    @ObservedObject var imageLoader:ImageLoader
    var body: some View {
        Image(uiImage: self.imageLoader.data != nil ? UIImage(data:self.imageLoader.data!)! : UIImage())
                    .resizable()
                     .aspectRatio(contentMode: .fill)
    }
}



struct CategoriesFoodList_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesFoodList(categorytitle: "", viewModel: CategoryFoodListViewModel())
    }
}
