//
//  Common.h
//  transactions
//
//  Created by Matthew Newberry on 4/1/13.
//  Copyright (c) 2013 Matthew Newberry. All rights reserved.
//

#import <Foundation/Foundation.h>

CGRect CGRectIntegralScaledEx(CGRect rect, CGFloat scale);

CGRect CGRectIntegralScaled(CGRect rect);

CGRect CGRectIntegralMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height);

UIColor *hexColor(NSString *hex);
CGColorRef cgHexColorRef(NSString *hex);

UIColor *hexColorWithAlpha(NSString *hex, CGFloat alpha);
CGColorRef cgHexColorRefWithAlpha(NSString *hex, CGFloat alpha);