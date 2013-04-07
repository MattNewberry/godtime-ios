//
//  NSFetchedResultsModel.h
//  QuickCue
//
//  Created by Matthew Newberry on 11/28/12.
//  Copyright (c) 2012 Quickcue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSFetchedResultsModel : NSObject <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, readonly) NSArray *fetchedObjects;
@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;
@property (nonatomic, assign) BOOL isSearching;
@property (nonatomic, assign) BOOL disableAnimations;

- (void)reset;
- (void)searchWithText:(NSString *)text;

- (id)initWithSectionNameKeyPath:(NSString *)sectionNameKeyPath andCacheName:(NSString *)cacheName;

- (UITableViewCellStyle) cellStyle;
- (void)configureCell:(UITableViewCell *) cell withObject:(id) object atIndexPath:(NSIndexPath *) indexPath;
- (Class)cellClassForObject:(id) object;
- (BOOL)shouldFetchObjectForIndexPath:(NSIndexPath *) indexPath;

- (id)objectAtIndexPath:(NSIndexPath *) indexPath;
- (NSIndexPath *)indexPathForObject:(id) object;

- (NSIndexPath *)mapFRCIndexPathToTableViewIndexPath:(NSIndexPath *)indexPath;

@end
