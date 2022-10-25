//
//  LoginElements.swift
//  TravelDiscoveryWithTestsUITests
//
//  Created by aidan egan on 15/02/2021.
//

import Foundation
import XCTest

class LoginElements: BaseElements {
    
    lazy var emailTextField = app.textFields["EmailAddressTextField"]
    lazy var passwordTextField = app.secureTextFields["PasswordTextField"]
    lazy var loginBtn = app.buttons["LoginBtn"]
    lazy var userLoggedInAlertMessage = app.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] 'User'")).element(boundBy: 0)
    lazy var loginErrorMessage = app.staticTexts["LoginFailureErrorMessage"]

}
