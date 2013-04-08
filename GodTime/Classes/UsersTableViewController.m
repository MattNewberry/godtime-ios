//
//  UsersTableViewController.m
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import "UsersTableViewController.h"
#import "UsersModel.h"
#import "UsersDetailTableViewController.h"

@interface UsersTableViewController ()

@end

@implementation UsersTableViewController

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
    if([segue.identifier isEqualToString:@"UserDetailSegue"]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        UsersDetailTableViewController *vc = [segue destinationViewController];
        vc.user = [self.model objectAtIndexPath:path];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(UIStoryboardSegue *)segue
{
    [self cancel:segue];
}

- (IBAction)cancel:(UIStoryboardSegue *)segue
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)enterEditMode:(id)sender
{
    self.tableView.editing = !self.tableView.editing;
}

@end
