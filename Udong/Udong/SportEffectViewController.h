//
//  SportEffectViewController.h
//  Udong
//
//  Created by wildyao on 15/12/17.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EffectiveView.h"
#define DidGetInfoArraySuccessNotification @"DidGetInfoArraySuccessNotification"
#import "CKCalendarView.h"
#import "PICircularProgressView.h"

@interface SportEffectViewController : UIViewController
@property (nonatomic, strong)UIScrollView *contentView;
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)EffectiveView *effectiveView;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *infoArray;
@property (nonatomic, strong)UILabel *dayLabel;
@property (nonatomic, strong)NSString *timeString;
@property (nonatomic, strong)NSString *precentString;
@property (nonatomic, strong)NSString *zeroStr;
@property (nonatomic, assign)float angle;
@property (nonatomic, strong)UIButton *explainBtn;
@property (nonatomic, strong)PICircularProgressView *PIView;
//指针移动标识
@property (nonatomic, assign)NSInteger moveSign;


@end
