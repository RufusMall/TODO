//
//  ViewController.m
//  Todo
//
//  Created by Rufus on 17/04/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

#import "ToDoTableViewController.h"
#import "ToDoTableViewCell.h"
#import "TodoItemViewModel.h"

@interface ToDoTableViewController () <TodoTableViewCellDelegate, UITableViewDataSource>
@property (strong, nonatomic) ToDoListViewModel *viewModel;
@end

NSString *toDoCellId = @"ToDoCell";

@implementation ToDoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    
    self.viewModel = [[ToDoListViewModel alloc] init:[RLMRealm defaultRealm] view:self];
    
    [self.viewModel start];
    self.title = self.viewModel.title;
}

#pragma mark - viewModel updates

- (void)reloadItems {
    [self.tableView reloadData];
}

- (void)showError:(nonnull NSString *)error {
    NSLog(@"%@", error);
}

- (void)navBarImageChanged {
    UIImageView* imageView = [[UIImageView alloc] initWithImage:self.viewModel.headerImage];
    [imageView.widthAnchor constraintEqualToAnchor:imageView.heightAnchor multiplier:1.0].active = true;
    [imageView.heightAnchor constraintEqualToConstant:25].active = true;
    
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = self.viewModel.title;
    NSArray* arrangedViews = @[imageView, label];
    UIStackView* stackview = [[UIStackView alloc]initWithArrangedSubviews:arrangedViews];
    stackview.spacing = 6.0;
    self.navigationItem.titleView = stackview;
}

- (void)updateWithChanges:(nonnull RLMCollectionChange *)changes {
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:[changes deletionsInSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView insertRowsAtIndexPaths:[changes insertionsInSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadRowsAtIndexPaths:[changes modificationsInSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    
    if (changes.deletions.count == 0 && changes.insertions.count == 1) {
        NSNumber* row = changes.insertions.lastObject;
        NSIndexPath* lastCellPath = [NSIndexPath indexPathForRow:row.integerValue  inSection:0];
        
        [self.tableView scrollToRowAtIndexPath:lastCellPath atScrollPosition: UITableViewScrollPositionTop animated:true];
        ToDoTableViewCell *cell = [self.tableView cellForRowAtIndexPath:lastCellPath];
        [cell.titleTextView becomeFirstResponder];
        [cell.titleTextView selectAll: nil];
    }
}

#pragma mark - user input

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.viewModel deleteToDoAtRow:indexPath.row];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TodoItemViewModel *todoViewModel = [self.viewModel itemForRow:indexPath.row];
    ToDoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:toDoCellId];
    [cell configureWith:todoViewModel];
    cell.delegate = self;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.rowCount;
}

- (IBAction)addTodoPressed:(id)sender {
    ToDo* placeholderTodo = [[ToDo alloc]init];
    placeholderTodo.name = @"Enter title here...";
    [self.viewModel addTodo:placeholderTodo];
}

-(void)donePressed:(id)sender {
    self.navigationItem.rightBarButtonItem = nil;
    [self.view endEditing:true]; //dismiss the keyboard
}

#pragma mark - todoCellDelegate

-(void)todoCellDidBeginEditing:(ToDoTableViewCell *)cell {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed:)];
}

-(void)todoCellDidEndEditing:(ToDoTableViewCell *)cell {
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    [self.viewModel updateTodoAtRow:indexPath.row withText: cell.titleTextView.text];
}

- (void)adjustSizeForCell:(ToDoTableViewCell *)cell {
    [self.tableView beginUpdates]; //will animate the expanding of the cell if the cell contents requires it.
    [self.tableView endUpdates];
}

- (void)todoCell:(ToDoTableViewCell *)cell didToggleCompleted:(BOOL)isCompleted {
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    [self.viewModel updateTodoAtRow:indexPath.row isCompleted:isCompleted];
}

@end

