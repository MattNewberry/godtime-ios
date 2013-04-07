//
//  NSFetchedResultsModel.m
//  QuickCue
//
//  Created by Matthew Newberry on 11/28/12.
//  Copyright (c) 2012 Quickcue. All rights reserved.
//

#import "NSFetchedResultsModel.h"
#import "AppDelegate.h"

@interface NSFetchedResultsModel ()

@property (nonatomic, readonly) NSManagedObjectContext *context;
@property (nonatomic, assign) BOOL isUpdatingTable;
@property (nonatomic, strong) NSString *sectionNameKeyPath;
@property (nonatomic, strong) NSString *cacheName;
@property (nonatomic, strong) NSFetchedResultsController *searchFetchedResultsController;
@property (nonatomic, readonly) NSFetchedResultsController *activeFetchedResultsController;

@end

@implementation NSFetchedResultsModel

- (void)searchWithText:(NSString *)text
{
    assert([NSThread currentThread].isMainThread);
    
    NSPredicate *predicate = self.fetchRequest.predicate;
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"name beginswith[cd] %@", text];
    
    self.searchFetchedResultsController.fetchRequest.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[predicate, searchPredicate]];
    
    NSError *error;
    [self.searchFetchedResultsController performFetch:&error];
    
    if (error != nil) {
		NSLog(@"%@", error);
	}
}

- (void) reset
{
    self.fetchedResultsController.delegate = nil;
    self.fetchedResultsController = nil;
    
    [self.tableView reloadData];
}

- (NSManagedObjectContext *)context
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.managedObjectContext;
}

- (id)initWithSectionNameKeyPath:(NSString *)sectionNameKeyPath andCacheName:(NSString *)cacheName
{
	self = [super init];
	if (self)
	{
		self.sectionNameKeyPath = sectionNameKeyPath;
		self.cacheName = cacheName;
	}
	
	return self;
}

// Designed for subclassing when intermixing FRC rows with static rows
- (NSIndexPath *)mapFRCIndexPathToTableViewIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [[self.activeFetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{	
	id <NSFetchedResultsSectionInfo> sectionInfo = [[self.activeFetchedResultsController sections] objectAtIndex:section];
	
	return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	id object;
	
	if ([self shouldFetchObjectForIndexPath:indexPath])
		object = [self objectAtIndexPath:indexPath];
	
	Class cellClass = [self cellClassForObject:object];
	
	NSString *CellIdentifier = NSStringFromClass(cellClass);
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [[cellClass alloc] initWithStyle:[self cellStyle] reuseIdentifier:CellIdentifier];
	}
	
	[self configureCell:cell withObject:object atIndexPath:indexPath];
	
	return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 44;
}

- (void)insertRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)rowAnimation
{
	[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:rowAnimation];
}

- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)rowAnimation
{
	[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:rowAnimation];
}

#pragma mark Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - fetchedResultsController Delegation

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
	if (!_isUpdatingTable) {
		[self.tableView beginUpdates];
		_isUpdatingTable = YES;
	}
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
	 forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
						  withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
						  withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
	 forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    indexPath = [self mapFRCIndexPathToTableViewIndexPath:indexPath];
    newIndexPath = [self mapFRCIndexPathToTableViewIndexPath:newIndexPath];
    
    switch(type) {
		case NSFetchedResultsChangeInsert:
		{
            UITableViewRowAnimation animation = _disableAnimations ? UITableViewRowAnimationNone : UITableViewRowAnimationBottom;
			[self insertRowAtIndexPath:newIndexPath withRowAnimation:animation];
			
            break;
		}
        case NSFetchedResultsChangeDelete:
		{
            UITableViewRowAnimation animation = _disableAnimations ? UITableViewRowAnimationNone : UITableViewRowAnimationFade;
			[self deleteRowAtIndexPath:indexPath withRowAnimation:animation];
			
			break;
		}
			
        case NSFetchedResultsChangeMove:
		{
            UITableViewRowAnimation animation = _disableAnimations ? UITableViewRowAnimationNone : UITableViewRowAnimationFade;
			[self deleteRowAtIndexPath:indexPath withRowAnimation:animation];
            [self insertRowAtIndexPath:newIndexPath withRowAnimation:animation];
		}
			break;
			
		case NSFetchedResultsChangeUpdate:
		{
			[self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] withObject:[self objectAtIndexPath:indexPath] atIndexPath:indexPath];
		}
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
	if (_isUpdatingTable) {
		[self.tableView endUpdates];
	}
	_isUpdatingTable = NO;
}

- (UITableViewCellStyle) cellStyle
{
    return UITableViewCellStyleDefault;
}

- (void)configureCell:(UITableViewCell *) cell withObject:(id) object atIndexPath:(NSIndexPath *) indexPath
{
	
}

- (Class)cellClassForObject:(id) object
{
	return [UITableViewCell class];
}

- (BOOL)shouldFetchObjectForIndexPath:(NSIndexPath *) indexPath
{
	return YES;
}

#pragma mark Utilities
- (NSArray *)fetchedObjects
{
    return self.activeFetchedResultsController.fetchedObjects;
}

- (id)objectAtIndexPath:(NSIndexPath *) indexPath
{
	id object;
	
	@try {
		object = [self.activeFetchedResultsController objectAtIndexPath:indexPath];
	}
	@catch (NSException *exception) {
		NSLog(@"Invalid object at indexPath %@", indexPath);
	}
	
	return object;
}

- (NSIndexPath *) indexPathForObject:(id) object
{
	return [self.activeFetchedResultsController indexPathForObject:object];
}

#pragma mark - Getter

- (NSFetchedResultsController *)activeFetchedResultsController
{
    NSFetchedResultsController *frc = self.isSearching ? self.searchFetchedResultsController : self.fetchedResultsController;
    return frc;
}

- (UITableView *)tableView
{
    UITableView *tv = self.isSearching ? self.searchDisplayController.searchResultsTableView : _tableView;
    return tv;
}

- (NSFetchRequest *)fetchRequest
{
	return nil;
}

- (NSFetchedResultsController *) fetchedResultsController
{
	if (_fetchedResultsController != nil)
		return _fetchedResultsController;
		
    NSFetchRequest *request = [self fetchRequest];
    if(!request) return nil;
    
	_fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.context sectionNameKeyPath:_sectionNameKeyPath cacheName:_cacheName];
	_fetchedResultsController.delegate = self;
	
	NSError *error;
	[_fetchedResultsController performFetch:&error];
	
	if (error != nil) {
		NSLog(@"%@", error);
	}
	
	return _fetchedResultsController;
}

- (NSFetchedResultsController *) searchFetchedResultsController
{
	if (_searchFetchedResultsController != nil)
		return _searchFetchedResultsController;
		
	_searchFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:[self fetchRequest] managedObjectContext:self.context sectionNameKeyPath:_sectionNameKeyPath cacheName:nil];
	_searchFetchedResultsController.delegate = self;
	
	return _searchFetchedResultsController;
}

@end
