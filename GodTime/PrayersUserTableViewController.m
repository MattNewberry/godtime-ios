//
//  PrayersUserTableViewController.m
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import "PrayersUserTableViewController.h"
#import "UsersModel.h"
#import "UsersDetailTableViewController.h"
#import "PrayersAddTableViewController.h"

@interface PrayersUserTableViewController ()

@end

@implementation PrayersUserTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"People", @"People");
}

- (Class)modelClass
{
    return [UsersModel class];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    PrayersAddTableViewController *vc = [segue destinationViewController];
    vc.user = [self.model objectAtIndexPath:path];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
