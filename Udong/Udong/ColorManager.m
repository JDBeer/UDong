//
//  ColorManager.m
//  Udong
//
//  Created by wildyao on 15/11/17.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "ColorManager.h"

@implementation ColorManager

+ (UIColor *)getColor:(NSString *)Color WithAlpha:(CGFloat)Alpha
{
    unsigned int red,green,blue;
    NSRange range = NSMakeRange(0, 2);
    [[NSScanner scannerWithString:[Color substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[Color substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[Color substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:Alpha];
}

@end
