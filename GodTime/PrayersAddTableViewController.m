//
//  PrayersAddTableViewController.m
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import "PrayersAddTableViewController.h"
#import "Prayer.h"
#import "User.h"
#import "NSManagedObject+Additions.h"

@interface PrayersAddTableViewController ()

@end

@implementation PrayersAddTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(!_prayer) {
        self.prayer = [Prayer blank];
        [_prayer save];
    }
        
    [_titleField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"SaveModal"]) {
        _prayer.title = _titleField.text;
        _prayer.text = _prayerField.text;
        [_prayer save];
    } else if([segue.identifier isEqualToString:@"CancelModal"]){
        [_prayer remove];
        [_prayer save];
    }
}

- (void)setUser:(User *)user
{
    _prayer.created_for = user;
    _userLabel.text = user.first_name;
}

- (IBAction)selectUser:(UIStoryboardSegue *)segue
{
}

- (void)viewDidUnload {
    [self setTitleField:nil];
    [self setPrayerField:nil];
    [self setUserLabel:nil];
    [super viewDidUnload];
}
@end
