//
//  WebClient.m
//  Todo
//
//  Created by Rufus on 20/04/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

#import "WebClient.h"

@interface WebClient()
@property(strong,nonatomic)NSURLSession* session;
@end

@implementation WebClient
- (instancetype)initWithURLSession:(NSURLSession*)session {
    self = [super init];
    if (self) {
        _session = session;
    }
    return self;
}

/// perform a simple get request
/// @param url the url to be loaded from
/// @param completion This completion is not gaurenteed to be called on the main queue
-(void)get:(NSURL*)url withCompletion:(RequestCompletion)completion {
    [self get:url policy:NSURLRequestUseProtocolCachePolicy withCompletion:completion];
}

/// perform a simple get request
/// @param url the url to be loaded from
/// @param cachePolicy informs caching behaviour
/// @param completion This completion is not gaurenteed to be called on the main queue
-(void)get:(NSURL*)url policy:(NSURLRequestCachePolicy)cachePolicy withCompletion:(RequestCompletion)completion {

    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:cachePolicy timeoutInterval:60.0];
    
    NSURLSessionDataTask* dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion(data, error);
    }];
    
    [dataTask resume];
}

@end
