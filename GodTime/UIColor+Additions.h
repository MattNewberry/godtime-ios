//
//  UIColor+Additions.h
//  transactions
//
//  Created by Matthew Newberry on 4/1/13.
//  Copyright (c) 2013 Matthew Newberry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)

+ (UIColor *)colorWithRGBHex:(UInt32)hex alpha:(CGFloat) alpha;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert withAlpha:(CGFloat)alpha;

@end
