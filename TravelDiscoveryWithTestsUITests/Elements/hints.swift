//
//  hints.swift
//  TravelDiscoveryWithTestsUITests
//
//  Created by aidan egan on 12/05/2021.
//
import XCTest
import Foundation

class LoginElements1: BaseElements {
    lazy var emailTextField = app.textFields["EmailAddressTextField"]
}


class LoginActions {
    let elements = LoginElements()
    
    func enterCredentials() {
        elements.emailTextField.typeText("email@hotmail.com")
    }
}

class LoginAssertions1 {
    
    let profileName = "profile name displayed" // actual
    
    func asssertSignedIn() {
    XCTAssertEqual(profileName, "user used to sign in")
    }
}




