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

let screen = UIScreen.main.bounds

struct CategoriesFoodList: View {
    @State var show = false
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    var categorytitle: String
    @ObservedObject var viewModel: CategoryFoodListViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   @State var categoriesMealData: [MealListViewModel] = []
    
    var body: some View {
        
        ZStack {
            Color.appBackgroundColor.edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false){
                VStack() {
                    Text(categorytitle)
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .blur(radius: active ? 20 : 0)
                    
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }.offset(y: -40)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }

                    ForEach(categoriesMealData.indices, id: \.self){ index in
                    GeometryReader { geometry in
                        ThumbnailView(
                            show: self.$categoriesMealData[index].show,
                            active: self.$active,
                            index: index,
                            activeIndex: self.$activeIndex,
                            activeView: self.$activeView,
                            dataItem: self.categoriesMealData[index]
                        )
                        .offset(y: self.categoriesMealData[index].show ? -geometry.frame(in: .global).minY : 0)
                        .opacity(self.activeIndex != index && self.active ? 0 : 1)
                        .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                        .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                    }
                    .frame(height: 280)
                    .frame(maxWidth: self.categoriesMealData[index].show ? .infinity : screen.width - 60)
                    .zIndex( self.categoriesMealData[index].show ? 1 : 0)
                    .background(Color.clear.opacity(0.4))
            }
                }
            }.statusBar(hidden: active ? true : false)
        }
        .navigationBarHidden(true)
            .onAppear {
                self.viewModel.getFoodList(title: self.categorytitle) { (mealModel) in
                    self.categoriesMealData = mealModel
                }
        }
    }
}
  
struct ThumbnailView: View {
    @Binding var show: Bool
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    let dataItem: MealListViewModel
    @State var image:UIImage = UIImage()
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
                MealDetailView(mealId:  dataItem.idMeal,viewModel: MealDetailViewModel(), imageUrl: dataItem.strMealThumb,  show: self.$show, active: self.$active, activeIndex: self.$activeIndex)
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
                .offset(x: -16, y: 50)
                .transition(.slide)
                .animation(.easeOut)
               
            }
        }
        
        .frame(height: show ? screen.height : 280)
        .transition(.slide)
        .edgesIgnoringSafeArea(.all)
    }
    
    
}

struct ImageRow: View {
    let itemHeight:CGFloat = 500
    let SVWidth = UIScreen.main.bounds.width - 40
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
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
