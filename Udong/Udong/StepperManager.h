//
//  StepperManager.h
//  PalmMedicine
//
//  Created by wildyao on 15/4/17.
//  Copyright (c) 2015年 Wild Yaoyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

typedef void (^HistoryStepsBlock)(NSInteger historySteps, NSDate *fromDate);
typedef void (^StartStepBlock)(NSInteger numberOfSteps);
typedef void (^DataFetchEndBlock)(NSArray *stepInfoArr);

@interface StepperManager : NSObject

+ (StepperManager *)sharedStepperManager;

- (BOOL)isStepCountingAvailable;
- (void)stopStep;

@property (nonatomic, strong) NSString *todayString;

@property (nonatomic, strong) CMStepCounter *stepCounter;
@property (nonatomic, strong) CMMotionActivityManager *motionActivitiyManager;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) NSString *endTimeString;
@property (nonatomic, assign) NSInteger endTimeStringIndex;

@property (nonatomic, strong) NSArray *timeStringArr;
@property (nonatomic, strong) NSArray *timeArr;

@property (nonatomic, strong) NSMutableDictionary *serverStepCountDic;
@property (nonatomic, strong) NSMutableDictionary *localStepCountDic;

@property (nonatomic, strong) NSMutableArray *serverAllInfoArr;
@property (nonatomic, strong) NSMutableDictionary *localStepInfoDic;
@property (nonatomic, strong) NSMutableDictionary *serverStepInfoDic;
@property (nonatomic, assign) int day;

- (NSArray *)getTimeStringArr;
- (NSInteger)getTimeStringIndex:(int)day;
- (NSMutableArray *)getTimeArray:(NSString *)latestTimeString day:(int)day;
- (NSMutableArray *)getTimeStringArray:(NSString *)endString day:(int)day;

// 开始计步
- (void)startStepWithDay:(int)day fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate dateString:(NSString *)dateString block:(StartStepBlock)block;
// 获取详细运动数据
- (void)fetchSeveralDaysSportData:(int)day type:(int)type block:(DataFetchEndBlock)block;

// 查询历史脚步数
- (void)fetchStepHistoryWithDay:(int)day fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate dateString:(NSString *)dateString block:(HistoryStepsBlock)block;
// 查询历史脚步数
- (void)fetchStepHistoryFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate dateString:(NSString *)dateString block:(HistoryStepsBlock)block;

// 读取当天全部脚步信息（5S以下）
- (void)fetchStepInfoStartingWithDateString:(NSString *)dateString withHandler:(void (^)(NSArray *result, NSError *error))handler;

//获取退出登录时间到现在的详细运动数据
- (void)fetchSubTimeArraySportDetail:(int)day type:(int)type timeArray:(NSMutableArray *)timeArray block:(DataFetchEndBlock)block;


@end
