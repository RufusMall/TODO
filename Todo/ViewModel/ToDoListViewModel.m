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

-(void)start {
    self.todoResults = [ToDo allObjectsInRealm: self.realm];
    [self registerNotification];
    
    NSLog(@"%@", self.todoResults);
}

-(void)addTodo:(ToDo*)todo {
    [self.realm transactionWithBlock:^{
        [self.realm addObject: todo];
    }];
}

-(void)deleteToDoAtRow:(NSInteger)row {
    [self.realm transactionWithBlock:^{
        [self.realm deleteObject:self.todoResults[row]];
    }];
}

-(void)registerNotification {
    __weak typeof(self) weakSelf = self;
    self.notificationToken = [self.todoResults
                              addNotificationBlock:^(RLMResults<ToDo *> *results, RLMCollectionChange *changes, NSError *error) {
        
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
