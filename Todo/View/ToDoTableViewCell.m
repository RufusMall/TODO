//
//  ToDoTableViewCell.m
//  Todo
//
//  Created by Rufus on 19/04/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//
#import "ToDoTableViewCell.h"
#import "RoundToggleButton.h"

@interface ToDoTableViewCell () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet RoundToggleButton *toggleButton;
@end

@implementation ToDoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleTextView.delegate = self;
}

-(void)configureWith:(TodoItemViewModel*)viewModel {
    self.titleTextView.text = viewModel.name;
    self.toggleButton.selected = viewModel.isCompleted;
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
- (IBAction)toggleButtonDidToggle:(id)sender {
    [self.delegate todoCell:self didToggleCompleted:self.toggleButton.isSelected];
}

@end
