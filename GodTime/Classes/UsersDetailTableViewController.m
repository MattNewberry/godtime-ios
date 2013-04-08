//
//  UsersDetailTableViewController.m
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import "UsersDetailTableViewController.h"
#import "User.h"
#import "PrayersTableViewController.h"

@interface UsersDetailTableViewController ()

@end

@implementation UsersDetailTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@", _user.first_name];
    self.emailLabel.text = _user.email;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PrayersTableViewController *vc = [segue destinationViewController];
    vc.user = _user;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
