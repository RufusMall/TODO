//
//  TodoItemViewModel.h
//  Todo
//
//  Created by Rufus on 19/04/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TodoItemViewModel : NSObject
@property(strong,nonatomic) NSString* name;
-(instancetype)initWith:(NSString*)name;
@end

NS_ASSUME_NONNULL_END
