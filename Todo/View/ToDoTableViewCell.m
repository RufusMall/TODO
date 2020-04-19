//
//  ToDoTableViewCell.m
//  Todo
//
//  Created by Rufus on 19/04/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//
#import "ToDoTableViewCell.h"

@interface ToDoTableViewCell () <UITextViewDelegate>
@end

@implementation ToDoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleTextView.delegate = self;
}

-(void)configureWith:(TodoItemViewModel*)viewModel {
    self.titleTextView.text = viewModel.name;
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    [self.delegate todoCellDidBeginEditing:self];
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    [self.delegate todoCellDidEndEditing:self];
}

-(void)textViewDidChange:(UITextView *)textView {
    [self.delegate adjustSizeForCell:self];
}

@end
