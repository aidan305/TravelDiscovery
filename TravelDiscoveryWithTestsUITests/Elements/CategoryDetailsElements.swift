//
//  CategoryElements.swift
//  TravelDiscoveryWithTestsUITests
//
//  Created by aidan egan on 11/02/2021.
//

import Foundation
import XCTest

class CategoryDetailsElements: BaseElements {
    
    lazy var navBarTitle = app.navigationBars.children(matching: .staticText).firstMatch

}
