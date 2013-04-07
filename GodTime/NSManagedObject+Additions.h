//
//  NSManagedObject+Additions.h
//  QuickCue
//
//  Created by Matthew Newberry on 9/25/12.
//  Copyright (c) 2012 Quickcue. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Additions)

+ (NSManagedObjectContext *) managedObjectContext;

+ (NSEntityDescription *) entityDescription;

+ (NSFetchRequest *)fetchRequest;

+ (BOOL)save;

- (BOOL)save;

+ (id) blank;

- (void)remove;

+ (void)removeAll;

+ (void)removeAllWithPredicate:(NSPredicate *)predicate;



+ (NSUInteger)count;

+ (NSUInteger)countWithPredicate:(NSPredicate *)predicate;

+ (id) first;

+ (id) last;

+ (NSArray *)all;

+ (NSArray *)allSortedBy:(NSString *)sortKey ascending:(BOOL)ascending;

+ (NSArray *)findWithPredicate:(NSPredicate *)predicate;

+ (NSArray *)findWithPredicate:(NSPredicate *)predicate sortKey:(NSString *)sortKey ascending:(BOOL)ascending withLimit:(NSUInteger)limit;

+ (NSArray *)findWhereAttribute:(NSString *)attribute equals:(id) value;

+ (NSArray *)findWhereAttribute:(NSString *)attribute contains:(id) value;

+ (NSNumber *)average:(NSString *)attribute;

+ (NSNumber *)minimum:(NSString *)attribute;

+ (NSNumber *)maximum:(NSString *)attribute;

+ (NSNumber *)sum:(NSString *)attribute;


@end
