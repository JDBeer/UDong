//
//  LocalHelper.m
//  Udong
//
//  Created by wildyao on 16/3/9.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "LocalHelper.h"

@implementation LocalHelper

+ (NSMutableDictionary *)getLocalDic
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"aa.plist"];
    NSMutableDictionary *plistDic = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
    return plistDic;
}

@end
