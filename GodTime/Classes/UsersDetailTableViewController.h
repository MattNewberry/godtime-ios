//
//  UsersDetailTableViewController.h
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@interface UsersDetailTableViewController : UITableViewController

@property (nonatomic, weak) User *user;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end
