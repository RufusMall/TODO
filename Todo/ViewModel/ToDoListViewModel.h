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
#import "TodoItemViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol TodoListView <NSObject>
-(void)showError: (NSString*)error;
-(void)reloadItems;
-(void)updateWithChanges:(RLMCollectionChange*)changes;
@end

@interface ToDoListViewModel : NSObject
@property(strong, nonatomic)NSString* title;
@property(readonly) NSInteger rowCount;

-(instancetype)init:(RLMRealm*)realm view:(id<TodoListView>)view;
-(void)start;
-(TodoItemViewModel*)itemForRow:(NSInteger)row;
-(void)addTodo:(ToDo*)todo;
-(void)updateTodoAtRow:(NSInteger)row withText:(NSString*)text;
-(void)updateTodoAtRow:(NSInteger)row isCompleted:(BOOL)completed;
-(void)deleteToDoAtRow:(NSInteger)row;
@end

NS_ASSUME_NONNULL_END
