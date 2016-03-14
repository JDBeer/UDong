//
//  SportViewController.m
//  Udong
//
//  Created by wildyao on 15/11/24.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "SportViewController.h"
#import "AppDelegate.h"
#import "CKCalendarView.h"
#import "TranslationDataArr.h"
#import "ScreenClipViewController.h"
#import "LandScreenViewController.h"
#import "SportEffectViewController.h"
#import "NewSportItemView.h"
#import "LocalHelper.h"
#import "StepHzView.h"


#define TwoMinuteInterval SCREEN_WIDTH/120
#define HourInterval SCREEN_WIDTH/4

@interface SportViewController ()
@property (nonatomic, assign) double scale;
@property (nonatomic, assign) double interval1;
@property (nonatomic, assign) double interval2;
@property (nonatomic, assign) double interval3;
@property (nonatomic, assign) double interval4;
@property (nonatomic, assign) double messageHeight;
@property (nonatomic, assign) double imageHeight;
@property (nonatomic, assign) double sportViewHeight;
@property (nonatomic, assign) int sign;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDateComponents *comps;

@property (nonatomic, assign) int day;
@property (nonatomic, assign) NSInteger serverStepCount;
@property (nonatomic, strong) NSArray *timeStringArr;
@property (nonatomic, assign) NSInteger latestTimeStringIndex;
@property (nonatomic, strong) NSMutableArray *serverStepInfoArr;
@property (nonatomic, strong) NSMutableArray *localStepInfoArray;

@property (nonatomic, strong) NSString *stepString;

@property (nonatomic, strong) NSMutableArray *middleArray;
@property (nonatomic, strong) NSMutableArray *bigArray;
@property (nonatomic, strong) NSMutableArray *smallArray;
@property (nonatomic, strong) NSMutableArray *infoArray;

@property (nonatomic, strong) NSString *fileString;
@property (nonatomic, strong) NSString *jsonString;



@end

@implementation SportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNumber];
    [self configNav];
    [self configSportData];
    [self configView];
    [self startCountStep];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self PortraitScreen];
    [self configNav];
    
}

- (void)configSportData
{
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    self.comps = [[NSDateComponents alloc] init];
    
    self.day = 0;
    self.serverStepCount = 0;
    self.timeStringArr = [[StepperManager sharedStepperManager] getTimeStringArr];
    self.latestTimeStringIndex = [[StepperManager sharedStepperManager] getTimeStringIndex:0];
    
    self.serverStepInfoArr = [NSMutableArray array];
}



- (void)configView
{
    if (self.day == 0) {
        // 开始计步
        [self startStepWithday:self.day];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BackTonowBtnPress:) name:DidPressBackBtnSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedDate:) name:DidSelectedDateSuccess object:nil];
    
    self.SportEffectVC = [[SportEffectViewController alloc] init];
    self.SportVC = [[SportViewController alloc] init];
    
    
    [self getTodaySportDataFromServerAndSaveToLocal];
    

}

- (void)configBaseUI
{
    self.pointArray = [[NSMutableArray alloc] init];
    
    self.contentView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.contentView];
    
    self.bgImageView = [[UIImageView alloc] initWithImage:ImageNamed(@"background")];
    self.bgImageView.frame = self.view.frame;
    self.bgImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.bgImageView];
    
    self.dayLabel = [[UILabel alloc] init];
    self.dayLabel.frame = CGRectMake(0, _interval1+64, 100, 14);
    self.dayLabel.centerX = self.view.centerX;
    self.dayLabel.textAlignment = NSTextAlignmentCenter;
    self.dayLabel.text = @"今天";
    self.dayLabel.textColor = kColorWhiteColor;
    self.dayLabel.font = FONT(16);
    
    [self.contentView addSubview:self.dayLabel];
    
    self.sublabelString = [NSString stringWithFormat:@"%@",[StorageManager getEffectivepoint]];
    
    self.scoreView = [[ResultScoreView alloc] initWithFrame:CGRectMake(0, self.dayLabel.bottom+_interval2, _imageHeight, _imageHeight) type:0 sublabel:self.sublabelString totalStepCount:@"0"];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _sportViewHeight)];
    self.scrollView.bottom = SCREEN_HEIGHT-50;
    self.scrollView.backgroundColor = kColorClearColor;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*6+15*TwoMinuteInterval, self.scrollView.contentSize.height);
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    float time = [self getNearhour];
    self.scrollView.contentOffset = CGPointMake(HourInterval/2+(time-3)*HourInterval, 0);
    
    [self.contentView addSubview:self.scrollView];
    
    self.timeArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<24; i++) {
        if (i<10) {
            NSString *timeString = [NSString stringWithFormat:@"0%d:00",i];
            [self.timeArray addObject:timeString];
        }else{
            NSString *timeString = [NSString stringWithFormat:@"%d:00",i];
            [self.timeArray addObject:timeString];
        }
    }
    
    
    //   创建有效运动label
    
    UILabel *effectLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
    effectLabel.centerY = self.scrollView.centerY-10;
    effectLabel.text = @"有效运动区间";
    effectLabel.textColor = [ColorManager getColor:@"929A9C" WithAlpha:1];
    effectLabel.font = FONT(15);
    [self.contentView addSubview:effectLabel];
    
    
    UIButton *landScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    landScreenBtn.bounds = CGRectMake(0, 0, 20, 20);
    landScreenBtn.top = self.scrollView.top+10;
    landScreenBtn.right = self.view.right-10;
    [landScreenBtn setBackgroundImage:ImageNamed(@"icon_amplification") forState:UIControlStateNormal];
    [landScreenBtn addTarget:self action:@selector(landScape:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:landScreenBtn];
    [self.contentView bringSubviewToFront:landScreenBtn];
    
    
    self.sportItem = [[NewSportItemView alloc] initWithFrame:CGRectMake(0, self.scoreView.bottom+_interval3, self.view.width, _messageHeight)];
    [self.contentView addSubview:self.sportItem];
    
    self.stepHzView = [[StepHzView alloc] initWithFrame:CGRectMake(0, self.sportItem.bottom+_interval4, self.view.width, 50)];
    [self.contentView addSubview:self.stepHzView];
    
    
    self.scoreView = [[ResultScoreView alloc] initWithFrame:CGRectMake(0, self.dayLabel.bottom+_interval2, _imageHeight, _imageHeight) type:0 sublabel:@"" totalStepCount:0];
    
    [self.scoreView setStrokeColor:kColorBtnColor scorelbColor:kColorWhiteColor sublabColor:kColorContentColor backgroundColor:kColorClearColor lineWidth:15];
    self.scoreView.centerX = self.view.centerX;
    [self.contentView addSubview:self.scoreView];
}

- (void)configNav
{
    
    [self.navigationController.navigationBar setBarTintColor:[ColorManager getColor:@"051F2D" WithAlpha:0.5]];
    
    UIButton *calenderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    calenderBtn.frame = CGRectMake(0, 0, 25, 25);
    [calenderBtn setBackgroundImage:ImageNamed(@"navbar_icon_calender") forState:UIControlStateNormal];
    [calenderBtn addTarget:self action:@selector(showCalender:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:calenderBtn];
    
    _selectedView = [[UIView alloc] initWithFrame:CGRectMake(130, 15, 150, 30)];
    _selectedView.backgroundColor = kColorClearColor;
    self.navigationItem.titleView = _selectedView;
    
    _sportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sportBtn.frame = CGRectMake(0, 0, _selectedView.width/2, _selectedView.height);
    [_sportBtn setTitle:@"运动" forState:UIControlStateNormal];
    [_sportBtn setTitleColor:kColorWhiteColor forState:UIControlStateSelected];
    _sportBtn.selected = YES;
    _sportBtn.tag = 21;
    [_sportBtn setTitleColor:[ColorManager getColor:@"6c7277" WithAlpha:1] forState:UIControlStateNormal];
    [_sportBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [_selectedView addSubview:_sportBtn];
    
    _effectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _effectBtn.frame = CGRectMake(_selectedView.width/2, 0, _selectedView.width/2, _selectedView.height);
    [_effectBtn setTitle:@"效果" forState:UIControlStateNormal];
    [_effectBtn setTitleColor:kColorWhiteColor forState:UIControlStateSelected];
    _effectBtn.tag = 22;
    [_effectBtn setTitleColor:[ColorManager getColor:@"6c7277" WithAlpha:1] forState:UIControlStateNormal];
    [_effectBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [_selectedView addSubview:_effectBtn];
    
    if (self.number == 2) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = kColorWhiteColor;
        _whiteView.frame = CGRectMake(self.selectedView.width/2, self.sportBtn.bottom+2, _selectedView.width/2, 2);
        [_selectedView addSubview:_whiteView];
        
        _sportBtn.selected = NO;
        _effectBtn.selected = YES;
    }else{
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = kColorWhiteColor;
        _whiteView.frame = CGRectMake(0, self.sportBtn.bottom+2, _selectedView.width/2, 2);
        [_selectedView addSubview:_whiteView];
        
    }
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0, 0, 25, 25);
    [shareBtn setBackgroundImage:ImageNamed(@"navbar_icon_share") forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(subScreen:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
}

- (void)startCountStep
{
    self.timer = [NSTimer timerWithTimeInterval:15 block:^{
        if (self.day == 0) {
            [self reloadData];
        }
    } repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

//每两分钟刷新数据
- (void)reloadData
{
    
    StepperManager *stepperManager = [StepperManager sharedStepperManager];
    stepperManager.day = self.day;
    
    NSMutableDictionary *localStepInfoDic = [[NSMutableDictionary alloc]init];
    self.localStepInfoArray = [[NSMutableArray alloc] init];
    
//   判断是否有退出登录时间
    
       if ([StorageManager getLoginoutTime])
       {
//   获取本地最后一条数据的时间到至今的运动数据
        NSMutableArray *timeArray = [self getNearTimeArray:2];
           
          [stepperManager fetchSubTimeArraySportDetail:self.day type:0 timeArray:timeArray block:^(NSArray *stepInfoArr) {
              NSLog(@"本地最后一条数据到至今的数据%@",stepInfoArr);
              
              //   把时间转化，获取到以0点为起点的时间数组
              
              self.bigArray = [stepInfoArr mutableCopy];
              self.infoArray = stepInfoArr[0];
              self.smallArray = [[NSMutableArray alloc] init];
              self.middleArray = [[NSMutableArray alloc] init];
              for (int i=0; i<_infoArray.count; i++)
              {
                  _smallArray = [_infoArray[i] mutableCopy];
                  NSString *string = [NSString stringWithFormat:@"%@",_smallArray[1]];
                  NSString *oneString = [string substringToIndex:[string length]-5];
                  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                  [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                  NSDate *finDate = [formatter dateFromString:oneString];
                  
                  NSTimeZone *zone = [NSTimeZone systemTimeZone];
                  NSInteger interval = [zone secondsFromGMTForDate:finDate];
                  NSDate *localeDate = [finDate  dateByAddingTimeInterval:interval*2];
                  [_smallArray replaceObjectAtIndex:1 withObject:localeDate];
                  [self.middleArray addObject:_smallArray];
                  
                  
              }
              [_bigArray replaceObjectAtIndex:0 withObject:self.middleArray];
              
              if ([_bigArray[0] count]!=0)
              {
//          不为空，直接插入，因为不可能重复
                  
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *date = [NSDate date];
                NSString *nowDate = [formatter stringFromDate:date];
                  
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *plistPath1= [paths objectAtIndex:0];
                NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"aa.plist"];
                  
                NSMutableDictionary *plistDic = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
                  
                NSMutableDictionary *di = [[NSMutableDictionary alloc] init];
    
                NSMutableDictionary *dicc = plistDic[[StorageManager getUserId]];
        
                NSMutableArray *array= dicc[nowDate];
                  
               
                if (array==nil||[array class]==[NSNull null]) {
                    NSMutableArray *aa = [[NSMutableArray alloc] init];
                    array = aa;
                }
                
                  NSArray *arr = _bigArray[0];
                  NSInteger number1 = [_bigArray[1] integerValue];
                  NSInteger number2 = [_bigArray[2] integerValue];
                  NSInteger number3 = [_bigArray[3] integerValue];
                  NSInteger number4 = [_bigArray[4] integerValue];
                  NSInteger number5 = [_bigArray[5] integerValue];
                  
                  
                  
                  if (array.count == 0) {
                      
                      NSMutableArray *ar = [[NSMutableArray alloc] init];
                      array = [[NSMutableArray alloc] initWithObjects:ar,@"0",@"0",@"0",@"0",@"0", nil];
                  }
                  
                  
                  NSMutableArray *array2 = array[0];
                  NSInteger finger1 = [array[1] integerValue];
                  NSInteger finger2 = [array[2] integerValue];
                  NSInteger finger3 = [array[3] integerValue];
                  NSInteger finger4 = [array[4] integerValue];
                  NSInteger finger5 = [array[5] integerValue];
                  
                  [array2 addObjectsFromArray:arr];
                  
                  
                  NSInteger a = number1+finger1;
                  NSInteger b = number2+finger2;
                  NSInteger c = number3+finger3;
                  NSInteger d = number4+finger4;
                  NSInteger e = number5+finger5;
                  
                  NSArray *infoArray = @[array2, @(a), @(b), @(c), @(d),@(e)];
                  
                  [di setObject:infoArray forKey:nowDate];
                  
                  [plistDic setObject:di forKey:[StorageManager getUserId]];
                  
                  [plistDic writeToFile:fileName atomically:YES];
                  
                  
              }else

              {
                  NSLog(@"两分钟刷新,本地最后一条数据至今为空，返回本地数据");
              }
              
              [self LocalUpdateUI];
            
          }];
           
       }else
           
       {
           //       获取路径
           NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
           NSString *plistPath1= [paths objectAtIndex:0];
           NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"aa.plist"];
           
           NSMutableDictionary *plistDic = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
           
           if (plistDic.allKeys == NULL||plistDic.count == 0) {
               [stepperManager fetchSeveralDaysSportData:self.day type:0 block:^(NSArray *localStepInfoArr) {
                   //   localStepInfoArr:详细信息,累积步数，有效步数，累计时间，有效时间，有效运动点
                   
                   //   把时间转化，获取到以0点为起点的时间数组
                   
                   self.bigArray = [localStepInfoArr mutableCopy];
                   self.infoArray = localStepInfoArr[0];
                   self.smallArray = [[NSMutableArray alloc] init];
                   self.middleArray = [[NSMutableArray alloc] init];
                   for (int i=0; i<_infoArray.count; i++) {
                       _smallArray = [_infoArray[i] mutableCopy];
                       NSString *string = [NSString stringWithFormat:@"%@",_smallArray[1]];
                       NSString *oneString = [string substringToIndex:[string length]-5];
                       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                       [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                       NSDate *finDate = [formatter dateFromString:oneString];
                       
                       NSTimeZone *zone = [NSTimeZone systemTimeZone];
                       NSInteger interval = [zone secondsFromGMTForDate:finDate];
                       NSDate *localeDate = [finDate  dateByAddingTimeInterval: interval*2];
                       [_smallArray replaceObjectAtIndex:1 withObject:localeDate];
                       [self.middleArray addObject:_smallArray];
                   }
                   [_bigArray replaceObjectAtIndex:0 withObject:self.middleArray];
                   
                   
                   //       把本地获取的数据缓存到本地
                   if (_bigArray.count!=0) {
                       
                       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                       [formatter setDateFormat:@"yyyy-MM-dd"];
                       NSDate *date = [NSDate date];
                       NSString *nowDate = [formatter stringFromDate:date];
                       
                       //             [localStepInfoDic setObject:_bigArray forKey:nowDate];
                       
                       //       获取路径
                       NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                       NSString *plistPath1= [paths objectAtIndex:0];
                       NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"aa.plist"];
                       
                       NSMutableDictionary *plistDic = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
                       
                       //       写入plist文件，每次写入时判断，如果有今天的内容，就替换今天的。如果没有今天的内容，就增加一条今天的数据，再写入
                       if ([plistDic.allKeys containsObject:[StorageManager getUserId]]) {
                           
                           NSMutableDictionary *dicc = plistDic[[StorageManager getUserId]];
                           
                           [dicc setObject:_bigArray forKey:nowDate];
                           [plistDic setObject:dicc forKey:[StorageManager getUserId]];
                           
                           [plistDic writeToFile:fileName atomically:YES];
                           
                       }else{
                           
                           NSMutableDictionary *dicc = [[NSMutableDictionary alloc] init];
                           
                           [dicc setObject:_bigArray forKey:nowDate];
                           [plistDic setObject:dicc forKey:[StorageManager getUserId]];
                           [plistDic writeToFile:fileName atomically:YES];
                           
                       }
                       
                       //                   //    刷新有效运动点
                       //
                       //                   [self updateUI:1 withArray:localStepInfoArr];
                       //
                       //                   //    把时间和梅脱值取出来，传给绘图View
                       //
                       //                   [self updateUI:2 withArray:localStepInfoArr];
                       //
                       //                   //    刷新四项数据
                       //                   [self updateUI:3 withArray:localStepInfoArr];
                       
                       [self LocalUpdateUI];
                       
                   }
                   
               }];
           }else{
               
               NSMutableArray *timeArray = [self getNearTimeArray:3];
               
               [stepperManager fetchSubTimeArraySportDetail:self.day type:0 timeArray:timeArray block:^(NSArray *stepInfoArr) {
                   NSLog(@"本地最后一条数据到至今的数据%@",stepInfoArr);
                   
                   //   把时间转化，获取到以0点为起点的时间数组
                   
                   self.bigArray = [stepInfoArr mutableCopy];
                   self.infoArray = stepInfoArr[0];
                   self.smallArray = [[NSMutableArray alloc] init];
                   self.middleArray = [[NSMutableArray alloc] init];
                   for (int i=0; i<_infoArray.count; i++)
                   {
                       _smallArray = [_infoArray[i] mutableCopy];
                       NSString *string = [NSString stringWithFormat:@"%@",_smallArray[1]];
                       NSString *oneString = [string substringToIndex:[string length]-5];
                       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                       [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                       NSDate *finDate = [formatter dateFromString:oneString];
                       
                       NSTimeZone *zone = [NSTimeZone systemTimeZone];
                       NSInteger interval = [zone secondsFromGMTForDate:finDate];
                       NSDate *localeDate = [finDate  dateByAddingTimeInterval:interval*2];
                       [_smallArray replaceObjectAtIndex:1 withObject:localeDate];
                       [self.middleArray addObject:_smallArray];
                       
                       
                   }
                   [_bigArray replaceObjectAtIndex:0 withObject:self.middleArray];
                   
                   if ([_bigArray[0] count]!=0)
                   {
                       //          不为空，直接插入，因为不可能重复
                       
                       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                       [formatter setDateFormat:@"yyyy-MM-dd"];
                       NSDate *date = [NSDate date];
                       NSString *nowDate = [formatter stringFromDate:date];
                       
                       NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                       NSString *plistPath1= [paths objectAtIndex:0];
                       NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"aa.plist"];
                       
                       NSMutableDictionary *plistDic = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
                       
                       NSMutableDictionary *di = [[NSMutableDictionary alloc] init];
                       
                       NSMutableDictionary *dicc = plistDic[[StorageManager getUserId]];
                       
                       NSMutableArray *array= dicc[nowDate];
                       
                       if (array==nil||[array class]==[NSNull null]) {
                           NSMutableArray *aa = [[NSMutableArray alloc] init];
                           array = aa;
                       }
                       
                       NSArray *arr = _bigArray[0];
                       NSInteger number1 = [_bigArray[1] integerValue];
                       NSInteger number2 = [_bigArray[2] integerValue];
                       NSInteger number3 = [_bigArray[3] integerValue];
                       NSInteger number4 = [_bigArray[4] integerValue];
                       NSInteger number5 = [_bigArray[5] integerValue];
                       
                       if (array.count == 0) {
                           
                           NSMutableArray *ar = [[NSMutableArray alloc] init];
                           array = [[NSMutableArray alloc] initWithObjects:ar,@"0",@"0",@"0",@"0",@"0", nil];
                       }
                       
                       NSMutableArray *array2 = array[0];
                       NSInteger finger1 = [array[1] integerValue];
                       NSInteger finger2 = [array[2] integerValue];
                       NSInteger finger3 = [array[3] integerValue];
                       NSInteger finger4 = [array[4] integerValue];
                       NSInteger finger5 = [array[5] integerValue];
                       
                       
                       [array2 addObjectsFromArray:arr];
                       
                       
                       NSInteger a = number1+finger1;
                       NSInteger b = number2+finger2;
                       NSInteger c = number3+finger3;
                       NSInteger d = number4+finger4;
                       NSInteger e = number5+finger5;
                       
                       
                       NSArray *infoArray = @[array2, @(a), @(b), @(c), @(d),@(e)];
                       
                       [di setObject:infoArray forKey:nowDate];
                       
                       [plistDic setObject:di forKey:[StorageManager getUserId]];
                       
                       [plistDic writeToFile:fileName atomically:YES];
                       
                   }else
                       
                   {
                       NSLog(@"两分钟刷新,本地最后一条数据至今为空，返回本地数据");
                   }
                   
                   [self LocalUpdateUI];
                   
               }];
               
           }
       }
}

- (void)startStepWithday:(int)day
{
    [self stopStep];
    
    NSDate *fromDate = nil;
    NSDate *toDate = nil;
    
    if (day == 0) {
        toDate = [NSDate date];
        NSDateComponents *comps = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:toDate];
        // 一天的0点、00:00:00
        [comps setHour:0];
        fromDate = [self.calendar dateFromComponents:comps];
    } else {
        toDate = [[NSDate date] dateByAddingTimeInterval:(day+1)*OneDaySeconds];
        NSDateComponents *comps = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:toDate];
        [comps setHour:0];
        toDate = [self.calendar dateFromComponents:comps];
        
        fromDate = [[NSDate date] dateByAddingTimeInterval:day*OneDaySeconds];
        comps = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:fromDate];
        [comps setHour:0];
        fromDate = [self.calendar dateFromComponents:comps];
    }
    
//  格式化dateString
    
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [[self.dateFormatter stringFromDate:fromDate] stringByAppendingPathExtension:@"plist"];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];


    
//   通过传入开始时间和结束时间，得到这段时间内的步数
    
    [[StepperManager sharedStepperManager] startStepWithDay:self.day fromDate:fromDate toDate:toDate dateString:dateString block:^(NSInteger numberOfSteps) {
        
//   缓存到内存，记录
        StepperManager *stepperManager = [StepperManager sharedStepperManager];
        NSMutableDictionary *localStepInfoDic = stepperManager.localStepInfoDic;
        NSMutableArray *localStepInfoArr = [localStepInfoDic[@(0)] mutableCopy];
        
//         脚步数
       NSNumber *localStepCount = @(numberOfSteps);
       self.stepString = [NSString stringWithFormat:@"%@步",localStepCount];
        
//        NSLog(@"----%@",localStepCount);
        
    }];
    
}

- (void)stopStep
{
    [[StepperManager sharedStepperManager] stopStep];
}

-(void)drawLineAnimation:(CALayer*)layer
{
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration = 1.0;
    bas.delegate = self;
    bas.fromValue = [NSNumber numberWithInteger:0];
    bas.toValue = [NSNumber numberWithInteger:1];
    [layer addAnimation:bas forKey:@"key"];
    
    
}

#pragma mark - 截屏分享

- (void)subScreen:(UIButton *)btn
{
    
    
   UIImage *screenImage = [self captureImageFromViewLow:[UIApplication sharedApplication].keyWindow];
    
    ScreenClipViewController *ScreenClipVC = [[ScreenClipViewController alloc] init];
    ScreenClipVC.ScreenImage = screenImage;
    [self.navigationController pushViewController:ScreenClipVC animated:YES];
    
}


#pragma mark - show Calender

- (void)showCalender:(UIButton *)btn
{
    
    [self.timer invalidate];
    self.timer = nil;
    
    
    [SVProgressHUD showProgressWithStatus:@"请稍候" duration:-1];
    
    [APIServiceManager GetOneMonthSportFinishRateWithKey:[StorageManager getSecretKey] userID:[StorageManager getUserId]completionBlock:^(id responObject) {
        
    if ([responObject[@"flag"] isEqualToString:@"100100"]) {
            
            [SVProgressHUD dismiss];
            
            NSArray *rateArray = responObject[@"fRates"];
            
            self.navigationController.navigationBarHidden = YES;
            
            self.contentView.hidden = YES;
            
            self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
            [self.view addSubview:self.bgView];
            [self.view bringSubviewToFront:self.bgView];
        
            self.CalendarView = [[CKCalendarView alloc] initWithStartDay:1 frame:CGRectMake(0, 20, self.view.width, self.CalendarView.height) rateArray:rateArray];

            [self.view addSubview:self.CalendarView];
            
            self.CalendarView.transform = CGAffineTransformMakeScale(0, 0);
            self.bgView.backgroundColor = kColorBlackColor;
            self.bgView.alpha = 0.4;
            [UIView animateWithDuration:0.3 animations:^{
                
                self.bgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                
                self.bgView.userInteractionEnabled = YES;
                
                self.CalendarView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                self.CalendarView.alpha = 1;
                
            } completion:^(BOOL finished) {
                
            }];
        }
        
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


#pragma mark - 点击回到今天

- (void)BackTonowBtnPress:(NSNotification *)notification
{
    
    //  日历隐藏
    self.bgView.alpha = 0;
    self.CalendarView.alpha = 0;
    self.contentView.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    
    self.dayLabel.text = @"今天";
    
    NSString *today = [NSString stringWithFormat:@"%ld",(long)[DaysHelper getTodayZeroTime]];
    [APIServiceManager GetOnedaySportDetailWithKey:[StorageManager getSecretKey] userID:[StorageManager getUserId] dateString:today completionBlock:^(id responObject) {
        
        if ([responObject[@"flag"] isEqualToString:@"100100"])
        {
            [SVProgressHUD dismiss];
            
            [self renewalUIWithType:1 withDictionary:responObject[@"sportsSummary"]];
            [self renewalUIWithType:2 withDictionary:responObject[@"sportsSummary"]];
            [self renewalUIWithType:3 withDictionary:responObject[@"sportsSummary"]];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

#pragma mark - 运动，效果按钮点击

- (void)btnPress:(UIButton *)btn
{
    
    if (btn.tag == 21) {
        if (btn.selected == YES) {
            return;
        }
        btn.selected = !btn.selected;
        self.effectBtn.selected = !btn.selected;
        
//        SportViewController *sportvc = [[SportViewController alloc] init];
//        self.sign = 1;
        [self addChildViewController:self.SportVC];
        
        [self.view addSubview:self.SportVC.view];
        
//     从其他页面返回主页的标识
        self.number = 1;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.whiteView.frame = CGRectMake(0, self.sportBtn.bottom+2, _selectedView.width/2, 2);
        } completion:^(BOOL finished) {
        }];
        
    }else{
        if (btn.selected == YES) {
            return;
        }
        
        btn.selected = !btn.selected;
        self.sportBtn.selected = !btn.selected;
        
        SportEffectViewController *SportEffectVC = [[SportEffectViewController alloc] init];
        
        if (self.sign == 1) {
             SportEffectVC.timeString = @"今天";
        }else{
             SportEffectVC.timeString = self.dayLabel.text;
        }
        
        self.number = 2;
        
        [self addChildViewController:SportEffectVC];
        
        [self.view addSubview:SportEffectVC.view];
        

        [self.timer invalidate];
        self.timer = nil;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.whiteView.frame = CGRectMake(self.selectedView.width/2, self.sportBtn.bottom+2, _selectedView.width/2, 2);
        } completion:^(BOOL finished) {
        }];
    }
}

#pragma mark - 选择日期成功通知

- (void)selectedDate:(NSNotification *)notification
{
    
    self.sign = 0;
    
//  日历隐藏
    self.bgView.alpha = 0;
    self.CalendarView.alpha = 0;
    self.contentView.hidden = NO;
    self.navigationController.navigationBarHidden = NO;

//  日历上选中的日期
    NSDate *selectedDate = (NSDate *)notification.object;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:selectedDate];
    
//  目前的时间
    NSDate *nowDate = [NSDate date];
    NSString *nowString = [dateFormatter stringFromDate:nowDate];
    
//  昨天的时间
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-24*60*60];
    NSString *yesterdayString = [dateFormatter stringFromDate:yesterday];
    
    if ([nowString isEqualToString:dateString]) {
        self.dayLabel.text = @"今天";
        [self startCountStep];
        
    }else if ([yesterdayString isEqualToString:dateString])
        
    {
        self.dayLabel.text = @"昨天";
        [self.timer invalidate];
        self.timer = nil;
        
    }else{
        
        self.dayLabel.text = dateString;
        [self.timer invalidate];
        self.timer = nil;
    }
    

//  根据日历上的选择的日期，向服务端拿数据
    
    NSInteger timesp = [selectedDate timeIntervalSince1970];
    NSString *timespString = [NSString stringWithFormat:@"%ld",(long)timesp];
    
    [SVProgressHUD showProgressWithStatus:@"请稍候" duration:-1];
    [APIServiceManager GetOnedaySportDetailWithKey:[StorageManager getSecretKey] userID:[StorageManager getUserId] dateString:timespString completionBlock:^(id responObject) {
        
        if ([responObject[@"flag"] isEqualToString:@"100100"]) {
            
            [SVProgressHUD dismiss];
            
            [self renewalUIWithType:1 withDictionary:responObject[@"sportsSummary"]];
            [self renewalUIWithType:2 withDictionary:responObject[@"sportsSummary"]];
            [self renewalUIWithType:3 withDictionary:responObject[@"sportsSummary"]];
        }

    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//根据服务器端返回的数据进行界面刷新

- (void)renewalUIWithType:(NSInteger)type withDictionary:(NSDictionary *)Dictionary
{
    
    if ([Dictionary class]==[NSNull class]) {
        [self.scoreView removeFromSuperview];
        self.scoreView = nil;
        self.scoreView = [[ResultScoreView alloc] initWithFrame:CGRectMake(0, self.dayLabel.bottom+_interval2, _imageHeight, _imageHeight) type:0 sublabel:self.sublabelString totalStepCount:@"0"];
        [self.scoreView setStrokeColor:kColorBtnColor scorelbColor:kColorWhiteColor sublabColor:kColorContentColor backgroundColor:kColorClearColor lineWidth:15];
        self.scoreView.centerX = self.view.centerX;
        [self.scoreView setLblText:@"0" angle:(-M_PI/2)-2*M_PI];
        [self.scoreView setcountStepNumber:@"0"];
        [self.contentView addSubview:self.scoreView];
        

        [self.sportView removeFromSuperview];
        self.sportView = nil;
        [self.sportView.coordinateArray removeAllObjects];
        self.sportView = [[SportView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.height-20) width:self.scrollView.contentSize.width length:self.scrollView.height-20 count:25 interval:HourInterval dataArray:self.timeArray pointArray:nil type:0];
        float time = [self getNearhour];
        self.scrollView.contentOffset = CGPointMake(HourInterval/2+(time-3)*HourInterval, 0);
        
        [self.scrollView addSubview:self.sportView];
        
        
        [self.sportItem setLeftNumberText:@"0"];
        [self.sportItem setRightNumberText:@"0"];

        
        
    }else{
        
        if (type == 1) {
            [self.scoreView removeFromSuperview];
            self.scoreView = nil;
            
            NSString *scoreString = [NSString stringWithFormat:@"%@",Dictionary[@"earning"]];
            NSNumber *angleNumber = Dictionary[@"earning"];
            NSString *step = [NSString stringWithFormat:@"%@",Dictionary[@"stepTotal"]];
            
            if ([scoreString isEqualToString:@"0"]) {
                self.scoreView = [[ResultScoreView alloc] initWithFrame:CGRectMake(0, self.dayLabel.bottom+_interval2, _imageHeight, _imageHeight) type:0 sublabel:self.sublabelString totalStepCount:step];
                [self.scoreView setStrokeColor:kColorBtnColor scorelbColor:kColorWhiteColor sublabColor:kColorContentColor backgroundColor:kColorClearColor lineWidth:15];
                self.scoreView.centerX = self.view.centerX;
                [self.scoreView setLblText:scoreString angle:(-M_PI/2)-2*M_PI];
                [self.scoreView setcountStepNumber:step];
                [self.contentView addSubview:self.scoreView];
                
                
            }else{
                self.scoreView = [[ResultScoreView alloc] initWithFrame:CGRectMake(0, self.dayLabel.bottom+_interval2, _imageHeight, _imageHeight) type:0 sublabel:self.sublabelString totalStepCount:step];
                [self.scoreView setStrokeColor:kColorBtnColor scorelbColor:kColorWhiteColor sublabColor:kColorContentColor backgroundColor:kColorClearColor lineWidth:15];
                self.scoreView.centerX = self.view.centerX;
                
                float angleN = [angleNumber floatValue];

                float effectivepoint = [[StorageManager getEffectivepoint] floatValue];
                float angle = ((2*M_PI)/effectivepoint)*angleN;
                [self.scoreView setLblText:scoreString angle:angle-M_PI/2];
                [self.scoreView setcountStepNumber:step];
                [self.contentView addSubview:self.scoreView];
            

            }
        }else if (type == 2){
            
            [self.pointArray removeAllObjects];
            
            NSArray *Array = Dictionary[@"sportsDetails"];
            
            for (NSDictionary *dic in Array) {
                NSString *timeString = dic[@"sportsTime"];
                NSInteger aa = [timeString integerValue];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:aa];
                NSString *time = [NSString stringWithFormat:@"%@",confromTimesp];
                NSString *valueString = dic[@"mets"];
                NSArray *pointArr = @[time,valueString];
                [self.pointArray addObject:pointArr];
            }
            
            [self.sportView removeFromSuperview];
            self.sportView = nil;
            [self.sportView.coordinateArray removeAllObjects];
            
            self.sportView = [[SportView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.height-20) width:self.scrollView.contentSize.width length:self.scrollView.height-20 count:25 interval:HourInterval dataArray:self.timeArray pointArray:self.pointArray type:1];
            float time = [self getNearhour];
            self.scrollView.contentOffset = CGPointMake(HourInterval/2+(time-3)*HourInterval, 0);
            [self.scrollView addSubview:self.sportView];
            
        }else if (type == 3){
            
            id Step = Dictionary[@"stepTotal"];
            NSInteger totalStep = [Step integerValue];//总步数
            id validStp = Dictionary[@"stepEffctv"];
            NSInteger validStep = [validStp integerValue];//有效步数
            NSInteger unValidStep = totalStep-validStep;//无效步数
            
            NSString *validStepString = [NSString stringWithFormat:@"%ld",(long)validStep];
            NSString *unValidStepString = [NSString stringWithFormat:@"%ld",(long)unValidStep];
            
            [self.sportItem setLeftNumberText:validStepString];
            [self.sportItem setRightNumberText:unValidStepString];

        }
    }
}


//根据本地的数据刷新绘图

- (void)LocalUpdateUI
{
   //获取本地的数据
    NSMutableDictionary *plistDic = [LocalHelper getLocalDic];
    NSMutableDictionary *plistD = plistDic[[StorageManager getUserId]];
    NSString *zeroSubString = [DaysHelper getKeyDateString];
    NSArray *localDateArray = plistD[zeroSubString];
    
    //刷新有效运动视图
    self.sublabelString = [NSString stringWithFormat:@"%@",[StorageManager getEffectivepoint]];
    
    //本地总步数
    NSString *step =[NSString stringWithFormat:@"%@",localDateArray[1]] ;
    //有效运动点
    float effectivepoint = [[StorageManager getEffectivepoint] floatValue];
    float angleN = [localDateArray[5] floatValue];
    
    NSString *nowSportPoint = [NSString stringWithFormat:@"%@",localDateArray[5]];
    //获取角度
    float angle = ((2*M_PI)/effectivepoint)*angleN;
    
    //判断本地数据为0的情况
    if ([localDateArray[0] count]==0) {
        [self.scoreView setLblText:@"0" angle:(-M_PI/2)-2*M_PI];
        [self.scoreView setcountStepNumber:step];
        
    }else{
        //  防止出现angle为0，蓝条铺满的情况，加angle为0的判断
        if (angle==0) {
          [self.scoreView setLblText:nowSportPoint angle:(-M_PI/2)-2*M_PI];
          [self.scoreView setcountStepNumber:step];
            
        }else{
          [self.scoreView setLblText:nowSportPoint angle:angle-M_PI/2];
          [self.scoreView setcountStepNumber:step];
        }
    }
    
    
    //刷新滑动视图，先移除再添加
    NSArray *array = localDateArray[0];
    
    for (NSArray *arr in array) {
        
        //  因为本地存的时间是北京时间，所以要减去8小时
        NSDate *plusDate = [arr[1] dateByAddingTimeInterval:-8*3600];
        NSString *timeString = [NSString stringWithFormat:@"%@",plusDate];
        
        NSString *valueString = arr[2];
        NSArray *pointArr = @[timeString,valueString];
        
        [self.pointArray addObject:pointArr];
    }
    
    if ([localDateArray[0] count]==0)
    {
        [self.sportView removeFromSuperview];
        self.sportView = nil;
        [self.sportView.coordinateArray removeAllObjects];

        self.sportView = [[SportView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.height-20) width:self.scrollView.contentSize.width length:self.scrollView.height-20 count:25 interval:HourInterval dataArray:self.timeArray pointArray:nil type:0];
        
        [self.scrollView addSubview:self.sportView];
        
        float time = [self getNearhour];
        self.scrollView.contentOffset = CGPointMake(HourInterval/2+(time-3)*HourInterval, 0);
        
    }else{
        
        [self.sportView removeFromSuperview];
        self.sportView = nil;
        [self.sportView.coordinateArray removeAllObjects];

        self.sportView = [[SportView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.height-20) width:self.scrollView.contentSize.width length:self.scrollView.height-20 count:25 interval:HourInterval dataArray:self.timeArray pointArray:self.pointArray type:0];
        
        [self.scrollView addSubview:self.sportView];
        float time = [self getNearhour];
        self.scrollView.contentOffset = CGPointMake(HourInterval/2+(time-3)*HourInterval, 0);
    }
    
    // 刷新有效运动和无效运动视图
    if ([localDateArray[0] count]==0) {
        
        [self.sportItem setLeftNumberText:@"0"];
        [self.sportItem setRightNumberText:@"0"];
        
    }else{
        NSInteger totalstep = [step integerValue];//总步数
        id step = localDateArray[2];
        NSInteger validStep = [step integerValue];//有效步数
        
        NSInteger unVaildStep = totalstep-validStep;//无效步数
        
        
        NSString *validStepString = [NSString stringWithFormat:@"%ld",(long)validStep];
        NSString *unvalidStepString = [NSString stringWithFormat:@"%ld",(long)unVaildStep];
        
        [self.sportItem setLeftNumberText:validStepString];
        [self.sportItem setRightNumberText:unvalidStepString];
    }
    
    //刷新步频视图
    
    if ([localDateArray[0] count]==0) {
        
        [self.stepHzView setLeftnumberText:@"50"];
        [self.stepHzView setRightNumberText:@"50"];
        
    }else{
        
        [self.stepHzView setLeftnumberText:@"10"];
        [self.stepHzView setRightNumberText:@"100"];
    }
    
}

#pragma mark - 与服务端同步
- (void)synchronizeWithServer
{
    [APIServiceManager GetServerLastRecordWithKey:[StorageManager getSecretKey] userID:[StorageManager getUserId] completionBlock:^(id responObject) {
        
        if ([responObject[@"flag"] isEqualToString:@"100100"]) {
            NSString *newstime = [NSString stringWithFormat:@"%@",responObject[@"newestTime"]];
            NSInteger time = [newstime integerValue];
            NSString *jsonString = [TranslationDataArr ChangeArrayToString:time];
            
            [APIServiceManager SendSportMessageWithKey:[StorageManager getSecretKey] sportString:jsonString completionBlock:^(id responObject) {
                
                if ([responObject[@"flag"] isEqualToString:@"100100"]) {
                
                    [SVProgressHUD showHUDWithImage:nil status:@"数据同步成功" duration:1];
    
                    //  配置基础界面
                    [self configBaseUI];
                    
                    //  根据本地数据刷新
                    [self LocalUpdateUI];
                }else{
                    
                    
                    //  配置基础界面
                    [self configBaseUI];
                    
                    //  根据本地数据刷新
                    [self LocalUpdateUI];
                    
                }
            } failureBlock:^(NSError *error) {
                NSLog(@"%@",error);
            }];
            
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

-(UIImage *)captureImageFromViewLow:(UIWindow *)orgView
{
    //获取指定View的图片
    UIGraphicsBeginImageContextWithOptions(orgView.bounds.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [orgView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 横竖屏切换

- (void)landScape:(id)sender
{
    LandScreenViewController *landerVC = [[LandScreenViewController alloc] init];
    landerVC.pointArray = self.pointArray;
    landerVC.titleString = self.dayLabel.text;
    [self.navigationController pushViewController:landerVC animated:YES];
}

//从横屏界面返回时，强制恢复竖屏

- (void)PortraitScreen
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (float)getNearhour
{
    //  获取当前时间点的后一个小时
    NSCalendar *calender2 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *todate2 = [NSDate date];
    NSDateComponents *comps2 = [calender2 components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:todate2];
    [comps2 setMinute:0];
    NSDate *zeroDate2 = [calender2 dateFromComponents:comps2];
    NSDate *zero2 = [zeroDate2 dateByAddingTimeInterval:9*3600];
    NSString *zero2String = [NSString stringWithFormat:@"%@",zero2];
    NSString *subZeroString = [zero2String substringWithRange:NSMakeRange(11, 11)];
    NSString *aa = [subZeroString substringToIndex:2];
    float time = [aa integerValue];
    return time;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)getTimeArray:(NSString *)latestTimeString day:(int)day
{
    NSMutableArray *timeArr = [NSMutableArray array];
    NSDate *toDate = nil;
    NSDate *fromDate =  nil;
    NSDate *preTime = nil;
    
    if (day == 0) {
        toDate = [NSDate date];
        NSDateComponents *comps = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:toDate];
        // 一天的0点、00:00:00
        [comps setHour:0];
        fromDate = [self.calendar dateFromComponents:comps];
        preTime = fromDate;
        
    } else {
        toDate = [[NSDate date] dateByAddingTimeInterval:(day+1)*OneDaySeconds];
        NSDateComponents *comps = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:toDate];
        // 一天的0点、00:00:00
        [comps setHour:0];
        toDate = [self.calendar dateFromComponents:comps];
        
        fromDate = [[NSDate date] dateByAddingTimeInterval:day*OneDaySeconds];
        comps = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:fromDate];
        [comps setHour:0];
        fromDate = [self.calendar dateFromComponents:comps];
        preTime = fromDate;
    }
    
    // 24小时内60/2*24个2分钟
    for (int i = 0; i < 60/2*24; i++) {
        NSDate *time = [preTime dateByAddingTimeInterval:2*60];
        [timeArr addObject:time];
        preTime = time;
        if ([preTime timeIntervalSinceDate:toDate] >= 60*10) {
            break;
        }
    }
    
    [timeArr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDate *date = (NSDate *)obj;
        NSString *dateString = [_aa stringFromDate:date];
        
        if (![dateString isEqualToString:latestTimeString] ) {
            [timeArr removeObjectAtIndex:idx];
        } else {
            *stop = YES;
        }
    }];
    
    return timeArr;
}

- (NSMutableArray *)getTimeStringArray:(NSString *)endString day:(int)day
{
    NSMutableArray *timeStringArr = [NSMutableArray array];
    
    int endHour = [[endString substringToIndex:2] intValue];;
    int endMinute = [[endString substringWithRange:NSMakeRange(3, 2)] intValue];
    
    int tag = 0;
    for (int i = 0; i < 24; i++) {
        for (int j = 0; j < 60; j += 10) {
            NSString *timeString = nil;
            if (i < 10) {
                if (j < 10) {
                    timeString = [NSString stringWithFormat:@"0%d:0%d", i, j];
                } else {
                    timeString = [NSString stringWithFormat:@"0%d:%d", i, j];
                }
            } else {
                if (j < 10) {
                    timeString = [NSString stringWithFormat:@"%d:0%d", i, j];
                } else {
                    timeString = [NSString stringWithFormat:@"%d:%d", i, j];
                }
            }
            
            [timeStringArr addObject:timeString];
            
            int hour = [[timeString substringToIndex:2] intValue];;
            int minute = [[timeString substringWithRange:NSMakeRange(3, 2)] intValue];
            
            // 最近的整数时间
            if (tag == 0  && ([timeString isEqualToString:endString] || ((hour == endHour) && ((minute-endMinute >= 0) && (minute-endMinute <= 10))) || (hour-endHour == 1))) {
                tag = 1;
                self.endTimeString = timeString;
                self.endTimeStringIndex = timeStringArr.count-1;
                
            }
        }
    }
    
    [timeStringArr addObject:@"24:00"];
    
    if (day != 0) {
        self.endTimeString = @"00:00";
        self.endTimeStringIndex = timeStringArr.count-1;
    }
    
    return timeStringArr;
}

- (NSMutableArray *)getNearTimeArray:(int)type
{
    
//  获取退出登录时间至当前的时间段
    if (type == 1)
    {
        _aa = [[NSDateFormatter alloc] init];
        [_aa setDateFormat:@"yyyy-MM-dd"];
        [_aa setDateFormat:@"HH:mm"];
        
        NSString *now = [_aa stringFromDate:[NSDate date]];
        
        
        NSMutableArray *timeStringArr = [self getTimeStringArray:now day:0];
        NSMutableArray *timeArr = [self getTimeArray:self.endTimeString day:0];
        
        NSMutableArray * subArr = [[NSMutableArray alloc] init];
        
        NSInteger bb = [[StorageManager getLoginoutTime] integerValue];
        NSString *first = [NSString stringWithFormat:@"%@",timeArr.firstObject];
        
        NSInteger firstobject = [first integerValue];
        
        if (bb<firstobject) {
            subArr = timeArr;
        }else{
            
            for (NSString *str in timeArr) {
                NSDate *date = (NSDate *)str;
                NSInteger aa = [date timeIntervalSince1970];
                NSInteger bb = [[StorageManager getLoginoutTime] integerValue];
                
                if (aa>bb) {
                    [subArr addObject:str];
                    
                }
            }
            
        }
        
        return subArr;
        
//判断本地最后一条运动时间是否大于退出登录时间,大于，返回最后一条至今的时间，小于，返回退出登录至今的时间
        
    }else if (type == 2){
        
        NSInteger cc = [[StorageManager getLoginoutTime] integerValue];
        
        _aa = [[NSDateFormatter alloc] init];
        [_aa setDateFormat:@"yyyy-MM-dd"];
        [_aa setDateFormat:@"HH:mm"];
        
        NSString *now = [_aa stringFromDate:[NSDate date]];
        
        
        NSMutableArray *timeStringArr = [self getTimeStringArray:now day:0];
        NSMutableArray *timeArr = [self getTimeArray:self.endTimeString day:0];
        
        NSMutableArray * subArr = [[NSMutableArray alloc] init];
        
        //  获取路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *plistPath1= [paths objectAtIndex:0];
        NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"aa.plist"];
        
        NSMutableDictionary *plistDic = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
        
        NSMutableDictionary *dicc = plistDic[[StorageManager getUserId]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [NSDate date];
        NSString *nowDate = [formatter stringFromDate:date];
        
        NSMutableArray *array= dicc[nowDate];
        
        NSArray *localArray = [array[0] lastObject];
        
        NSDate *localDateLastTime = localArray[1];
        NSInteger localTimeSP = [localDateLastTime timeIntervalSince1970];
        NSInteger localTimeSPP = localTimeSP-8*3600;
        NSInteger bb;
        
        
//  当本地数据为空时，最后一条数据时间为0，为0时截取退出登录时间至今的数据,并且当用户本身最后一条数据小余退出登录时间时，也截取退出登录到至今的数据
        if (localTimeSPP == 0||localTimeSPP<cc) {
            bb = cc;
        }else{
            bb = localTimeSPP;
        }
        
        NSString *first = [NSString stringWithFormat:@"%@",timeArr.firstObject];
        
        NSInteger firstobject = [first integerValue];
        
        if (bb<=firstobject) {
            subArr = timeArr;
        }else{
            
            for (NSString *str in timeArr) {
                NSDate *date = (NSDate *)str;
                NSInteger aa = [date timeIntervalSince1970];
                
                if (aa>bb) {
                    [subArr addObject:str];
                    
                }
            }
            
        }
        
        return subArr;
//返回本地最后一条运动记录时间到至今的时间
    }else{
        _aa = [[NSDateFormatter alloc] init];
        [_aa setDateFormat:@"yyyy-MM-dd"];
        [_aa setDateFormat:@"HH:mm"];
        
        NSString *now = [_aa stringFromDate:[NSDate date]];
        
        
        NSMutableArray *timeStringArr = [self getTimeStringArray:now day:0];
        NSMutableArray *timeArr = [self getTimeArray:self.endTimeString day:0];
        
        NSMutableArray * subArr = [[NSMutableArray alloc] init];
        
        //  获取路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *plistPath1= [paths objectAtIndex:0];
        NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"aa.plist"];
        
        NSMutableDictionary *plistDic = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
        
        NSMutableDictionary *dicc = plistDic[[StorageManager getUserId]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [NSDate date];
        NSString *nowDate = [formatter stringFromDate:date];
        
        NSMutableArray *array= dicc[nowDate];
        
        NSArray *localArray = [array[0] lastObject];
        
        NSDate *localDateLastTime = localArray[1];
        NSInteger localTimeSP = [localDateLastTime timeIntervalSince1970];
        NSInteger localTimeSPP = localTimeSP-8*3600;
        
        NSString *first = [NSString stringWithFormat:@"%@",timeArr.firstObject];
        
        NSInteger firstobject = [first integerValue];
        
        if (localTimeSPP<=firstobject) {
            subArr = timeArr;
        }else{
            
            for (NSString *str in timeArr) {
                NSDate *date = (NSDate *)str;
                NSInteger aa = [date timeIntervalSince1970];
                
                if (aa>localTimeSPP) {
                    [subArr addObject:str];
                    
                }
            }
            
        }
        
        return subArr;

    }
}

- (void)getTodaySportDataFromServerAndSaveToLocal
{
    NSInteger todayZero = [DaysHelper getTodayZeroTime];
    NSString *todayZeroString = [NSString stringWithFormat:@"%ld",(long)todayZero];
   
    [APIServiceManager GetOnedaySportDetailWithKey:[StorageManager getSecretKey] userID:[StorageManager getUserId] dateString:todayZeroString completionBlock:^(id responObject) {
        
        if ([responObject[@"flag"] isEqualToString:@"100100"])
        {
            NSDictionary *serverDic = responObject[@"sportsSummary"];
            
            //  获取服务端数据并转化成本地的格式，存入本地
            [TranslationDataArr changeServerDataToLocal:serverDic];
            
            [self judgeLogioutTimeWithLastSportTime];
        }
        
        
    } failureBlock:^(NSError *error) {
        
    }];
    
}


- (void)judgeLogioutTimeWithLastSportTime
{
    
    StepperManager *stepperManager = [StepperManager sharedStepperManager];
    stepperManager.day = self.day;
    
    
    //       获取路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"aa.plist"];
    
    NSMutableDictionary *plistDic = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
    
    if (plistDic.allKeys == NULL||plistDic.count == 0)
    {
       
        if ([StorageManager getLoginoutTime])
        {
            NSMutableArray *timeArray = [self getNearTimeArray:1];
            [SVProgressHUD showProgressWithStatus:@"请稍候" duration:-1];
            [stepperManager fetchSubTimeArraySportDetail:self.day type:0 timeArray:timeArray block:^(NSArray *stepInfoArr)
            {
                [SVProgressHUD dismiss];
                NSLog(@"退出登录到现在的数据%@",stepInfoArr);
                
                if (stepInfoArr.count!=0)
                {
                    self.bigArray = [stepInfoArr mutableCopy];
                    self.infoArray = stepInfoArr[0];
                    self.smallArray = [[NSMutableArray alloc] init];
                    self.middleArray = [[NSMutableArray alloc] init];
                    for (int i=0; i<_infoArray.count; i++) {
                        _smallArray = [_infoArray[i] mutableCopy];
                        NSString *string = [NSString stringWithFormat:@"%@",_smallArray[1]];
                        NSString *oneString = [string substringToIndex:[string length]-5];
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSDate *finDate = [formatter dateFromString:oneString];
                        
                        NSTimeZone *zone = [NSTimeZone systemTimeZone];
                        NSInteger interval = [zone secondsFromGMTForDate:finDate];
                        NSDate *localeDate = [finDate  dateByAddingTimeInterval: interval*2];
                        [_smallArray replaceObjectAtIndex:1 withObject:localeDate];
                        [self.middleArray addObject:_smallArray];
                    }
                    [_bigArray replaceObjectAtIndex:0 withObject:self.middleArray];
                    
                    NSString *nowDate = [DaysHelper getKeyDateString];
                    
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    NSMutableDictionary *dicc2 = [[NSMutableDictionary alloc] init];
                    
                    [dic setObject:_bigArray forKey:nowDate];
                    
                    [dicc2 setObject:dic forKey:[StorageManager getUserId]];
                
                    
                    [dicc2 writeToFile:fileName atomically:YES];
                    
                    
                    [self synchronizeWithServer];

                }else{
                    
                    NSLog(@"退出登录到至今的数据为空,返回本地数据");
                    
                    //  配置基础界面
                    [self configBaseUI];
                    
                    //  根据本地数据刷新
                    [self LocalUpdateUI];
                    
                }
            }];
        }else{
            
            [SVProgressHUD showProgressWithStatus:@"请稍候" duration:-1];
            [stepperManager fetchSeveralDaysSportData:self.day type:0 block:^(NSArray *localStepInfoArr) {
               
                [SVProgressHUD dismiss];
                if (localStepInfoArr.count!=0)
                {
                    //   localStepInfoArr:详细信息,累积步数，有效步数，累计时间，有效时间，有效运动点
                    
                    //   把时间转化，获取到以0点为起点的时间数组
                    
                    self.bigArray = [localStepInfoArr mutableCopy];
                    self.infoArray = localStepInfoArr[0];
                    self.smallArray = [[NSMutableArray alloc] init];
                    self.middleArray = [[NSMutableArray alloc] init];
                    for (int i=0; i<_infoArray.count; i++) {
                        _smallArray = [_infoArray[i] mutableCopy];
                        NSString *string = [NSString stringWithFormat:@"%@",_smallArray[1]];
                        NSString *oneString = [string substringToIndex:[string length]-5];
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSDate *finDate = [formatter dateFromString:oneString];
                        
                        NSTimeZone *zone = [NSTimeZone systemTimeZone];
                        NSInteger interval = [zone secondsFromGMTForDate:finDate];
                        NSDate *localeDate = [finDate  dateByAddingTimeInterval: interval*2];
                        [_smallArray replaceObjectAtIndex:1 withObject:localeDate];
                        [self.middleArray addObject:_smallArray];
                        
                        
                    }
                    [_bigArray replaceObjectAtIndex:0 withObject:self.middleArray];
                    
                    
                    NSString *nowDate = [DaysHelper getKeyDateString];
                    
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    NSMutableDictionary *dicc2 = [[NSMutableDictionary alloc] init];
                    
                    [dic setObject:_bigArray forKey:nowDate];
                    
                    [dicc2 setObject:dic forKey:[StorageManager getUserId]];
                    
                
                    [dicc2 writeToFile:fileName atomically:YES];
                    
                    
                  
                    [self synchronizeWithServer];

                }else{
                    
                    NSLog(@"从当天0点到至今的数据为空,返回本地数据");
                    
                    //  配置基础界面
                    [self configBaseUI];
                    
                    //  根据本地数据刷新
                    [self LocalUpdateUI];
                }
                
            }];
            
        }
            
    }else{
        
        if ([StorageManager getLoginoutTime])
        {
            NSMutableArray *timeArray = [self getNearTimeArray:2];
            
            [SVProgressHUD showProgressWithStatus:@"请稍候" duration:-1];
            [stepperManager fetchSubTimeArraySportDetail:self.day type:0 timeArray:timeArray block:^(NSArray *stepInfoArr)
             {
                 [SVProgressHUD dismiss];
                 
                 NSLog(@"本地最后一条运动时间到至今的数据%@",stepInfoArr);
                 
                 if (stepInfoArr.count!=0)
                 {
                     self.bigArray = [stepInfoArr mutableCopy];
                     self.infoArray = stepInfoArr[0];
                     self.smallArray = [[NSMutableArray alloc] init];
                     self.middleArray = [[NSMutableArray alloc] init];
                     for (int i=0; i<_infoArray.count; i++) {
                         _smallArray = [_infoArray[i] mutableCopy];
                         NSString *string = [NSString stringWithFormat:@"%@",_smallArray[1]];
                         NSString *oneString = [string substringToIndex:[string length]-5];
                         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                         [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                         NSDate *finDate = [formatter dateFromString:oneString];
                         
                         NSTimeZone *zone = [NSTimeZone systemTimeZone];
                         NSInteger interval = [zone secondsFromGMTForDate:finDate];
                         NSDate *localeDate = [finDate  dateByAddingTimeInterval: interval*2];
                         [_smallArray replaceObjectAtIndex:1 withObject:localeDate];
                         [self.middleArray addObject:_smallArray];
                     }
                     [_bigArray replaceObjectAtIndex:0 withObject:self.middleArray];
                     
                     NSString *nowDate = [DaysHelper getKeyDateString];
                     
                     NSMutableDictionary *dicc = plistDic[[StorageManager getUserId]];
                     NSMutableDictionary *di = [[NSMutableDictionary alloc] init];
                     
                     NSMutableArray *array= dicc[nowDate];
                     
                     NSArray *localArray = [array[0] lastObject];
                     NSArray *newArray = [_bigArray[0] firstObject];
                     NSDate *localDateLastTime = localArray[1];
                     NSDate *newArrayFirstTime = newArray[1];
                     
                     //         转换成时间戳
                     
                     NSInteger localTimeSP = [localDateLastTime timeIntervalSince1970];
                     
                     NSInteger newTimeSP = [newArrayFirstTime timeIntervalSince1970];
                     
                     if (newTimeSP>localTimeSP) {
                         NSArray *arr = _bigArray[0];
                         NSInteger number1 = [_bigArray[1] integerValue];
                         NSInteger number2 = [_bigArray[2] integerValue];
                         NSInteger number3 = [_bigArray[3] integerValue];
                         NSInteger number4 = [_bigArray[4] integerValue];
                         NSInteger number5 = [_bigArray[5] integerValue];
                         
                         if (array.count == 0) {
                             
                             NSMutableArray *ar = [[NSMutableArray alloc] init];
                             array = [[NSMutableArray alloc] initWithObjects:ar,@"0",@"0",@"0",@"0",@"0",nil];
                         }
                         
                         NSMutableArray *array2 = array[0];
                         
                         NSInteger finger1 = [array[1] integerValue];
                         NSInteger finger2 = [array[2] integerValue];
                         NSInteger finger3 = [array[3] integerValue];
                         NSInteger finger4 = [array[4] integerValue];
                         NSInteger finger5 = [array[5] integerValue];
                         
                         [array2 addObjectsFromArray:arr];
                         
                         NSInteger a = number1+finger1;
                         NSInteger b = number2+finger2;
                         NSInteger c = number3+finger3;
                         NSInteger d = number4+finger4;
                         NSInteger e = number5+finger5;
                         
                         NSArray *infoArray = @[array2, @(a), @(b), @(c), @(d),@(e)];
                         
                         [di setObject:infoArray forKey:nowDate];
                         
                         [plistDic setObject:di forKey:[StorageManager getUserId]];
                         
                         [plistDic writeToFile:fileName atomically:YES];
                         [self synchronizeWithServer];
                     
                     }else{
                         
                        NSLog(@"最新的数据第一条时间小余本地最后一条数据，不插入，返回本地数据");
                         //  配置基础界面
                         [self configBaseUI];
                         
                         //  根据本地数据刷新
                         [self LocalUpdateUI];
                    }
                     
                 }else{
                     
                     NSLog(@"本地最后一条运动时间到至今的数据,返回本地数据");
                     
                     //  配置基础界面
                     [self configBaseUI];
                     
                     //  根据本地数据刷新
                     [self LocalUpdateUI];
            
                 }
             }];
            
        }else{
            
            NSMutableArray *timeArray = [self getNearTimeArray:3];
            
            [SVProgressHUD showProgressWithStatus:@"请稍候" duration:-1];
            [stepperManager fetchSubTimeArraySportDetail:self.day type:0 timeArray:timeArray block:^(NSArray *stepInfoArr)
             {
                 [SVProgressHUD dismiss];
                 
                 NSLog(@"本地最后一条运动时间到至今的数据%@",stepInfoArr);
                 
                 if (stepInfoArr.count!=0)
                 {
                     self.bigArray = [stepInfoArr mutableCopy];
                     self.infoArray = stepInfoArr[0];
                     self.smallArray = [[NSMutableArray alloc] init];
                     self.middleArray = [[NSMutableArray alloc] init];
                     for (int i=0; i<_infoArray.count; i++) {
                         _smallArray = [_infoArray[i] mutableCopy];
                         NSString *string = [NSString stringWithFormat:@"%@",_smallArray[1]];
                         NSString *oneString = [string substringToIndex:[string length]-5];
                         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                         [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                         NSDate *finDate = [formatter dateFromString:oneString];
                         
                         NSTimeZone *zone = [NSTimeZone systemTimeZone];
                         NSInteger interval = [zone secondsFromGMTForDate:finDate];
                         NSDate *localeDate = [finDate  dateByAddingTimeInterval: interval*2];
                         [_smallArray replaceObjectAtIndex:1 withObject:localeDate];
                         [self.middleArray addObject:_smallArray];
                     }
                     [_bigArray replaceObjectAtIndex:0 withObject:self.middleArray];
                     
                     NSString *nowDate = [DaysHelper getKeyDateString];
                     
                     NSMutableDictionary *dicc = plistDic[[StorageManager getUserId]];
                     NSMutableDictionary *di = [[NSMutableDictionary alloc] init];
                     
                     NSMutableArray *array= dicc[nowDate];
                     
                     NSArray *localArray = [array[0] lastObject];
                     NSArray *newArray = [_bigArray[0] firstObject];
                     NSDate *localDateLastTime = localArray[1];
                     NSDate *newArrayFirstTime = newArray[1];
                     
                     //         转换成时间戳
                     
                     NSInteger localTimeSP = [localDateLastTime timeIntervalSince1970];
                     
                     NSInteger newTimeSP = [newArrayFirstTime timeIntervalSince1970];
                     
                     if (newTimeSP>localTimeSP) {
                         NSArray *arr = _bigArray[0];
                         NSInteger number1 = [_bigArray[1] integerValue];
                         NSInteger number2 = [_bigArray[2] integerValue];
                         NSInteger number3 = [_bigArray[3] integerValue];
                         NSInteger number4 = [_bigArray[4] integerValue];
                         NSInteger number5 = [_bigArray[5] integerValue];
                         
                         if (array.count == 0) {
                             
                             NSMutableArray *ar = [[NSMutableArray alloc] init];
                             array = [[NSMutableArray alloc] initWithObjects:ar,@"0",@"0",@"0",@"0",@"0", nil];
                         }
                         
                         NSMutableArray *array2 = array[0];
                         NSInteger finger1 = [array[1] integerValue];
                         NSInteger finger2 = [array[2] integerValue];
                         NSInteger finger3 = [array[3] integerValue];
                         NSInteger finger4 = [array[4] integerValue];
                         NSInteger finger5 = [array[5] integerValue];
                         
                         [array2 addObjectsFromArray:arr];
                         
                         
                         NSInteger a = number1+finger1;
                         NSInteger b = number2+finger2;
                         NSInteger c = number3+finger3;
                         NSInteger d = number4+finger4;
                         NSInteger e = number5+finger5;
                        
                         
                         NSArray *infoArray = @[array2, @(a), @(b), @(c), @(d),@(e)];
                         
                         [di setObject:infoArray forKey:nowDate];
                         
                         [plistDic setObject:di forKey:[StorageManager getUserId]];
                         
                         [plistDic writeToFile:fileName atomically:YES];
                         
                         
                         [self synchronizeWithServer];
                         
                     }else{
                         
                         NSLog(@"最新的数据第一条时间小余本地最后一条数据，不插入，返回本地数据");
                         //  配置基础界面
                         [self configBaseUI];
                         
                         //  根据本地数据刷新
                         [self LocalUpdateUI];
                     }
                     
                 }else{
                     
                     NSLog(@"本地最后一条运动时间到至今的数据,返回本地数据");
                     
                     //  配置基础界面
                     [self configBaseUI];
                     
                     //  根据本地数据刷新
                     [self LocalUpdateUI];
                     
                 }
             }];
        }
    
        
    }

}


- (void)configNumber
{
    if (IS_IPONE_4_OR_LESS) {
        _interval1 = 10;
        _interval2 = 5;
        _interval3 = 5;
        _interval4 = 5;
        _messageHeight = 20;
        _imageHeight = 130;
        _sportViewHeight = 100;
    }else if (IS_IPHONE_5){
        _scale = 568.0/667;
        _interval1 = 10;
        _interval2 = 10;
        _interval3 = 20;
        _interval4 = 15;
        _messageHeight = 35;
        _imageHeight = 145;
        _sportViewHeight = 150;
    }else if (IS_IPHONE_6){
        _scale = 1;
        _interval1 = 10;
        _interval2 = 15;
        _interval3 = 40;
        _interval4 = 30;
        _messageHeight=60;
        _imageHeight = 150;
        _sportViewHeight = 170;
    }else if (IS_IPHONE_6P){
        _scale = 736/667;
        _interval1 = 20;
        _interval2 = 20;
        _interval3 = 40;
        _interval4 = 30;
        _messageHeight = 80;
        _imageHeight = 170;
        _sportViewHeight = 180*_scale;
    }

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
