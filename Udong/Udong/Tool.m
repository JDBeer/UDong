//
//  Tool.m
//  Udong
//
//  Created by wildyao on 15/11/27.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "Tool.h"

@implementation Tool

+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (BOOL)validateMobile:(NSString *)moblieNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:moblieNumber] == YES)
        || ([regextestcm evaluateWithObject:moblieNumber] == YES)
        || ([regextestct evaluateWithObject:moblieNumber] == YES)
        || ([regextestcu evaluateWithObject:moblieNumber] == YES)) {
        return YES;
    } else {
        return NO;
    }
    
    //    NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    //
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //
    //    if (([regextestmobile evaluateWithObject:mobileNum] == YES) {
    //        return YES;
    //    } else {
    //        return NO;
    //    }

}

+ (BOOL)isPureDouble:(NSString *)string
{
    NSScanner *scan = [NSScanner scannerWithString:string];
    double val;
    return [scan scanDouble:&val] && [scan isAtEnd];
}

+ (BOOL)isAllSpaceString:(NSString *)string
{
    return ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0);
}

+ (NSString *)removeAllWhiteSpace:(NSString *)originalString
{
    return [originalString stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+ (id)safeString:(id)originalObj replaceString:(NSString *)replaceString
{
    if (!originalObj) {
        return replaceString;
    }
    
    if ([originalObj isKindOfClass:[NSString class]]) {
        if ([(NSString *)originalObj length] == 0) {
            return replaceString;
        }
    }
    
    if ([originalObj isKindOfClass:[NSNull class]]) {
        return replaceString;
    }
    
    return originalObj;
}

+ (id)safeString:(id)originalObj additionalString:(NSString *)additionalString
{
    if (!originalObj) {
        return additionalString;
    }
    
    if ([originalObj isKindOfClass:[NSString class]]) {
        if ([(NSString *)originalObj length] == 0) {
            return additionalString;
        } else {
            return [NSString stringWithFormat:@"%@%@", additionalString, (NSString *)originalObj];
        }
    }
    
    if ([originalObj isKindOfClass:[NSNull class]]) {
        return additionalString;
    }
    
    return originalObj;
}

+ (NSString *)timeWithDate:(NSDate *)date dateFormatter:(NSDateFormatter *)dateFormatter
{
    NSString *time = nil;
    
    if ([self isToday:date]) {
        NSDate *currentDate = [NSDate date];
        NSTimeInterval interval = [currentDate timeIntervalSinceDate:date];
        NSInteger minute = interval/60;
        
        if (minute == 0) {
            time = [NSString stringWithFormat:@"刚刚"];   // 一分钟之内
        } else if (minute > 0 && minute < 60) {          // 1小时之内
            time = [NSString stringWithFormat:@"%ld分钟前", minute];
        } else {                                        // 一小时之前
            time = [NSString stringWithFormat:@"%ld小时前", minute/60];
        }
    } else if ([self isYesterday:date]) {
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString *dateStr = [dateFormatter stringFromDate:date];
        time = [NSString stringWithFormat:@"昨天 %@", dateStr];
    } else {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *dateStr = [dateFormatter stringFromDate:date];
        time = [NSString stringWithFormat:@"%@", dateStr];
    }
    
    return time;

}

+ (BOOL)isYesterday:(NSDate *)currentDate;
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 主要是去掉后面的 分钟 秒
    NSDate *now = [NSDate date];
    NSString *dateStr = [fmt stringFromDate:currentDate];
    NSString *nowStr = [fmt stringFromDate:now];
    
    NSDate *date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calender components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

+ (BOOL)isToday:(NSDate *)currentDate;
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *now = [NSDate date];
    NSString *dateStr = [fmt stringFromDate:currentDate];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}

/**
 *  判断日期是否是今年
 */
- (BOOL)isThisYear:(NSDate *)date
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calender components:NSCalendarUnitYear fromDate:date];
    NSDateComponents *nowCmps = [calender components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}


//+ (NSString *)transFromPinyin:(NSString *)word;
//{
//    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, CFSTR(word));
//    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
//    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
//    return string;
//    
//}



@end
