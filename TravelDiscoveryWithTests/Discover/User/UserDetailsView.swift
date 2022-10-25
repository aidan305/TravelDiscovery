//
//  UserDetailsView.swift
//  TravelDiscovery
//
//  Created by aidan egan on 29/01/2021.
//

import SwiftUI
import Kingfisher

struct UserDetails: Decodable {
    let username, firstName, lastName, profileImage: String
    let followers, following: Int
    let posts: [Post]
}

struct Post: Decodable, Hashable {
    let title, imageUrl, views: String
    let hashtags: [String]
    
}

class UserDetailsViewModel: ObservableObject {
    
    @Published var userDetails: UserDetails?
    
    init(userId: Int) {
        // network code
        guard let url = URL(string: "https://travel.letsbuildthatapp.com/travel_discovery/user?id=\(userId)") else { return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                do {
                    try self.userDetails = JSONDecoder().decode(UserDetails.self, from: data)
                } catch let jsonError {
                    print("decoding failed for user details", jsonError)
                }
                print(data)
            }
        }.resume()
    }
}

struct UserDetailsView: View {
    
    @ObservedObject var vm : UserDetailsViewModel
    
    let user: User
    
    init(user: User) {
        self.user = user
        self.vm = .init(userId: user.id)
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing: 12){
                Image(user.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(.horizontal)
                    .padding(.top)
                Text(user.name ?? "")
                    .font(.system(size: 14, weight: .semibold))
                
                HStack{
                    Text("@\(self.vm.userDetails?.username ?? "") •")
                    Image(systemName: "hand.thumbsup.fill")
                    Text("2541")
                } .font(.system(size: 12, weight: .semibold))
                
                Text("YouTuber, Vlogger, Travel Creator")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(.lightGray))
                
                HStack{
                    VStack{
                        Text("\(self.vm.userDetails?.followers ?? 0)")
                            .font(.system(size: 13, weight: .semibold))
                        Text("Followers")
                            .font(.system(size: 9, weight: .regular))
                    }
                    Divider()
                        .frame(height: 25)
                        .background(Color(.lightGray))
                    VStack{
                        Text("\(self.vm.userDetails?.following ?? 0)")
                           .font(.system(size: 13, weight: .semibold))
                        Text("Following")
                            .font(.system(size: 9, weight: .regular))
                    }
                }
                HStack(spacing: 16){
                    Button(action: {}, label: {
                        HStack{
                            Spacer()
                            Text("Follow")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white)
                            Spacer()
                        }.padding(.vertical, 8)
                        .background(Color.orange)
                        .cornerRadius(50)
                    })
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        HStack{
                            Spacer()
                            Text("Contact")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.black)
                            Spacer()
                        }.padding(.vertical, 8)
                        .background(Color(white: 0.9))
                        .cornerRadius(50)
                    })
                }
                
                ForEach(vm.userDetails?.posts ?? [], id: \.self) { post in
                    VStack(alignment: .leading){
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                        
                        HStack{
                            Image(user.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height:34)
                                .clipShape(Circle())
                            VStack(alignment: .leading){
                                Text(post.title)
                                    .font(.system(size: 14, weight: .semibold))
                                
                                Text("\(post.views) views")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.gray)
                            }
                        }.padding(.horizontal, 8)
                        
                        HStack{
                            ForEach(post.hashtags, id: \.self) { hashtag in
                                Text("#\(hashtag)")
                                    .foregroundColor(Color(#colorLiteral(red: 0.471667057, green: 0.6231473251, blue: 0.9767109752, alpha: 1)))
                                    .font(.system(size: 14, weight: .semibold))
                                    .padding(.horizontal,12)
                                    .padding(.vertical,4)
                                    .background(Color(#colorLiteral(red: 0.8958377242, green: 0.9539679885, blue: 1, alpha: 1)))
                                    .cornerRadius(25)
                            }
                        }.padding(.bottom)
                        .padding(.horizontal, 8)
                    }
                    .background(Color(white: 1))
                    .cornerRadius(12)
                    .shadow(color: .init(white: 0.8), radius: 5, x: 0, y: 4)
                }
            }.padding(.horizontal)
        }.navigationBarTitle(user.name, displayMode: .inline)
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            UserDetailsView(user: .init(id: 0, name: "Amy Adams", imageName: "amy"))
        }
    }
}

