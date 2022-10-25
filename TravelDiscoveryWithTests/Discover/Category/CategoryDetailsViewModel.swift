//
//  CategoryDetailsView.swift
//  TravelDiscovery
//
//  Created by aidan egan on 21/10/2020.
//

import Foundation
import Kingfisher
import SwiftUI

class CategoryDetailsViewModel: ObservableObject{
    @Published var isLoading = true
    @Published var places = [Place]()
    @Published var errorMessage = ""
    
    init(name: String) {
        // network code happening here
        
        let urlString = "https://travel.letsbuildthatapp.com/travel_discovery/category?name=\(name.lowercased())"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let url = URL(string: urlString) else {
            self.isLoading = false
            return
            
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode,
               statusCode >= 400 {
                self.isLoading = false
                self.errorMessage = "Bad Status: \(statusCode)"
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                guard let data = data else {return}
                do {
                    self.places = try JSONDecoder().decode([Place].self, from: data)
                    
                } catch {
                    print("Failed to decode JSON: \(error)")
                    self.errorMessage = error.localizedDescription // error handling incase http request fails for some reason
                    
                }
                self.isLoading = false
            }
        }.resume()
    }
}


struct CategoryDetailsView: View {
    
    private let name: String
    @ObservedObject private var vm : CategoryDetailsViewModel
    
    init(name: String){
        print("Loaded catergory details view and making netwrok request for \(name)")
        self.name = name
        self.vm = .init(name: name)
    }
    

    
    var body: some View {
        ZStack{
            if vm.isLoading {
                VStack{
                ActivityIndicatorView()
                Text("Loading...")
                    .foregroundColor(Color.white)
                    .font(.system(size: 16, weight: .semibold))
                }.padding()
                .background(Color.black)
                .cornerRadius(8)
                
            }
            else {
                ZStack{
                    if !vm.errorMessage.isEmpty{
                        VStack(spacing: 10){
                            Image(systemName: "xmark.octagon.fill")
                                .font(.system(size: 64, weight: .semibold))
                                .foregroundColor(Color.red)
                            Text(vm.errorMessage)
                        }
                        
                    }
                    ScrollView{
                        ForEach(vm.places, id: \.self) { place in
                            VStack(alignment: .leading, spacing: 0){
                                KFImage(URL(string: place.thumbnail))
                                    .resizable()
                                    .scaledToFill()
                                Text(place.name)
                                    .font(.system(size: 12, weight: .semibold))
                                    .padding()
                                    .accessibilityIdentifier("\(place.name)Title")
                            }.asTile()
                            
                            .padding()
                        }
                    }
                }
               
            }
        }
        .navigationBarTitle(name, displayMode: .inline)
    }
}

struct CategoryDetailsViewModel_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CategoryDetailsView(name: "food")
        }
    }
}
