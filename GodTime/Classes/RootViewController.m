//
//  RootViewController.m
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import "RootViewController.h"

#define kDailyVerseKey  @"last_used_daily_verse"

@interface RootViewController ()

@property (nonatomic, strong) NSDictionary *verseOfTheDay;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _verseLabel.text = [NSString stringWithFormat:@"%@ - %@", [self.verseOfTheDay allValues][0], [self.verseOfTheDay allKeys][0]];
}

- (NSDictionary *)verseOfTheDay
{
    if(_verseOfTheDay) {
        return _verseOfTheDay;
    }
    
    // Verses are keyed of the day
    // If the defaults already have an entry for today, we skip looking for one
    // Else, we parse the json file of verses and store one for today using `dateKey`
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    NSString *dateKey = [dateFormatter stringFromDate:[NSDate date]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *lastUsedVerse = [defaults dictionaryForKey:kDailyVerseKey];
    if(!lastUsedVerse || ![[lastUsedVerse allKeys] containsObject:dateKey]) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"daily_verses" ofType:@"json"];
        NSData *json = [[NSFileManager defaultManager] contentsAtPath:filePath];
        
        NSError *error;
        NSDictionary *verses = [NSJSONSerialization JSONObjectWithData:json options:0 error:&error];
        
        if(error) {
            NSLog(@"%@", error);
        }
        
        NSString *key = [verses allKeys][0];
        if([defaults objectForKey:kDailyVerseKey]) {
            NSDictionary *existing = [lastUsedVerse allValues][0];
            NSInteger existingKeyIndex = [[verses allKeys] indexOfObject:[existing allKeys][0]];
            NSInteger nextKeyIndex = existingKeyIndex + 1;
            
            if(nextKeyIndex >= [verses count]) {
                nextKeyIndex = 0;
            }
            
            key = [verses allKeys][nextKeyIndex];
        }
        
        assert(key);
        
        _verseOfTheDay = @{key: verses[key]};
        [defaults setObject:@{dateKey : _verseOfTheDay} forKey:kDailyVerseKey];
        [defaults synchronize];
        
    } else {
        _verseOfTheDay = lastUsedVerse[dateKey];
    }
    
    return _verseOfTheDay;
}



@end
