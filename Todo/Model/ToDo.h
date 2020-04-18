//
//  ToDo.h
//  Todo
//
//  Created by Rufus on 18/04/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Realm.h"
NS_ASSUME_NONNULL_BEGIN

@interface ToDo : RLMObject
@property(strong, nonatomic) NSString* name;
@end

NS_ASSUME_NONNULL_END
