//
//  PrayersDetailTableViewController.h
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Prayer;
@interface PrayersDetailTableViewController : UITableViewController

@property (nonatomic, weak) Prayer *prayer;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *prayerLabel;

@end
