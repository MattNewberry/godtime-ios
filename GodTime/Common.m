//
//  Common.m
//  transactions
//
//  Created by Matthew Newberry on 4/1/13.
//  Copyright (c) 2013 Matthew Newberry. All rights reserved.
//

#import "Common.h"
#import "UIColor+Additions.h"

CGRect CGRectIntegralScaledEx(CGRect rect, CGFloat scale)
{
    return CGRectMake(floorf(rect.origin.x * scale) / scale, floorf(rect.origin.y * scale) / scale, ceilf(rect.size.width * scale) / scale, ceilf(rect.size.height * scale) / scale);
}

CGRect CGRectIntegralScaled(CGRect rect)
{
    return CGRectIntegralScaledEx(rect, [[UIScreen mainScreen] scale]);
}

CGRect CGRectIntegralMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    return CGRectIntegralScaledEx(CGRectMake(x, y, width, height), [[UIScreen mainScreen] scale]);
}

UIColor *hexColor(NSString *hex)
{
    return hexColorWithAlpha(hex, 1.f);
}

CGColorRef cgHexColorRef(NSString *hex)
{
    return cgHexColorRefWithAlpha(hex, 1.f);
}

UIColor *hexColorWithAlpha(NSString *hex, CGFloat alpha)
{
    return [UIColor colorWithHexString:hex withAlpha:alpha];
}

CGColorRef cgHexColorRefWithAlpha(NSString *hex, CGFloat alpha)
{
    return hexColorWithAlpha(hex, alpha).CGColor;
}