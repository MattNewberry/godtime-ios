//
//  UsersModel.m
//  GodTime
//
//  Created by Matthew Newberry on 4/7/13.
//  Copyright (c) 2013 Co.Lab. All rights reserved.
//

#import "UsersModel.h"
#import "User.h"

@implementation UsersModel

- (NSFetchRequest *)fetchRequest
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"first_name" ascending:YES]];
    
    return request;
}

- (void)configureCell:(UITableViewCell *)cell withObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    User *user = (User *)object;
    cell.textLabel.text = user.first_name;
}

@end
