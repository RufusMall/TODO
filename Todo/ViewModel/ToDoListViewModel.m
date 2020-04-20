//
//  ViewModel.m
//  Todo
//
//  Created by Rufus on 18/04/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

#import "ToDoListViewModel.h"
#import "ToDo.h"

@interface ToDoListViewModel()
@property(strong, nonnull) RLMRealm* realm;
@property(strong, nonatomic)RLMResults<ToDo*>* todoResults;
@property(weak) id<TodoListView> view;
@property(strong) RLMNotificationToken* notificationToken;
@end

@implementation ToDoListViewModel
- (instancetype)init:(RLMRealm*)realm view:(id<TodoListView>)view {
    self = [super init];
    if (self) {
        self.realm = realm;
        self.view = view;
    }
    return self;
}

-(NSInteger)rowCount {
    return self.todoResults.count;
}

-(void)start {
    self.todoResults = [[ToDo allObjectsInRealm: self.realm] sortedResultsUsingKeyPath:@"creationDate" ascending:YES];
    [self registerNotification];
    self.title = @"Todo";
    NSLog(@"%@", self.todoResults);
}

-(void)addTodo:(ToDo*)todo {
    [self.realm transactionWithBlock:^{
        [self.realm addObject: todo];
    }];
}

-(TodoItemViewModel *)itemForRow:(NSInteger)row {
    ToDo* todo = self.todoResults[row];
    TodoItemViewModel* viewModel = [[TodoItemViewModel alloc]initWith:todo.name completionState:todo.isCompleted];
    return viewModel;
}

-(void)updateTodoAtRow:(NSInteger)row withText:(NSString*)text {
    [self.realm transactionWithBlock:^{
        ToDo* todo = self.todoResults[row];
        todo.name = text;
        [self.realm addOrUpdateObject:todo];
    }];
}

-(void)updateTodoAtRow:(NSInteger)row isCompleted:(BOOL)completed {
    [self.realm transactionWithBlock:^{
        ToDo* todo = self.todoResults[row];
        todo.isCompleted = completed;
        [self.realm addOrUpdateObject:todo];
    }];
}

-(void)deleteToDoAtRow:(NSInteger)row {
    [self.realm transactionWithBlock:^{
        [self.realm deleteObject:self.todoResults[row]];
    }];
}

-(void)registerNotification {
    __weak typeof(self) weakSelf = self;
    self.notificationToken = [self.todoResults addNotificationBlock:^(RLMResults<ToDo *> *results, RLMCollectionChange *changes, NSError *error) {
        
        if (error) {
            [weakSelf.view showError: error.localizedDescription];
            return;
        }
        
        if (!changes) {
            [weakSelf.view reloadItems];
            return;
        }
        
        [weakSelf.view updateWithChanges:changes];
    }];
}

-(void)dealloc {
    [_notificationToken invalidate];
}

@end
