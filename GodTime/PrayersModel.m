//
//  PrayersModel.m
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import "PrayersModel.h"
#import "Prayer.h"
#import "NSManagedObject+Additions.h"

@implementation PrayersModel

- (NSFetchRequest *)fetchRequest
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Prayer"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"created_at" ascending:YES]];
    
    if(_user) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"created_for = %@", _user];
        request.predicate = predicate;
    }
    
    return request;
}

- (void)setUser:(User *)user
{
    _user = user;
    [self reset];
}

- (NSString *)cellIdentifier
{
    return @"PrayersCell";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Prayer *prayer = [self objectAtIndexPath:indexPath];
    [prayer remove];
    [prayer save];
}

- (void)configureCell:(UITableViewCell *)cell withObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    Prayer *prayer = (Prayer *)object;
    cell.textLabel.text = prayer.title;
    cell.detailTextLabel.text = prayer.text;
}

@end
