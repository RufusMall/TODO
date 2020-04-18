//
//  ViewModel.h
//  Todo
//
//  Created by Rufus on 18/04/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm.h>
#import "ToDo.h"

NS_ASSUME_NONNULL_BEGIN
@protocol TodoListView <NSObject>
-(void)showError: (NSString*)error;
-(void)reloadItems;
-(void)updateWithChanges:(RLMCollectionChange*)changes;
@end

@interface ToDoListViewModel : NSObject
@property(strong)RLMResults<ToDo*>* todoResults;

-(instancetype)init:(RLMRealm*)realm view:(id<TodoListView>)view;
-(void)start;
-(void)addTodo:(ToDo*)todo;
-(void)deleteToDoAtRow:(NSInteger)row;
@end

NS_ASSUME_NONNULL_END
