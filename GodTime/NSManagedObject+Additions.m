//
//  NSManagedObject+Additions.m
//  QuickCue
//
//  Created by Matthew Newberry on 9/25/12.
//  Copyright (c) 2012 Quickcue. All rights reserved.
//

#import "NSManagedObject+Additions.h"
#import "AppDelegate.h"

@implementation NSManagedObject (Additions)
static NSManagedObjectContext *context;

#pragma mark -
#pragma mark Object Setup

+ (NSManagedObjectContext *) managedObjectContext
{
    if(!context) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        context = delegate.managedObjectContext;
    }
	
    return context;
}

+ (NSEntityDescription *) entityDescription
{
	return [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:[self managedObjectContext]];
}

+ (NSFetchRequest *)fetchRequest
{
	NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
	[fetch setEntity:[self entityDescription]];
    [fetch setFetchBatchSize:20];
        
	return fetch;
}

#pragma mark -
#pragma mark Saving

+ (BOOL)save
{
    
	NSManagedObjectContext *context = [self managedObjectContext];
	BOOL successful = YES;
	
    if (![context hasChanges])
        return successful;
	
    int insertedObjectsCount = [[context insertedObjects] count];
	int updatedObjectsCount = [[context updatedObjects] count];
	int deletedObjectsCount = [[context deletedObjects] count];
    
	NSDate *startTime = [NSDate date];
	    
	NSError *error;
    @try {
        successful = [context save:&error];
    }
    @catch (NSException *exception) {
		successful = NO;
        error = [NSError errorWithDomain:@"CoreDataError"
                                    code:0
                                userInfo:@{ @"exception": exception }];
		      
        NSLog(@"CORE DATA FAILURE: %@", [exception reason]);
		NSArray* detailedErrors = [error userInfo][NSDetailedErrorsKey];
		
		if (detailedErrors != nil && [detailedErrors count] > 0) {
			for (NSError* detailedError in detailedErrors) {
				NSLog(@"  DetailedError: %@", [detailedError userInfo]);
			}
		}
    }
	
    NSLog(@"%@", [NSString stringWithFormat:@"Created: %i, Updated: %i, Deleted: %i, Time: %f seconds", insertedObjectsCount, updatedObjectsCount, deletedObjectsCount, ([startTime timeIntervalSinceNow] *-1)]);
    
    if (!successful) {
        NSLog(@"%@", error);
    }
    
    return successful;
}

- (BOOL)save
{
    return [[self class] save];
}

#pragma mark -
#pragma mark Blank Record

+ (id) blank
{
    return [[self alloc] initWithEntity:[self entityDescription] insertIntoManagedObjectContext:[self managedObjectContext]];
}


#pragma mark -
#pragma mark Removing

+ (void)removeAll
{
	[self removeAllWithPredicate:nil];
}

+ (void)removeAllWithPredicate:(NSPredicate *)predicate
{
	NSFetchRequest *request = [self fetchRequest];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [[self managedObjectContext] executeFetchRequest:request error:&error];
    
    if (!results) {
        NSLog(@"%@", error);
        return;
    }
    
    [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
		
        [obj remove];
    }];
}

- (void)remove
{
	[[self managedObjectContext] deleteObject:self];
}


#pragma mark -
#pragma mark Counting

+ (NSUInteger)count
{
	return [self countWithPredicate:nil];
}

+ (NSUInteger)countWithPredicate:(NSPredicate *)predicate
{
	NSError *error;
	NSFetchRequest *fetch = [self fetchRequest];
	[fetch setPredicate:predicate];

    NSUInteger result = [[self managedObjectContext] countForFetchRequest:fetch error:&error];
	if (error) {
        NSLog(@"%@", error);
        return 0;
    }
    
    return result;
}

#pragma mark -
#pragma mark Searching

+ (id) first
{
    NSArray *results = [self findWithPredicate:nil sortKey:nil ascending:NO withLimit:1];
    
    return [results count] == 1 ? results[0] : nil;
}

+ (id) last
{
    NSArray *results = [self all];
    
    return [results count] > 0 ? [results lastObject] : nil;
}

+ (NSArray *)all
{
    return [self allSortedBy:nil ascending:NO];
}

+ (NSArray *)allSortedBy:(NSString *)sortBy ascending:(BOOL)ascending
{
    return [self findWithPredicate:nil sortKey:sortBy ascending:ascending withLimit:0];
}

+ (NSArray *)findWithPredicate:(NSPredicate *)predicate
{
    return [self findWithPredicate:predicate sortKey:nil ascending:NO withLimit:0];
}

+ (NSArray *)findWithPredicate:(NSPredicate *)predicate sortKey:(NSString *)sortKey ascending:(BOOL)ascending withLimit:(NSUInteger)limit
{
    NSError *error;
    NSFetchRequest *request = [self fetchRequest];
    [request setPredicate:predicate];
    
    if ([sortKey length] > 0)
        [request setSortDescriptors:[NSSortDescriptor sortDescriptorWithKey:sortKey ascending:ascending]];
    
    if (limit > 0)
        [request setFetchLimit:limit];
    
    NSArray *result = [[self managedObjectContext] executeFetchRequest:request error:&error];
    if (!result) {
        NSLog(@"%@", error);
        return nil;
    }
    
    return result;
}

+ (NSArray *)findWhereAttribute:(NSString *)attribute contains:(id)value
{
    return [self findWithPredicate:[NSPredicate predicateWithFormat:@"%K CONTAINS %@", attribute, value]];
}

+ (NSArray *)findWhereAttribute:(NSString *)attribute equals:(id)value
{
    return [self findWithPredicate:[NSPredicate predicateWithFormat:@"%K == %@", attribute, value]];
}


#pragma mark -
#pragma mark Aggregates

+ (NSNumber *)aggregateForKeyPath:(NSString *)keyPath
{
    NSArray *results = [[self class] all];
    
    return [results valueForKeyPath:keyPath];
}

+ (NSNumber *)average:(NSString *)attribute
{
    return [self aggregateForKeyPath:[NSString stringWithFormat:@"@avg.%@", attribute]];
}

+ (NSNumber *)minimum:(NSString *)attribute
{
    return [self aggregateForKeyPath:[NSString stringWithFormat:@"@min.%@", attribute]];
}

+ (NSNumber *)maximum:(NSString *)attribute
{
    return [self aggregateForKeyPath:[NSString stringWithFormat:@"@max.%@", attribute]];
}

+ (NSNumber *)sum:(NSString *)attribute{
    
    return [self aggregateForKeyPath:[NSString stringWithFormat:@"@sum.%@", attribute]];
}

@end
