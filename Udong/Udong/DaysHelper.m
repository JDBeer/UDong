//
//  DaysHelper.m
//  Udong
//
//  Created by wildyao on 16/2/29.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "DaysHelper.h"

@implementation DaysHelper

+ (NSInteger)getTodayZeroTime
{
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:[NSDate date]];
    [comps setHour:0];
    NSDate *zeroDate = [calender dateFromComponents:comps];
    NSInteger zeroInteger = [zeroDate timeIntervalSince1970];
    
    return zeroInteger;
}

+ (NSString *)getKeyDateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate date];
    NSString *nowDate = [formatter stringFromDate:date];
    return nowDate;
}

@end
