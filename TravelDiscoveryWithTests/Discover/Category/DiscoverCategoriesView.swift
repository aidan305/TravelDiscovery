//
//  DiscoverCategoriesView.swift
//  TravelDiscovery
//
//  Created by aidan egan on 16/10/2020.
//

import SwiftUI
import Kingfisher

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

struct DiscoverCategoriesView: View {
    
    let categories: [Category] = [
        Category(name: "Art", imageName: "paintpalette.fill"),
        Category(name: "Sports", imageName: "sportscourt.fill"),
        Category(name: "Live Events", imageName: "music.mic"),
        Category(name: "Food", imageName: "sportscourt.fill"),
        Category(name: "History", imageName: "sportscourt.fill")
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment: .top, spacing: 14){
                ForEach(categories, id: \.self) { category in
                    NavigationLink(
                        destination: NavigationLazyView(CategoryDetailsView(name: category.name)),
                        label: {
                            VStack(spacing: 8){
                                Image(systemName: category.imageName)
                                    .font(.system(size: 20))
                                    .foregroundColor(Color(#colorLiteral(red: 0.9999920726, green: 0.5921858549, blue: 0.2470674217, alpha: 1)))
                                    .frame(width: 64, height: 64)
                                    .background(Color.white)
                                    .cornerRadius(68)
                                Text(category.name)
                                    .font(.system(size: 12, weight: .semibold))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.white)
                            }.frame(width: 68)
                        }).accessibilityIdentifier("\(category.name)Cell")
                }
            }.padding(.horizontal)
        }
    }
}

struct DiscoverCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationView{
//            CategoryDetailsView()
//        }
        
        DiscoverView()
    }
}

