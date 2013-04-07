//
//  Reminder.h
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Prayer, User;

@interface Reminder : NSManagedObject

@property (nonatomic, retain) NSString * weekday;
@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) Prayer *prayer;

@end
