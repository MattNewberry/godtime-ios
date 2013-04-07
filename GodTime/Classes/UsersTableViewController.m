//
//  UsersTableViewController.m
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import "UsersTableViewController.h"
#import "UsersModel.h"

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
