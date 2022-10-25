//
//  PopularRestaurantsView.swift
//  TravelDiscovery
//
//  Created by aidan egan on 16/10/2020.
//

import SwiftUI

struct PopularRestaurantsView: View {
    
    let restuarants : [Restuarant] = [
       Restuarant(name: "Japan Finest Tapas", imageName: "tapas"),
       Restuarant(name: "Bar & Grill", imageName: "bar_grill")
    ]
    
    var body: some View{
        VStack{
            HStack{
                Text("Popular places top eat")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 12, weight: .semibold))
            }.padding(.horizontal)
            .padding(.top)
            
            ScrollView(.horizontal){
                HStack(spacing: 8.0){
                    ForEach(restuarants, id: \.self) { restuarant in
                        NavigationLink(destination: RestaurantsDetailsView(restaurant: restuarant),
                                       label: {
                                        RestaurantTile(restuarant: restuarant)
                                            .foregroundColor(Color(.label))
                                       })
                            .padding(.bottom)
                            .accessibility(identifier: "restaurantBtn")
                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct RestaurantTile: View {
    
    let restuarant: Restuarant
    
    var body: some View {
        HStack(spacing: 8){
            Image(restuarant.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(5)
                .padding([.vertical, .leading], 6)
            
            VStack(alignment: .leading, spacing: 6){
                HStack{
                    Text(restuarant.name)
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(Color.gray)
                    })
                }
                
                HStack{
                    Image(systemName: "star.fill")
                    Text("4.7 • Sushi • $$")
                }
                
                Text("Toyko, Japan")
                
            }.font(.system(size: 12, weight: .semibold))
            Spacer()
        }
        .frame(width: 240)
        .asTile()
        
    }
}

struct PopularRestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        PopularRestaurantsView()
        DiscoverView()
    }
}
