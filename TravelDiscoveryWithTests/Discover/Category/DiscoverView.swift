//
//  ContentView.swift
//  TravelDiscovery
//
//  Created by aidan egan on 09/10/2020.
//

import SwiftUI
extension Color{
    static let discoverBackground = Color(.init(white: 0.95, alpha: 1))
}

struct DiscoverView: View {
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView{
            
            ZStack{
                
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9999751449, green: 0.7059161067, blue: 0.2549048662, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.4163817167, blue: 0, alpha: 1))]), startPoint: .top, endPoint: .center)
                    .ignoresSafeArea()
                
                (Color.discoverBackground)
                    .offset(y: 300)
                
                ScrollView{
                    HStack{
                        Spacer()
                        NavigationLink("Login", destination: LoginView())
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color.white)
                            .accessibility(identifier: "DiscoverLoginBtn")
                    }.padding(.horizontal)
                    
                    HStack{
                        Image(systemName: "magnifyingglass")
                        Text("Where do you want to go?").accessibilityIdentifier("SearchBox")
                        Spacer()
                    }.font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color(.init(white: 1, alpha: 0.5)))
                    .cornerRadius(10)
                    .padding(16)
                    
                    
                    DiscoverCategoriesView()
                    
                    VStack{
                        PopularDestinationsView()
                        
                        PopularRestaurantsView()
                        
                        TrendingCreatorsView()
                    }.background(Color.discoverBackground)
                    .cornerRadius(16)
                    .padding(.top, 32)
                }
            }.navigationTitle("Discover")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}



