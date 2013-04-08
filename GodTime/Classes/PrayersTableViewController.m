//
//  PrayersTableViewController.m
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import "PrayersTableViewController.h"
#import "PrayersModel.h"
#import "PrayersDetailTableViewController.h"
#import "PrayersAddTableViewController.h"

@interface PrayersTableViewController ()

@property (nonatomic, strong) PrayersModel *model;

@end

@implementation PrayersTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Prayers", @"Prayers");
    self.model.user = _user;
    
    self.tableView.delegate = self;
}

- (Class)modelClass
{
    return [PrayersModel class];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PrayerDetail"]) {
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        PrayersDetailTableViewController *vc = [segue destinationViewController];
        vc.prayer = [self.model objectAtIndexPath:path];
        
    } else if([segue.identifier isEqualToString:@"AddPrayer"]) {
        UINavigationController *nav = [segue destinationViewController];
        PrayersAddTableViewController *addVC = [nav visibleViewController];
        addVC.selectedUser = _user;
    }
}

- (void)setUser:(User *)user
{
    _user = user;
    
    self.model.user = user;
    
    if(_user) {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (IBAction)save:(UIStoryboardSegue *)segue
{
    [self cancel:segue];
}

- (IBAction)cancel:(UIStoryboardSegue *)segue
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self.model reset];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterEditMode:(id)sender
{
    self.tableView.editing = !self.tableView.editing;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
