//
//  PrayersModel.h
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import "NSFetchedResultsModel.h"

@class User;
@interface PrayersModel : NSFetchedResultsModel

// (optional) User to filter by
@property (nonatomic, weak) User *user;

@end
