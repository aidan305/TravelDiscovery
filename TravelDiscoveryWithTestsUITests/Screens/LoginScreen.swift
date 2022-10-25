//
//  LoginScreen.swift
//  TravelDiscoveryWithTestsUITests
//
//  Created by aidan egan on 15/02/2021.
//

import Foundation
import XCTest

class LoginScreen {
    
    lazy var elements = LoginElements()
    lazy var assertions = LoginAssertions()
    
    func loginWithCredentials(_ username: String, _ password: String) {
        elements.emailTextField.setText(username)
        elements.passwordTextField.setText(password)
        elements.loginBtn.tap()
    }
}
