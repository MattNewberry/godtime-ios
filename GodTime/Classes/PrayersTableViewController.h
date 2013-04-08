//
//  PrayersTableViewController.h
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkedTableViewController.h"

@class User;
@interface PrayersTableViewController : NetworkedTableViewController

- (IBAction)cancel:(UIStoryboardSegue *)segue;
- (IBAction)save:(UIStoryboardSegue *)segue;

- (IBAction)enterEditMode:(id)sender;

// (optional) User to filter by
@property (nonatomic, weak) User *user;

@end
