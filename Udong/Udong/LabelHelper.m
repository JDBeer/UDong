//
//  LabelHelper.m
//  Udong
//
//  Created by wildyao on 16/3/9.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "LabelHelper.h"

@implementation LabelHelper

+ (CGSize)getSizeWith:(NSString *)string font:(NSInteger)font
{
    CGSize size = [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:FONT(font),NSFontAttributeName, nil]];
    
    return size;
}


@end
