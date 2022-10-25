//
//  CucumberishInitializer.swift
//  TravelDiscoveryWithTestsUITests
//
//  Created by aidan egan on 11/02/2021.
//
import XCTest
import Foundation
import Cucumberish

class CucumberishInitializer: NSObject {
    @objc class func setupCucumberish(){
        before({ _ in
            XCUIApplication().launch()
        })

        let givenSteps = GivenSteps()
        let whenSteps = WhenSteps()
        let thenSteps = ThenSteps()
        
        givenSteps.setupSteps()
        whenSteps.setupSteps()
        thenSteps.setupSteps()
        
        let bundle = Bundle(for: CucumberishInitializer.self)
        Cucumberish.executeFeatures(inDirectory: "Features", from: bundle, includeTags: self.getTags(), excludeTags: nil)
    }
        
    fileprivate class func getTags() -> [String]? {
        var itemsTags: [String]? = nil
        for i in ProcessInfo.processInfo.arguments {
            if i.hasPrefix("-Tags:") {
                let newItems = i.replacingOccurrences(of: "-Tags:", with: "")
                itemsTags = newItems.components(separatedBy: ",")
            }
        }
        return itemsTags
    }
    
}
