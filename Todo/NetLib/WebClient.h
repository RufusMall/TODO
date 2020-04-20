//
//  WebClient.h
//  Todo
//
//  Created by Rufus on 20/04/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NSURLRequestCachePolicy CachePolicy;
typedef void (^RequestCompletion)(NSData * _Nullable data, NSError * _Nullable error);

@interface WebClient : NSObject
-(instancetype)initWithURLSession:(NSURLSession*)session;
-(void)get:(NSURL*)url policy:(NSURLRequestCachePolicy)cachePolicy  withCompletion:(RequestCompletion)completion;
@end

NS_ASSUME_NONNULL_END
