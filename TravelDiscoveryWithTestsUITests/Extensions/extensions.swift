//
//  extensions.swift
//  TravelDiscoveryWithTestsUITests
//
//  Created by aidan egan on 15/02/2021.
//

import Foundation
import XCTest

extension XCUIElement {
    
    var app: XCUIApplication {
        get { XCUIApplication() }
    }
    @discardableResult func waitFor(timeout: TimeInterval = 20) -> XCUIElement {
       if(!isExist(timeout) || !self.isEnabled) {
          XCTFail("Failed to wait for element \(self.debugDescription)")
       }
       return self
    }
    
    @discardableResult func isExist(_ timeout: TimeInterval = 20) -> Bool {
       return self.waitForExistence(timeout: timeout)
    }
    
    func setText(_ textString: String, _ closeKeyboard: Bool = false) {
        self.tap()
         let keyboard = XCUIApplication().keyboards.element.waitFor(timeout: 5)
         if (!keyboard.isHittable) {
            XCTFail("Failed to get keyboard focus on element \(self.debugDescription)")
         }
         self.typeText(textString)
         if closeKeyboard {
            let predicate = NSPredicate(format: "identifier == 'Toolbar'")
            app.toolbars.element(matching:predicate).buttons.allElementsBoundByIndex.last!.tap()
         }
      }
}
