//
//  SportViewController.h
//  Udong
//
//  Created by wildyao on 15/11/24.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "CommonViewController.h"
#import "ResultScoreView.h"
#import "StepperManager.h"
#import "SportView.h"
#import "CKCalendarView.h"
#import "SportEffectViewController.h"
#import "NewSportItemView.h"
#import "StepHzView.h"

@interface SportViewController : CommonViewController

@property (nonatomic, strong)UIView *selectedView;
@property (nonatomic, strong)UIButton *sportBtn;
@property (nonatomic, strong)UIButton *effectBtn;
@property (nonatomic, strong)UIView *whiteView;

@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)UIImageView *bgImageView;
@property (nonatomic, strong)UILabel *dayLabel;
@property (nonatomic, strong)UIView *banner;

@property (nonatomic, strong)ResultScoreView *scoreView;
@property (nonatomic, strong)NSString *sublabelString;
@property (nonatomic, strong)UIImageView *soundImageView;
@property (nonatomic, strong)UILabel *titileLable;
@property (nonatomic, strong)NewSportItemView *sportItem;
@property (nonatomic, strong)StepHzView *stepHzView;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)SportView *sportView;
@property (nonatomic, strong)CKCalendarView *CalendarView;
@property (nonatomic, strong)UIButton *backToNowBtn;
@property (nonatomic, strong)UIView *bgView;

@property (nonatomic, strong)NSMutableArray *pointArray;
@property (nonatomic, strong)NSMutableArray *timeArray;

@property (nonatomic, strong)CAKeyframeAnimation *pathAnimation;
@property (nonatomic, strong)UIBezierPath *path;
@property (nonatomic, strong)UIImageView *circleView;

@property (nonatomic, assign)int number;

@property (nonatomic, strong)SportEffectViewController *SportEffectVC;
@property (nonatomic, strong)SportViewController *SportVC;

@property (nonatomic, assign)NSInteger logoutTime;
@property (nonatomic, strong)NSString *endTimeString;
@property (nonatomic, assign)NSInteger endTimeStringIndex;
@property (nonatomic, strong)NSDateFormatter *aa;



@end
