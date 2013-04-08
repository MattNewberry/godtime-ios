//
//  UsersTableViewController.h
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkedTableViewController.h"

@interface UsersTableViewController : NetworkedTableViewController

- (IBAction)cancel:(UIStoryboardSegue *)segue;
- (IBAction)save:(UIStoryboardSegue *)segue;

- (IBAction)enterEditMode:(id)sender;

@end
