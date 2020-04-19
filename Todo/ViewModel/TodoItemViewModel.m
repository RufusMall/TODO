//
//  TodoItemViewModel.m
//  Todo
//
//  Created by Rufus on 19/04/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

#import "TodoItemViewModel.h"

@implementation TodoItemViewModel

-(instancetype)initWith:(NSString*)name
{
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}
@end
