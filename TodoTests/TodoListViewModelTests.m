//
//  TodoTests.m
//  TodoTests
//
//  Created by Rufus on 17/04/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ToDoListViewModel.h"

@interface ToDoListViewMock : NSObject<TodoListView>
@property (strong,nonnull) XCTestExpectation* expectation;
@property (nonatomic) BOOL didReload;
@property (nonatomic) BOOL didUpdateWithChanges;
-(instancetype)init: (XCTestExpectation*)expectation;
@end

@implementation ToDoListViewMock
- (instancetype)init:(XCTestExpectation *)expectation {
    self = [super init];
    if (self) {
        self.expectation = expectation;
        _didReload = NO;
        _didUpdateWithChanges = NO;
    }
    return self;
}

- (void)showError:(nonnull NSString *)error {
    
}

- (void)reloadItems {
    self.didReload = YES;
    [self.expectation fulfill];
}

- (void)updateWithChanges:(nonnull RLMCollectionChange *)changes {
    self.didUpdateWithChanges = YES;
    [self.expectation fulfill];
}

@end

@interface TodoListViewModelTests : XCTestCase
@property (strong,nonnull) ToDoListViewModel* viewModel;
@property (strong,nonnull) RLMRealm* realm;
@property (strong,nonnull) ToDoListViewMock* view;
@end

@implementation TodoListViewModelTests

- (void)setUp {
    XCTestExpectation* expectation = [[XCTestExpectation alloc]initWithDescription:@"viewChangedExpection"];
    self.view = [[ToDoListViewMock alloc] init:expectation];
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.inMemoryIdentifier = [self randomStringWithLength: 100]; //make sure not shared between tests
    self.realm = [RLMRealm realmWithConfiguration:config error:nil];
    self.viewModel = [[ToDoListViewModel alloc]init:self.realm view:self.view];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testTitleSet {
    [self.viewModel start];
    XCTAssertTrue([self.viewModel.title isEqualToString:@"Todo"]);
}

- (void)testInitialLoadEmpty {
    [self.viewModel start];
    XCTAssertEqual(self.viewModel.rowCount, 0);
}

- (void)testInitialLoad2Items {
    ToDo* todo1 = [[ToDo alloc] init];
    todo1.name = @"Clean Room";
    
    ToDo* todo2 = [[ToDo alloc] init];
    todo2.name = @"Wipe floor";
    
    NSArray<ToDo*>* items = @[todo1, todo2];
    [self.realm transactionWithBlock:^{
        [self.realm addObjects: items];
    }];
    
    [self.viewModel start];
    
    XCTAssertEqual(self.viewModel.rowCount, 2);
}

-(void)testAddToDo {
    XCTAssertEqual(self.viewModel.rowCount, 0);
    [self.viewModel start];
    
    ToDo* todo = [[ToDo alloc] init];
    todo.name = @"Clean Desk";
    [self.viewModel addTodo: todo];
    
    XCTAssertEqual(self.viewModel.rowCount, 1);
}

-(void)testSaveToDo {
    XCTAssertEqual(self.viewModel.rowCount, 0);
    [self.viewModel start];
    
    ToDo* todo = [[ToDo alloc] init];
    todo.name = @"Clean Desk";
    [self.viewModel addTodo: todo];
    
    [self.viewModel updateTodoAtRow:0 withText:@"Text Updated"];
    TodoItemViewModel* viewModelItem = [self.viewModel itemForRow:0];
    XCTAssertTrue([viewModelItem.name isEqualToString: @"Text Updated"]);
}

-(void)testDeleteToDo {
    XCTAssertEqual(self.viewModel.rowCount, 0);
    [self.viewModel start];
    
    ToDo* todo = [[ToDo alloc] init];
    todo.name = @"Clean Desk";
    [self.viewModel addTodo: todo];
    XCTAssertEqual(self.viewModel.rowCount, 1);
    
    [self.viewModel deleteToDoAtRow: 0];
    XCTAssertEqual(self.viewModel.rowCount, 0);
}

#pragma mark - test notifications

-(void)testReloadTriggeredOnEmpty {
    [self.viewModel start];
    [self waitForExpectations:@[self.view.expectation] timeout:2.0];
    
    XCTAssertTrue(self.view.didReload);
}

-(void)testChangesTriggeredOnInsert {
    ToDo* todo1 = [[ToDo alloc] init];
    todo1.name = @"Clean Room";
    
    ToDo* todo2 = [[ToDo alloc] init];
    todo2.name = @"Wipe floor";
    
    NSArray<ToDo*>* items = @[todo1, todo2];
  
    [self.viewModel start];
    self.view.expectation.expectedFulfillmentCount = 2;
    [self.realm transactionWithBlock:^{
          [self.realm addObjects: items];
      }];
    
    [self waitForExpectations:@[self.view.expectation] timeout:2.0];
    XCTAssertTrue(self.view.didReload);
    XCTAssertTrue(self.view.didUpdateWithChanges);
}

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

-(NSString*)randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

@end
