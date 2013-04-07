//
//  NetworkedTableViewController.m
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import "NetworkedTableViewController.h"
#import "NSFetchedResultsModel.h"
#import <AFIncrementalStore/AFIncrementalStore.h>


@interface NetworkedTableViewController ()

@end

@implementation NetworkedTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.model = [[[self modelClass] alloc] initWithSectionNameKeyPath:nil andCacheName:nil];
    self.model.tableView = self.tableView;
    
    self.tableView.dataSource = self.model;
    self.tableView.delegate = self.model;

    self.refreshCtl = [[UIRefreshControl alloc] init];
    [_refreshCtl addTarget:_model action:@selector(reset) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = _refreshCtl;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishLoading) name:AFIncrementalStoreContextDidFetchRemoteValues object:nil];
}

- (Class)modelClass
{
    return NSClassFromString(@"NSFetchedResultsModel");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didFinishLoading
{
    [self.refreshControl endRefreshing];
}

@end
