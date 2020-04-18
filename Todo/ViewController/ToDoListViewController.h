//
//  ViewController.h
//  Todo
//
//  Created by Rufus on 17/04/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoListViewModel.h"

@interface ToDoListViewController : UIViewController<TodoListView, UITableViewDataSource>
@end

