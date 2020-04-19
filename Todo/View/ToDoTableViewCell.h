//
//  ToDoTableViewCell.h
//  Todo
//
//  Created by Rufus on 19/04/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoItemViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class ToDoTableViewCell;
@protocol TodoTableViewCellDelegate
-(void)todoCellDidBeginEditing:(ToDoTableViewCell*)cell;
-(void)todoCellDidEndEditing:(ToDoTableViewCell*)cell;
-(void)adjustSizeForCell:(ToDoTableViewCell*)cell;
@end

@interface ToDoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *titleTextView;
@property(weak, nonatomic) id<TodoTableViewCellDelegate> delegate;
-(void)configureWith:(TodoItemViewModel*)viewModel;
@end

NS_ASSUME_NONNULL_END
