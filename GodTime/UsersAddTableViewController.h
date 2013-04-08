//
//  UsersAddTableViewController.h
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@interface UsersAddTableViewController : UITableViewController

@property (nonatomic, assign) User *user;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *nameField;

@end
