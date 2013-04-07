//
//  PrayersModel.m
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import "PrayersModel.h"
#import "Prayer.h"

@implementation PrayersModel

- (NSFetchRequest *)fetchRequest
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Prayer"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"created_at" ascending:YES]];
    
    return request;
}

- (void)configureCell:(UITableViewCell *)cell withObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    Prayer *prayer = (Prayer *)object;
    cell.textLabel.text = prayer.title;
}

@end
