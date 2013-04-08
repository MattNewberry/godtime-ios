//
//  PrayersAddTableViewController.h
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User, Prayer;
@interface PrayersAddTableViewController : UITableViewController

@property (nonatomic, strong) User *selectedUser;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Prayer *prayer;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *titleField;
@property (unsafe_unretained, nonatomic) IBOutlet UITextView *prayerField;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *userLabel;

- (IBAction)selectUser:(UIStoryboardSegue *)segue;
@end
