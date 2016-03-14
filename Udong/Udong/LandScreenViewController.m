//
//  LandScreenViewController.m
//  Udong
//
//  Created by wildyao on 16/1/9.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "LandScreenViewController.h"
#import "LandScreenView.h"
#define ThreeHourInterval SCREEN_WIDTH/8

@interface LandScreenViewController ()

@end

@implementation LandScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    self.view.backgroundColor = kColorWhiteColor;
    
    
//由竖屏切换到横屏
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    
//配置三小时时间间隔
    
   self.timeArray = [[NSMutableArray alloc] init]; 
    for (int i=0; i<9; i++) {
        if (i<4) {
            NSString *timeString = [NSString stringWithFormat:@"0%d:00",i*3];
            [self.timeArray addObject:timeString];
        }else{
            NSString *timeString = [NSString stringWithFormat:@"%d:00",i*3];
            [self.timeArray addObject:timeString];
        }
    }
    
    
// 判断是否是当天的数据
    
    if (self.pointArray.count==0) {
       
        if ([self.titleString isEqualToString:@"今天"]) {
            self.landScreenView = [[LandScreenView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-44) width:SCREEN_WIDTH length:SCREEN_HEIGHT-44 count:9 interval:ThreeHourInterval dataArray:self.timeArray pointArray:self.pointArray type:0];
            [self.view addSubview:self.landScreenView];
        }else{
            self.landScreenView = [[LandScreenView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-44) width:SCREEN_WIDTH length:SCREEN_HEIGHT-44 count:9 interval:ThreeHourInterval dataArray:self.timeArray pointArray:self.pointArray type:1];
            [self.view addSubview:self.landScreenView];
        }
        
    }else{
        NSString *selectedString = [NSString stringWithFormat:@"%@",self.pointArray[0][0]];
        NSString *subString = [selectedString substringWithRange:NSMakeRange(0, 10)];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [formatter dateFromString:subString];
        NSDate *subDate = [date dateByAddingTimeInterval:8*3600];
        NSString *subDateString = [NSString stringWithFormat:@"%@",subDate];
        NSString *subbString = [subDateString substringWithRange:NSMakeRange(0, 10)];
        
        NSDate *nowdate = [NSDate date];
        NSString *datee = [formatter stringFromDate:nowdate];
        
        if ([subbString isEqualToString:datee]) {
            // type 为0,表示是当日的数据
            
            self.landScreenView = [[LandScreenView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-44) width:SCREEN_WIDTH length:SCREEN_HEIGHT-44 count:9 interval:ThreeHourInterval dataArray:self.timeArray pointArray:self.pointArray type:0];
            [self.view addSubview:self.landScreenView];
        }else{
            // type为1,表示是非当日的数据
            self.landScreenView = [[LandScreenView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-44) width:SCREEN_WIDTH length:SCREEN_HEIGHT-44 count:9 interval:ThreeHourInterval dataArray:self.timeArray pointArray:self.pointArray type:1];
            [self.view addSubview:self.landScreenView];
        }
    }
}

- (void)configNav
{
    self.navigationController.navigationBar.barTintColor = kColorWhiteColor;
    self.navigationItem.title = self.titleString;
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setFrame:CGRectMake(0, 0, 20, 20)];
    [leftbtn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    
}

- (void)onBtnBack:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
