//
//  PopularDestinationsView.swift
//  TravelDiscovery
//
//  Created by aidan egan on 16/10/2020.
//

import SwiftUI
import MapKit

struct PopularDestinationsView: View {
    
    let destinations: [Destination] = [
        Destination(name: "Paris", country: "France", imageName: "eiffel_tower", latitude: 48.859565, longitude: 2.353235),
        Destination(name: "Toyko", country: "Japan", imageName: "japan", latitude: 35.679693, longitude: 139.771913),
        Destination(name: "New York", country: "US", imageName: "new_york", latitude: 40.71592, longitude: -74.0055)
    ]
    
    var body: some View{
        VStack {
            HStack{
                Text("Popular destinations")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 14, weight: .semibold))
            }.padding(.horizontal)
            .padding(.top)
            
            ScrollView(.horizontal){
                HStack(spacing: 8){
                    ForEach(destinations, id: \.self){ destination in
                        NavigationLink(
                            destination: PopularDestinationDetailsView(destination: destination),
                            label: {
                                PopularDestinationTile(destination: destination)
                                    
                                    .padding(.bottom)
                            })
                    }
                }.padding(.horizontal)
            }
        }
    }
}

class DestinationDetailsViewModel: ObservableObject {
    @Published var isLoading = true
    
    init(){
        //lets make a network call
        let name = "paris"
        guard let url = URL(string: "https://travel.letsbuildthatapp.com/travel_discovery/destination?name=\(name)") else {return}
        
        URLSession.shared.dataTask(with: url){data, response, error in
            guard let data = data else {return }
            print(String(data: data, encoding: .utf8))
        }.resume()
    }
}

struct PopularDestinationDetailsView: View {
    @ObservedObject var vm = DestinationDetailsViewModel()
    
    let destination: Destination
    @State var region : MKCoordinateRegion
    let attractions : [Attraction] = [.init(name: "Eiffel Tower", imageName: "eiffel_tower", latitude: 48.859565, longitude: 2.353235),
                                      .init(name: "Champs-Elysees", imageName: "new_york", latitude: 48.866867, longitude: 2.311780),
                                      .init(name: "Louvre Museum", imageName: "art2", latitude: 48.860288, longitude: 2.337789)]
    @State var isShowingAttractions = false
    
    
    init(destination: Destination){
        self.destination = destination
        self._region = State(initialValue: MKCoordinateRegion(center: .init(latitude: destination.latitude, longitude: destination.longitude), span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)))
    }
    
    let imageUrlStrings = ["https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/7156c3c6-945e-4284-a796-915afdc158b5", "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/6982cc9d-3104-4a54-98d7-45ee5d117531", "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/2240d474-2237-4cd3-9919-562cd1bb439e"]

    var body: some View{
        ScrollView{

            DestinationHeaderContainer(imageUrlStrings: imageUrlStrings, selectionIndex: 0)
                .frame(height: 350)
            
            VStack(alignment: .leading){
                Text(destination.name)
                    .font(.system(size: 18, weight: .bold))
                Text(destination.country)
                
                HStack{
                    ForEach(0..<5, id: \.self){ num in
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                    }
                }.padding(.top, 2)
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
                    .padding(8)
                    .font(.system(size: 14))
                HStack{ Spacer() }
            }.padding(.horizontal)
            
            HStack{
                Text("Location")
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
                
                Button(action: { isShowingAttractions.toggle()}, label: {
                    Text("\(isShowingAttractions ? "Hide" : "Show") Attractions")
                        
                        .font(.system(size: 12, weight: .semibold))
                })
                
                Toggle("", isOn: $isShowingAttractions)
                    .labelsHidden()
            }.padding(.horizontal)
            
            Map(coordinateRegion: $region, annotationItems: isShowingAttractions ? attractions : []) { (attraction) in
                MapAnnotation(coordinate: .init(latitude: attraction.latitude, longitude: attraction.longitude)) {
                    CustomMapAnnotation(attraction: attraction)
                }
            }.frame(height: 300)
            
        }.navigationBarTitle(destination.name, displayMode: .inline)
    }
    
}

struct CustomMapAnnotation: View{
    let attraction: Attraction
    
    var body: some View{
        VStack{
            Image(attraction.imageName)
                .resizable()
                .frame(width: 80, height: 60)
                .cornerRadius(4)
            Text(attraction.name)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal,6)
                .padding(.vertical,4)
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .foregroundColor(.white)
                .border(Color.black)
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4).stroke(Color(.init(white: 0, alpha: 0.5))))
        }.shadow(radius: 5)
    }
}

struct Attraction: Identifiable {
    let id = UUID().uuidString
    let name: String
    let imageName: String
    let latitude, longitude: Double
}

struct PopularDestinationTile: View {
    let destination: Destination
    
    var body: some View{
        VStack(alignment: .leading, spacing: 0){
            
            Image(destination.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 125, height: 125)
                .cornerRadius(5)
                .padding([.horizontal, .vertical], 6)
            
            Text(destination.name)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 12)
                .foregroundColor(Color(.label))
            
            Text(destination.country)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
                .foregroundColor(.gray)
        }
        .asTile()
    }
}

struct PopularDestinationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PopularDestinationDetailsView(destination: .init(name: "Paris", country: "France", imageName: "eiffel_tower", latitude: 48.859565, longitude: 2.353235))
            //            PopularDestinationDetailsView(destination: .init(name: "Tokyo", country: "Japan", imageName: "japan", latitude: 35.679693, longitude: 139.771913))
        }
        DiscoverView()
        PopularDestinationsView()
    }
}
