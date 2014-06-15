//
//  UIColor+PBColors.m
//  PBTicTacToe
//
//  Created by Kenan Pulak on 6/14/14.
//  Copyright (c) 2014 Kenan Pulak. All rights reserved.
//

#import "UIColor+PBColors.h"

@implementation UIColor (PBColors)

+ (UIColor*)PBBoardBackgroundColor{
    return [UIColor colorWithWhite:.3f alpha:1.f];
}

+ (UIColor*)PBBackgroundViewColor{
    return [UIColor darkGrayColor];
}

+ (UIColor*)PBGreenColor{
    return [UIColor colorWithHexString:@"27ae60" alpha:1.f];
}

+(UIColor*)PBNavigationBarTextColor{
    return [UIColor whiteColor];
}

- (UIColor *)initWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#"
                                                     withString:@"0x"];
    uint hexValue;
    if ([[NSScanner scannerWithString:hexString] scanHexInt:&hexValue]) {
        return [self initWithRed:((float) ((hexValue & 0xFF0000) >> 16)) / 255.0
                           green:((float) ((hexValue & 0xFF00) >> 8)) / 255.0
                            blue:((float) (hexValue & 0xFF)) / 255.0 alpha:alpha];
    } else {
        // invalid hex string
        return [self initWithWhite:0 alpha:alpha];
    }
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    return [[UIColor alloc] initWithHexString:hexString alpha:alpha];
}

@end
