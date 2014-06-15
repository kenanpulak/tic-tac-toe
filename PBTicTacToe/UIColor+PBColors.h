//
//  UIColor+PBColors.h
//  PBTicTacToe
//
//  Created by Kenan Pulak on 6/14/14.
//  Copyright (c) 2014 Kenan Pulak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (PBColors)

+ (UIColor*)PBBoardBackgroundColor;
+ (UIColor*)PBBackgroundViewColor;
+ (UIColor*)PBGreenColor;
+ (UIColor*)PBNavigationBarTextColor;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
