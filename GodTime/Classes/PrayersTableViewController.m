//
//  PrayersTableViewController.m
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import "PrayersTableViewController.h"
#import "PrayersModel.h"

@interface PrayersTableViewController ()

@property (nonatomic, strong) PrayersModel *model;

@end

@implementation PrayersTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Prayers", @"Prayers");
}

- (Class)modelClass
{
    return [PrayersModel class];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
