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
@property(nonatomic) BOOL isCompleted;
-(instancetype)initWith:(NSString*)name completionState:(BOOL)isCompleted;
@end

NS_ASSUME_NONNULL_END
