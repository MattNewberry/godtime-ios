//
//  NetworkedTableViewController.h
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSFetchedResultsModel;
@interface NetworkedTableViewController : UITableViewController <UITableViewDelegate>

@property (nonatomic, strong) NSFetchedResultsModel *model;
@property (nonatomic, strong) UIRefreshControl *refreshCtl;

- (Class)modelClass;

@end
