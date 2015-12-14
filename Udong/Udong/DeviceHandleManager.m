//
//  DeviceHandleManager.m
//  Udong
//
//  Created by wildyao on 15/12/8.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "DeviceHandleManager.h"
#import "OpenUDID.h"
#import "sys/utsname.h"

@implementation DeviceHandleManager
+ (NSMutableDictionary *)configureBaseData
{
    NSMutableDictionary *deviceData = [[NSMutableDictionary alloc] init];
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    NSString * deviceOS = [deviceName substringToIndex:([deviceName length]-3)];
    [deviceData setObject:deviceOS forKey:DeviceOSKey];
    
    NSString *deviceIsn = [OpenUDID value];
    [deviceData setObject:deviceIsn forKey:OpenUdidKey];
    
    NSString *deviceModel = [self deviceModelMethod];
    [deviceData setObject:deviceModel forKey:DcviceModelKey];
    
    CGRect rect_screen = [[UIScreen mainScreen] bounds];
    CGSize size_screen = rect_screen.size;
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    CGFloat width = scale_screen*size_screen.width;
    CGFloat height = scale_screen*size_screen.height;
    CGSize size = CGSizeMake(width, height);
    NSString *deviceResolution = NSStringFromCGSize(size);
    [deviceData setObject:deviceResolution forKey:DeviceResolutionKey];
    
    NSString *phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSString *deviceVersion = [NSString stringWithFormat:@"手机系统版本:%@",phoneVersion];
    [deviceData setObject:deviceVersion forKey:DeviceVersionKey];
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [NSString stringWithFormat:@"%@",infoDic[@"CFBundleShortVersionString"]];
    [deviceData setObject:currentVersion forKey:DeviceAPPVersionKey];
    
    return deviceData;
    
}

+ (NSString *)deviceModelMethod
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    
    return deviceString;
}


@end
