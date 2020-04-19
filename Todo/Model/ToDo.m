//
//  ToDo.m
//  Todo
//
//  Created by Rufus on 18/04/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

#import "ToDo.h"

@implementation ToDo

+ (NSString *)primaryKey {
    return @"id";
}

+ (NSDictionary *)defaultPropertyValues {
    NSUUID *uuid = [NSUUID UUID];
    NSString *strUuid = [uuid UUIDString];
    return @{@"id" : strUuid};
}
@end
