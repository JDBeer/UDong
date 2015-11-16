//
//  AppMacroDefinition.h
//  Udong
//
//  Created by wildyao on 15/11/16.
//  Copyright © 2015年 WuYue. All rights reserved.
//


#pragma mark - Common Constants

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]

#define ImageNamed(name) [UIImage imageNamed:name];

//系统版本
#pragma mark - System Versions

#define CurrentSystemVersions [[UIDevice currentDevice] systemVersion]
#define SYSTEM_VERSION_EQUAL_TO(v)                    ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYETEM_VERSION_GREAT_THAN(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//设备情况
#pragma mark - IOS Device

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH,SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH,SCREEN_HEIGHT))

#define IS_IPONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

//字体
#pragma mark - FONT

#define FONT(size) [UIFont systemFontOfSize:size]
#define FONT_BOLD(size) [UIFont boldSystemFontOfSize:size]

//颜色
#pragma mark - Color

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define UIColorFromHexWithAlpha(hexValue, a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]
#define UIColorFromHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

// 网络指示器
#pragma mark - NetWorkActivity
// 显示
#define NetworkActivityIndicatorVisible   [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
// 隐藏
#define NetworkActivityIndicatorInVisible [UIApplication sharedApplication].networkActivityIndicatorVisible = NO

#define StandardUserDefaults [NSUserDefaults standardUserDefaults]

// 是否是iPhone模拟器
#if TARGET_IPHONE_SIMULATOR
// iPhone Simulator
#endif

#pragma mark - Custom

#define TabNavigationItem self.tabBarController.navigationItem
#define SelfNavigationItem self.navigationItem

#define DatePickerDefaultHeight 216

#define ResetNavigation(name) \
TabNavigationItem.title = name; \
TabNavigationItem.titleView = nil; \
TabNavigationItem.leftBarButtonItems = nil; \
TabNavigationItem.rightBarButtonItems = nil; \
TabNavigationItem.leftBarButtonItem = nil; \
TabNavigationItem.rightBarButtonItem = nil; \

// UIPageControl
#define WIDTH_PAGECONTROL 100
#define HEIGHT_PAGECONTROL 20

// nav栏和tab栏
#define MARGIN_BAR_TOP 64
#define MARGIN_BAR_BOTTOM 49

// common margin
#define MARGIN_LEFT 15
#define MARGIN_RIGHT 15
#define MARGIN_TOP 20

// height
#define HEIGHT_NAVIGATIONBAR 44
#define HEIGHT_TABBAR 49
#define HEIGHT_LABEL 25
#define HEIGHT_CELL_DEFAULT 44
#define HEIGHT_TEXTFIELD 35
#define HEIGHT_FLATBUTTON 40
#define HEIGHT_HEADER 15
#define HEIGHT_FOOTER 15
#define HEIGHT_PROGRESS 10

