//
//  WebClientTestCase.m
//  TodoTests
//
//  Created by Rufus on 20/04/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WebClient.h"

@interface WebClientTestCase : XCTestCase

@end

@implementation WebClientTestCase

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    XCTestExpectation* expectation = [[XCTestExpectation alloc]initWithDescription:@"getCompletionCalled"];
    
    NSURLSession* urlSession = [NSURLSession sharedSession];
    WebClient* webClient = [[WebClient alloc]initWithURLSession:urlSession];
    
    NSURL* imageURL = [NSURL URLWithString:@"https://rerunosm.blob.core.windows.net/rerun-public/todo.png"];
    NSURLRequestCachePolicy cachePolicy = NSURLRequestReloadIgnoringCacheData;
    
    [webClient get:imageURL policy:cachePolicy withCompletion:^(NSData * _Nullable data, NSError * _Nullable error) {
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:20.0];
}

@end
