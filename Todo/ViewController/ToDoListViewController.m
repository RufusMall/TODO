//
//  ViewController.m
//  Todo
//
//  Created by Rufus on 17/04/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

#import "ToDoListViewController.h"

@interface ToDoListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ToDoListViewModel *viewModel;
@end

NSString *toDoCellId = @"ToDoCell";

@implementation ToDoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    
    self.viewModel = [[ToDoListViewModel alloc] init:[RLMRealm defaultRealm] view:self];
    
    [self.viewModel start];
}

- (void)reloadItems {
    [self.tableView reloadData];
}

- (void)showError:(nonnull NSString *)error {
    NSLog(error);
}

- (void)updateWithChanges:(nonnull RLMCollectionChange *)changes {
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:[changes deletionsInSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView insertRowsAtIndexPaths:[changes insertionsInSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadRowsAtIndexPaths:[changes modificationsInSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.viewModel deleteToDoAtRow:indexPath.row];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ToDo *todo = self.viewModel.todoResults[indexPath.row];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:toDoCellId];
    cell.textLabel.text = todo.name;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.todoResults.count;
}

@end
