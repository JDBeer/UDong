//
//  Tool.h
//  Udong
//
//  Created by wildyao on 15/11/27.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface Tool : NSObject

+ (AppDelegate *)appDelegate;

// 是否是有效号码
+ (BOOL)validateMobile:(NSString *)moblieNumber;
// 字符串是否是double类型
+ (BOOL)isPureDouble:(NSString *)string;
// 字符串是否全为空格
+ (BOOL)isAllSpaceString:(NSString *)string;


+ (NSString *)removeAllWhiteSpace:(NSString *)originalString;
+ (id)safeString:(id)originalObj replaceString:(NSString *)replaceString;
+ (id)safeString:(id)originalObj additionalString:(NSString *)additionalString;
+ (NSString *)timeWithDate:(NSDate *)date dateFormatter:(NSDateFormatter *)dateFormatter;

//+ (NSString *)transFromPinyin:(NSString *)word;


@end
