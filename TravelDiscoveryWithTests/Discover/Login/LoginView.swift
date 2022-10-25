//
//  LoginView.swift
//  TravelDiscoveryWithTests
//
//  Created by aidan egan on 15/02/2021.
//

import SwiftUI

struct LoginView: View {
    @State private var loginSuccessAlert = false
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @State var emailSignedIn = ""
    let acceptableUsers = ["eganjessie@hotmail.com", "aegan486@gmail.com"]
    
     func signIn() {
        
        if acceptableUsers.contains(email.lowercased())  { // hardcoded user credentials for UITest practice
            emailSignedIn = email.lowercased()
            loginSuccessAlert = true
            self.email = ""
            self.password = ""
        } else {
            self.error = "Unable to Login due to incorrect login credentials"
        }
    }
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .foregroundColor(.orange)
                .font(.system(size: 100))
                
            
            VStack(spacing: 15) {
                TextField("Email address", text: $email)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.blue, lineWidth: 1))
                    .accessibility(identifier: "EmailAddressTextField")
                
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.blue, lineWidth: 1))
                    .accessibility(identifier: "PasswordTextField")
            }
            .padding(.bottom, 60)
            .padding(.vertical, 55)
            VStack(spacing: 30){
                Button(action: signIn) {
                    Text("Log In")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                        .background(LinearGradient(gradient: Gradient(colors: [Color(.red), Color(.orange)]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(5)
                }
                .accessibility(identifier: "LoginBtn")
                .alert(isPresented: $loginSuccessAlert) {
                    Alert(title: Text("Login success"), message: Text("User is \(emailSignedIn) logged in"), dismissButton: .default(Text("Got it!")))
                }
            }
            Spacer()
            if (error != "") {
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
                    .accessibility(identifier: "LoginFailureErrorMessage")
            }
        }
        .padding(.bottom, 140)
        .padding(.horizontal, 32)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
