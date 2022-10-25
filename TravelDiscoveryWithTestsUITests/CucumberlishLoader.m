//
//  CucumberlishLoader.m
//  TravelDiscoveryWithTestsUITests
//
//  Created by aidan egan on 11/02/2021.
//

#import <Foundation/Foundation.h>
#import "TravelDiscoveryWithTestsUITests-Swift.h"

__attribute__((constructor))
void CucumberishInit()
{
    [CucumberishInitializer setupCucumberish];
}
