//
//  AppDelegate.h
//  Udong
//
//  Created by wildyao on 15/11/16.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CurrentNetWorkNotReachable @"CurrentNetWorkNotReachable"
#define CurrentNetWorkReacherable @"CurrentNetWorkReacherable"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSString *secretString;
@property (nonatomic, strong) NSString *deviceisn;
@property (nonatomic, strong) NSString *deviceOS;
@property (nonatomic, strong) NSString *deviceModel;
@property (nonatomic, strong) NSString *deviceResolution;
@property (nonatomic, strong) NSString *deviceVersion;
@property (nonatomic, strong) NSString *userid;

- (void)showBanner;
- (void)hideBanner;


@end

