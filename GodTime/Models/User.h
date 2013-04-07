//
//  User.h
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Prayer, Reminder;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSSet *prayers;
@property (nonatomic, retain) NSSet *praying_for;
@property (nonatomic, retain) NSSet *reminders;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addPrayersObject:(Prayer *)value;
- (void)removePrayersObject:(Prayer *)value;
- (void)addPrayers:(NSSet *)values;
- (void)removePrayers:(NSSet *)values;

- (void)addPraying_forObject:(Prayer *)value;
- (void)removePraying_forObject:(Prayer *)value;
- (void)addPraying_for:(NSSet *)values;
- (void)removePraying_for:(NSSet *)values;

- (void)addRemindersObject:(Reminder *)value;
- (void)removeRemindersObject:(Reminder *)value;
- (void)addReminders:(NSSet *)values;
- (void)removeReminders:(NSSet *)values;

@end
