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
        
        //           UITableView *tableView = weakSelf.tableView;
        //           // Initial run of the query will pass nil for the change information
        //           if (!changes) {
        //               [tableView reloadData];
        //               return;
        //           }
        //
        //           // Query results have changed, so apply them to the UITableView
        //           [tableView beginUpdates];
        //           [tableView deleteRowsAtIndexPaths:[changes deletionsInSection:0]
        //                            withRowAnimation:UITableViewRowAnimationAutomatic];
        //           [tableView insertRowsAtIndexPaths:[changes insertionsInSection:0]
        //                            withRowAnimation:UITableViewRowAnimationAutomatic];
        //           [tableView reloadRowsAtIndexPaths:[changes modificationsInSection:0]
        //                            withRowAnimation:UITableViewRowAnimationAutomatic];
        //           [tableView endUpdates];
    }];
}

-(void)dealloc {
    [_notificationToken invalidate];
}

@end
