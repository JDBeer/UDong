//
//  StepperManager.m
//  PalmMedicine
//
//  Created by wildyao on 15/4/17.
//  Copyright (c) 2015年 Wild Yaoyao. All rights reserved.
//

#import "StepperManager.h"
#import "NSTimer+BlockTimer.h"

@interface StepperManager () <UIAccelerometerDelegate>
{
    NSInteger shakeCount;
    double px;
    double py;
    double pz;
    NSInteger numOfSteps;
    NSInteger preNumOfSteps;
    
    BOOL isSleeping;
    BOOL isSecond;
}

@property (nonatomic, strong) NSMutableArray *daysTimeArr;
@property (nonatomic, strong) NSMutableArray *daysStepInfoArr;
//累计运动时间
@property (nonatomic, assign) NSInteger totalSportTime;
//有效运动时间
@property (nonatomic, assign) NSUInteger validSportTime;
//总的梅脱值
@property (nonatomic, assign) NSUInteger validSportValue;
//累计步数
@property (nonatomic, assign) NSInteger totalNumOfSteps;
//有效步数
@property (nonatomic, assign) NSInteger vaildNumofSteps;

//有效运动点
@property (nonatomic, assign) NSInteger effectiveSportPoint;
//总有效运动步数
@property (nonatomic, assign) NSInteger totalVaildNumOfSteps;
//总有效运动时间
@property (nonatomic, assign) NSInteger totalVaildSportTime;

@property (nonatomic, assign) NSInteger tag;//记录计算有效运动点时中段的次数

@property (nonatomic, assign) float sustain;//记录在有效运动区间内的梅脱值
@property (nonatomic, assign) NSInteger sustainCount;//记录在有效运动区间内的时间

@property (nonatomic, assign) float sustainTime;//记录一次有效运动区间内的有效运动点

@property (nonatomic, assign) NSInteger susStep;//记录一次有效运动区间内的步数

@property (nonatomic, strong) UIAccelerometer *accelerometer;

@property (nonatomic, copy) StartStepBlock startStepBlock;

@property (nonatomic, copy) DataFetchEndBlock dataFetchEndBlock;

@property (nonatomic, strong) NSArray *tmpArr;

@property (nonatomic, strong) NSDate *startDate;

@property (nonatomic, strong) NSMutableArray *arrrry;


@end

@implementation StepperManager

+ (StepperManager *)sharedStepperManager
{
    static StepperManager *sharedStepperManager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedStepperManager = [[[self class] alloc] init];
    });
    
    return sharedStepperManager;
}

- (BOOL)isStepCountingAvailable
{
    return [CMStepCounter isStepCountingAvailable];
}

- (void)stopStep
{
    if ([CMStepCounter isStepCountingAvailable]) {
        [self.stepCounter stopStepCountingUpdates];
//        self.stepCounter = nil;
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        self.stepCounter = [[CMStepCounter alloc] init];
        self.motionActivitiyManager = [[CMMotionActivityManager alloc] init];
        self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.todayString = [[self.dateFormatter stringFromDate:[NSDate date]] stringByAppendingPathExtension:@"plist"];
        
        [self.dateFormatter setDateFormat:@"HH:mm"];

        self.daysTimeArr = [NSMutableArray array];
        self.daysStepInfoArr = [NSMutableArray array];
        self.serverStepCountDic = [NSMutableDictionary dictionary];
        self.localStepCountDic = [NSMutableDictionary dictionary];
        
        self.serverAllInfoArr = [NSMutableArray array];
        self.localStepInfoDic = [NSMutableDictionary dictionary];
        
        self.serverStepInfoDic = [NSMutableDictionary dictionary];
        
        self.validSportTime = 0;
        
        numOfSteps = 0;
        preNumOfSteps = 0;
        self.totalNumOfSteps = 0;
        self.vaildNumofSteps = 0;
        self.totalSportTime = 0;
        
        isSecond = NO;
        
        self.arrrry = [[NSMutableArray alloc] init];
 
    }
    return self;
}

#pragma mark - private
- (void)queryStepsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate dateString:(NSString *)dateString block:(HistoryStepsBlock)block
{
    if ([CMStepCounter isStepCountingAvailable]) {
        [self.stepCounter queryStepCountStartingFrom:fromDate
                                                  to:toDate
                                             toQueue:[NSOperationQueue mainQueue]
                                         withHandler:^(NSInteger numberOfSteps, NSError *error) {
//                                             if (numberOfSteps == 1) {
//                                                 NSLog(@"from: %@  to: %@  num: %ld", fromDate, toDate, numberOfSteps);
//                                             }
                                             block(numberOfSteps, fromDate);
                                         }];

    } else {
        [StorageManager queryStepCountStartingFrom:fromDate to:toDate dateString:dateString withHandler:^(NSInteger numberOfSteps, NSError *error) {
            block(numberOfSteps, fromDate);
        }];
    }
}

- (void)reset
{
    [self.daysTimeArr removeAllObjects];
    [self.daysStepInfoArr removeAllObjects];
    self.validSportTime = 0;
    self.validSportValue = 0;
    self.totalNumOfSteps = 0;
    self.totalSportTime = 0;
    self.vaildNumofSteps = 0;
    self.effectiveSportPoint = 0;
    self.totalVaildNumOfSteps = 0;
    self.totalVaildSportTime = 0;
    self.tag = 1;
    self.sustain = 0;
    self.sustainCount = 0;
    self.sustainTime = 0;
    self.susStep = 0;
    
}

- (void)clear
{
    numOfSteps = 0;
    preNumOfSteps = 0;
}

#pragma mark - Public

- (void)fetchStepHistoryWithDay:(int)day fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate dateString:(NSString *)dateString block:(HistoryStepsBlock)block
{
     [self queryStepsFromDate:fromDate toDate:toDate dateString:dateString block:block];
}

- (void)fetchStepHistoryFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate dateString:(NSString *)dateString block:(HistoryStepsBlock)block
{
    [self queryStepsFromDate:fromDate toDate:toDate dateString:dateString block:block];
}

- (void)fetchStepInfoStartingWithDateString:(NSString *)dateString withHandler:(void (^)(NSArray *result, NSError *error))handler
{
    [StorageManager queryStepInfoStartingWithDateString:dateString withHandler:^(NSArray *result, NSError *error) {
        handler(result, error);
    }];
}


// 开始计步
- (void)startStepWithDay:(int)day fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate dateString:(NSString *)dateString block:(StartStepBlock)block
{
    [self reset];
    
    if ([CMStepCounter isStepCountingAvailable]) {
        if (!self.stepCounter) {
            self.stepCounter = [[CMStepCounter alloc] init];
        } else {
            [self.stepCounter stopStepCountingUpdates];
        }
        
        [self clear];
        
        [self fetchStepHistoryWithDay:day fromDate:fromDate toDate:toDate dateString:dateString block:^(NSInteger historySteps, NSDate *fromDate) {
            if (day == 0) {
                [self.stepCounter startStepCountingUpdatesToQueue:[NSOperationQueue currentQueue]
                                                         updateOn:3
                                                      withHandler:^(NSInteger numberOfSteps, NSDate *timestamp, NSError *error) {
                                                          if (historySteps != 0) {
                                                              
                                                              block(historySteps+numberOfSteps);
                                                              [self.localStepCountDic setObject:@(historySteps+numberOfSteps) forKey:@(day)];
                                                              
                                                          } else {
                                                              block(0);
                                                          }
                                                      }];
            } else {
                block(historySteps);
                
                [self.localStepCountDic setObject:@(historySteps) forKey:@(day)];
            }
        }];
    } else {
    
        if (self.accelerometer) {
            self.accelerometer.delegate = nil;
            self.accelerometer = nil;
        }

        // 获取历史脚步并加上新运动的步数
        [self fetchStepHistoryWithDay:day fromDate:fromDate toDate:toDate dateString:dateString block:^(NSInteger historySteps, NSDate *fromDate) {
            NSLog(@"122333: %ld", historySteps);
        
            [self clear];
            if (day == 0) {
                [self startStepWithNoM7Chip:0 startStepBlock:^(NSInteger numberOfSteps) {
                    NSLog(@"historySteps11111: %ld   %ld", historySteps, numberOfSteps);
                    // 历史脚步并加上新运动的步数
                    block(historySteps+numberOfSteps);
                    [self.localStepCountDic setObject:@(historySteps+numberOfSteps) forKey:@(day)];
                }];
            } else {
                block(historySteps);
                [self.localStepCountDic setObject:@(historySteps) forKey:@(day)];
            }
        }];
    }
}

#pragma mark - private
// 开始计步（5S以下）
- (void)startStepWithNoM7Chip:(int)day startStepBlock:(StartStepBlock)startStepBlock
{
    if (![CMStepCounter isStepCountingAvailable]) {
        
        if (!self.accelerometer) {
            self.startDate = [NSDate date];
        }
        
        self.accelerometer = [UIAccelerometer sharedAccelerometer];
        self.accelerometer.delegate = self;
        self.accelerometer.updateInterval = 1.0/30.0f;
        self.startStepBlock = startStepBlock;
        
        px = py = pz = 0;
    }
}

- (NSMutableArray *)configTime:(int)day
{
    [self.daysTimeArr removeAllObjects];
    [self.daysStepInfoArr removeAllObjects];
    self.validSportTime = 0;
    self.validSportValue = 0;
    
    
    NSString *now = [self.dateFormatter stringFromDate:[NSDate date]];
    NSMutableArray *timeStringArr = [self getTimeStringArray:now day:day];
    NSMutableArray *timeArr = [self getTimeArray:self.endTimeString day:day];

    [self.daysTimeArr addObject:[NSMutableArray arrayWithObjects:timeStringArr, timeArr, nil]];
    
    NSMutableArray *stepInfoArr = [NSMutableArray array];
    [self.daysStepInfoArr addObject:stepInfoArr];
    
    [timeArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx < timeArr.count-1) {
            NSDate *fromDate = (NSDate *)obj;
            double strength = 0;
            
            [stepInfoArr addObject:@[@(0), fromDate, @(strength)]];
        }
    }];
    
    return stepInfoArr;
}

// 计步代理（5S以下）
#pragma mark - UIAccelerometerDelegate
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    float xx = acceleration.x;
    float yy = acceleration.y;
    float zz = acceleration.z;
    
    float dot = (px * xx) + (py * yy) + (pz * zz);
    float a = ABS(sqrt(px * px + py * py + pz * pz));
    float b = ABS(sqrt(xx * xx + yy * yy + zz * zz));
    
    dot /= (a * b);
    
    if (dot <= 0.82) {
        if (!isSleeping) {
            isSleeping = YES;
            [self performSelector:@selector(wakeUp) withObject:nil afterDelay:0.3];
            
            // 脚步数+1
            numOfSteps += 1;
            
            NSInteger stepsInTime = numOfSteps-preNumOfSteps;
            preNumOfSteps = numOfSteps;
            // 每一步都保存
            [StorageManager saveStepCount:stepsInTime totalCountUpToNow:numOfSteps date:[NSDate date] dateString:self.todayString];
            
            // 回传步数，用于更新界面
            self.startStepBlock(numOfSteps);
        }
    }
    
    px = xx;
    py = yy;
    pz = zz;
}

// 获取详细运动数据
// type 0：获取某一天的数据   day：0表示今天 -1表示一天前
// type 1：获取几天的数据   day：1表示今天一天 2表示最近两天
- (void)fetchSeveralDaysSportData:(int)day type:(int)type block:(DataFetchEndBlock)block
{
    [self reset];
    
    __block NSInteger allTimeCount = 0;
    __block NSInteger allStepInfoCount = 0;
    dispatch_queue_t serialQueue = dispatch_queue_create("com.stepFetch.queue", DISPATCH_QUEUE_SERIAL);
    
    if ([CMStepCounter isStepCountingAvailable]) {
        [self.timer invalidate];
        self.timer = nil;
        
        self.timer = [NSTimer timerWithTimeInterval:0.1 block:^{
            if (type == 0) {
                if (allStepInfoCount + 1 == allTimeCount) {
                    [self.timer invalidate];
                    [self sortData:serialQueue block:block];
                }
                
            } else {
                if (allStepInfoCount + day == allTimeCount) {
                    [self.timer invalidate];
                    [self sortData:serialQueue block:block];
                }
            }
        } repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
    
    NSString *now = [self.dateFormatter stringFromDate:[NSDate date]];
    
    dispatch_async(serialQueue, ^{
        
        NSInteger todayCount = 0;
        NSInteger otherCount = 0;
        
        if (type == 0) {                            // 获取某一天的数据
            NSMutableArray *timeStringArr = [self getTimeStringArray:now day:day];
            NSMutableArray *timeArr = [self getTimeArray:self.endTimeString day:day];
            [self.daysTimeArr addObject:[NSMutableArray arrayWithObjects:timeStringArr, timeArr, nil]];
            
            todayCount = timeArr.count;
            allTimeCount = todayCount;
        } else {                                    // 获取几天的数据
            int tmp = (day-1 == 0) ? 0 : -(day-1);
            for (int day = 0; day >= tmp; day--) {
                NSMutableArray *timeStringArr = [self getTimeStringArray:nil day:day];
                NSMutableArray *timeArr = [self getTimeArray:self.endTimeString day:day];
                [self.daysTimeArr addObject:[NSMutableArray arrayWithObjects:timeStringArr, timeArr, nil]];
                
                if (day == 0) {
                    todayCount = timeArr.count;
                } else if (day == -1) {
                    otherCount = timeArr.count;
                }
            }
            
            allTimeCount = todayCount + otherCount*(day-1);
        }
        
        
        double weight = 0;
        
        weight = [[StorageManager getWeight] doubleValue];
       
        
        for (id object in self.daysTimeArr) {
            NSMutableArray *arr = (NSMutableArray *)object;
            NSMutableArray *timeArr = arr[1];
            NSMutableArray *stepInfoArr = [NSMutableArray array];
            
            if (timeArr.count == 0) {
                return;
            }
            NSDate *fromDate = (NSDate *)timeArr[0];
            [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
            // 5S以下需要dateString、datePath
            NSString *dateString = [self.dateFormatter stringFromDate:fromDate];
            NSString *datePath = [dateString stringByAppendingPathExtension:@"plist"];
            [self.dateFormatter setDateFormat:@"HH:mm"];
            
            if ([CMStepCounter isStepCountingAvailable]) {              // 5S以上
                [timeArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if (idx < timeArr.count-1) {
                        NSDate *fromDate = (NSDate *)obj;
                        NSDate *toDate = (NSDate *)timeArr[idx+1];
                        // 获取一天内每个时段的脚步详细并统计总步数
                        [[StepperManager sharedStepperManager] fetchStepHistoryFromDate:fromDate toDate:toDate dateString:datePath block:^(NSInteger historySteps, NSDate *fromDate) {
                            
                            // 运动强度 = 步数/2*0.0299
                            double strength = 0;
                            
                            
                                // 每个时间段内的梅脱
                                strength = historySteps/2.0*0.0299;
                                //                                calorie = historySteps/16.0;
                                //                                // 每个时间段内的梅脱
                                //                                strength = calorie/weight/2.0/0.0167;
                                //                                if (historySteps) {
                                //                                    strength = historySteps/2.0/45.0+1;
                                //                                } else {
                                //                                    strength = 0;
                                //                                }
                                
                            
                            if (strength >= 3 && strength <= 6) {
                                // 总的有效运动时间
                                self.validSportTime += 2;
                                self.vaildNumofSteps +=historySteps;
                            }
                            
                            if (historySteps>0) {
                                self.totalSportTime+=2;
                            }
                            
                            // 总的梅脱
                            self.validSportValue += strength;
                            // 总步数
                            self.totalNumOfSteps += historySteps;
                            
                            
                            NSInteger realize;
                            
                            if (self.effectiveSportPoint>=[[StorageManager getEffectivepoint] integerValue]) {
                                
                                realize = 1;
                            }else{
                                realize = 0;
                            }
                            
                            NSInteger index  = [self.daysTimeArr indexOfObject:object];
                            
                            if (historySteps!=0) {
                                
                            [stepInfoArr addObject:@[@(index), fromDate, @(strength),@(historySteps),@(realize)]];
                            }
                            
                            
                            allStepInfoCount += 1;

                        }];
                    }
                }];
                
                [self.daysStepInfoArr addObject:stepInfoArr];
                
            } else {                                                     // 5S以下
                // 先读取全部到内存
                [[StepperManager sharedStepperManager] fetchStepInfoStartingWithDateString:datePath withHandler:^(NSArray *resultArr, NSError *error) {
                    
                    if (!resultArr) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            // 详细信息、有效运动时间、梅脱、步数
                            block(@[[NSArray arrayWithArray:self.daysStepInfoArr], @(0), @(0),@(0),@(0),@(0)]);
                            return;
                        });
                    }
                    
                    [timeArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        if (idx < timeArr.count-1) {
                            NSDate *fromDate = (NSDate *)obj;
                            NSDate *toDate = (NSDate *)timeArr[idx+1];
                            
                            __block NSInteger historySteps = 0;
                            // 从结果中筛选
                            [resultArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                
                                NSArray *arr = (NSArray *)obj;
                                NSDate *recordDate = arr[0];
                                
                                if ((([recordDate compare:fromDate] == NSOrderedDescending) && ([recordDate compare:toDate] == NSOrderedAscending)) || ([recordDate compare:toDate] == NSOrderedSame)) {
                                    NSInteger steps = [arr[1] integerValue];
                                    historySteps += steps;
                                }
                            }];
                            
                            // 运动强度 = 步数/2*0.0299
                            double strength = 0;
                            
                            
                            // 每个时间段内的梅脱
                            strength = historySteps/2.0*0.0299;
                            //                                calorie = historySteps/16.0;
                            //                                // 每个时间段内的梅脱
                            //                                strength = calorie/weight/2.0/0.0167;
                            //                                if (historySteps) {
                            //                                    strength = historySteps/2.0/45.0+1;
                            //                                } else {
                            //                                    strength = 0;
                            //                                }
                            
                            
                            if (strength >= 3 && strength <= 6) {
                                // 总的有效运动时间
                                self.validSportTime += 2;
                                self.vaildNumofSteps +=historySteps;
                            }
                            
                            if (historySteps>0) {
                                self.totalSportTime+=2;
                            }
                            
                            // 总的梅脱
                            self.validSportValue += strength;
                            // 总步数
                            self.totalNumOfSteps += historySteps;
                            
                            
                            NSInteger realize;
                            
                            if (self.effectiveSportPoint>=[[StorageManager getEffectivepoint] integerValue]) {
                                
                                realize = 1;
                            }else{
                                realize = 0;
                            }
                            
                            NSInteger index  = [self.daysTimeArr indexOfObject:object];
                            
                            if (historySteps!=0) {
                                
                            [stepInfoArr addObject:@[@(index), fromDate, @(strength),@(historySteps),@(realize)]];
                            }
                            
                            
                            allStepInfoCount += 1;
                        }
                    }];
                    
                    [self.daysStepInfoArr addObject:stepInfoArr];
                    // 整理数据
                    [self sortData:serialQueue block:block];
                }];
            }
        }
    });
}


- (void)sortData:(dispatch_queue_t)queue block:(DataFetchEndBlock)dataFetchEndBlock
{
    NSArray *tmp = [NSMutableArray arrayWithArray:self.daysStepInfoArr];
    
    [self.daysStepInfoArr removeAllObjects];
    
    dispatch_async(queue, ^{
        for (id obj in tmp) {
            NSMutableArray *arr = (NSMutableArray *)obj;
            NSArray *tmpArr = [NSArray arrayWithArray:arr];
            arr = [[tmpArr sortedArrayUsingComparator:^(id obj1, id obj2) {
                if ([obj1 isKindOfClass:[NSArray class]] && [obj2 isKindOfClass:[NSArray class]]) {
                    
                    NSDate *date1 = obj1[1];
                    NSDate *date2 = obj2[1];
                    
                    return (NSComparisonResult)[date1 compare:date2];
                }
                
                return (NSComparisonResult)NSOrderedSame;
            }] mutableCopy];
            
            [self.daysStepInfoArr addObject:arr];
        }
        
        
        
        NSMutableArray *temp = self.daysStepInfoArr[0];
        
        for (int i=0; i<temp.count; i++) {
            NSString *orderString = [NSString stringWithFormat:@"%@",temp[i][2]];
            NSString *step = [NSString stringWithFormat:@"%@",temp[i][3]];
            NSInteger stepnumber = [step integerValue];
            float strength = [orderString floatValue];
        
            //计算有效运动点
            if (strength<3) {
               
                if (_sustainCount>0) {
                    _tag--;
                    
                    if (_tag>=0) {
                        _sustain+=strength;
                        _sustainCount+=2;
                        _susStep+=stepnumber;
                    }
                    
                }else{
                    _tag--;
                    _sustain+=0;
                }
            }
            
            if (strength >=3 && strength <= 6 && _tag>=0) {
                
                if (_tag >= 0) {
                    _sustain+=strength;
                    _sustainCount+=2;
                    _susStep+=stepnumber;
                }
            }
            
            if (_tag<0) {
                
                _sustainTime += _sustain*6.25;
                
                if (_sustainCount<10) {
                    _sustainTime = 0;
                    _susStep = 0;
                }
                
                _sustain = 0;
                _tag = 1;
                _sustainCount = 0;
                
            }
            
            if (_sustain == 0) {
                _tag = 1;
                _sustain = 0;
            }
            
            self.effectiveSportPoint+=_sustainTime;
            self.totalVaildNumOfSteps+=_susStep;
            self.totalVaildSportTime+=_sustainCount;
            _sustainTime = 0;
            _susStep = 0;
            _sustainCount = 0;
            
        }

        if (self.daysTimeArr.count == 1) {
            self.daysStepInfoArr = [self.daysStepInfoArr[0]  mutableCopy];
        }
    
        double weight = 0;
       
        weight = [[StorageManager getWeight] doubleValue];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 详细信息、累积步数、有效步数、累计运动时间、有效运动时间
            
            
                if (self.day == 0) {
                    //                    [StorageManager saveStarCountOfToday:@(self.validSportValue/weight)];
                }
                //                dataFetchEndBlock(@[[NSArray arrayWithArray:self.daysStepInfoArr], @(self.validSportTime), @(_totalNumOfSteps/16.0), @(_totalNumOfSteps), @(self.validSportValue/weight)]);
                
                dataFetchEndBlock(@[[NSArray arrayWithArray:self.daysStepInfoArr], @(_totalNumOfSteps), @(_totalVaildNumOfSteps), @(_totalSportTime), @(_totalVaildSportTime),@(_effectiveSportPoint)]);
        });
    });
}


#pragma mark - Utilities

- (NSArray *)getTimeStringArr
{
   return [self getTimeStringArray:nil day:-1];
}

- (NSInteger)getTimeStringIndex:(int)day
{
    [self getTimeStringArray:[self.dateFormatter stringFromDate:[NSDate date]] day:day];
    return self.endTimeStringIndex;
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
        NSString *dateString = [self.dateFormatter stringFromDate:date];
        
        if (![dateString isEqualToString:latestTimeString] ) {
            [timeArr removeObjectAtIndex:idx];
        } else {
            *stop = YES;
        }
    }];
    
    return timeArr;
}

- (void)wakeUp
{
    isSleeping = NO;
}

- (void)fetchSubTimeArraySportDetail:(int)day type:(int)type timeArray:(NSMutableArray *)timeArray block:(DataFetchEndBlock)block
{
    [self reset];
    
    __block NSInteger allTimeCount = 0;
    __block NSInteger allStepInfoCount = 0;
    dispatch_queue_t serialQueue = dispatch_queue_create("com.stepFetch.queue", DISPATCH_QUEUE_SERIAL);
    
    if ([CMStepCounter isStepCountingAvailable]) {
        [self.timer invalidate];
        self.timer = nil;
        
        self.timer = [NSTimer timerWithTimeInterval:0.1 block:^{
            if (type == 0) {
                if (allStepInfoCount + 1 == allTimeCount) {
                    [self.timer invalidate];
//                    [self sortData:serialQueue block:block];
                }
                
            } else {
                if (allStepInfoCount + day == allTimeCount) {
                    [self.timer invalidate];
                    [self sortData:serialQueue block:block];
                }
            }
        } repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
    
    NSString *now = [self.dateFormatter stringFromDate:[NSDate date]];
    
    dispatch_async(serialQueue, ^{
        
        NSInteger todayCount = 0;
        NSInteger otherCount = 0;
        
        if (type == 0) {                            // 获取某一天的数据
            NSMutableArray *timeStringArr = [self getTimeStringArray:now day:day];
            NSMutableArray *timeArr = [self getTimeArray:self.endTimeString day:day];
            [self.daysTimeArr addObject:[NSMutableArray arrayWithObjects:timeStringArr, timeArr, nil]];
            
            todayCount = timeArr.count;
            allTimeCount = todayCount;
        } else {                                    // 获取几天的数据
            int tmp = (day-1 == 0) ? 0 : -(day-1);
            for (int day = 0; day >= tmp; day--) {
                NSMutableArray *timeStringArr = [self getTimeStringArray:nil day:day];
                NSMutableArray *timeArr = [self getTimeArray:self.endTimeString day:day];
                [self.daysTimeArr addObject:[NSMutableArray arrayWithObjects:timeStringArr, timeArr, nil]];
                
                if (day == 0) {
                    todayCount = timeArr.count;
                } else if (day == -1) {
                    otherCount = timeArr.count;
                }
            }
            
            allTimeCount = todayCount + otherCount*(day-1);
        }
        
        
        double weight = 0;
        
        weight = [[StorageManager getWeight] doubleValue];
        
        
        for (id object in self.daysTimeArr) {
            NSMutableArray *arr = (NSMutableArray *)object;
            NSMutableArray *timeArr = arr[1];
            NSMutableArray *stepInfoArr = [NSMutableArray array];
            
            if (timeArr.count == 0) {
                return;
            }
            NSDate *fromDate = (NSDate *)timeArr[0];
            [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
            // 5S以下需要dateString、datePath
            NSString *dateString = [self.dateFormatter stringFromDate:fromDate];
            NSString *datePath = [dateString stringByAppendingPathExtension:@"plist"];
            [self.dateFormatter setDateFormat:@"HH:mm"];
            
            
            if ([CMStepCounter isStepCountingAvailable]) {              // 5S以上
                [timeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if (idx < timeArray.count-1) {
                        NSDate *fromDate = (NSDate *)obj;
                        NSDate *toDate = (NSDate *)timeArray[idx+1];
                        
                        // 获取一天内每个时段的脚步详细并统计总步数
                        [[StepperManager sharedStepperManager] fetchStepHistoryFromDate:fromDate toDate:toDate dateString:datePath block:^(NSInteger historySteps, NSDate *fromDate) {
                            
                            // 运动强度 = 步数/2*0.0299
                            double strength = 0;
                            
                                // 每个时间段内的梅脱
                                strength = historySteps/2.0*0.0299;
                                //                                calorie = historySteps/16.0;
                                //                                // 每个时间段内的梅脱
                                //                                strength = calorie/weight/2.0/0.0167;
                                //                                if (historySteps) {
                                //                                    strength = historySteps/2.0/45.0+1;
                                //                                } else {
                                //                                    strength = 0;
                                //                                }
                            
                            
                            if (strength >= 3 && strength <= 6) {
                                // 总的有效运动时间
                                self.validSportTime += 2;
                                self.vaildNumofSteps +=historySteps;
                            }
                            
                            if (historySteps>0) {
                                self.totalSportTime+=2;
                            }
                            
                            // 总的梅脱
                            self.validSportValue += strength;
                            // 总步数
                            self.totalNumOfSteps += historySteps;
                            
                            
                            NSInteger realize;
                            
                            if (self.effectiveSportPoint>=[[StorageManager getEffectivepoint] integerValue]) {
                                
                                realize = 1;
                            }else{
                                realize = 0;
                            }
                            
                            NSInteger index  = [self.daysTimeArr indexOfObject:object];
                            
                            if (historySteps == 0) {
                                
                            }else{
                                
                            [stepInfoArr addObject:@[@(index), fromDate, @(strength),@(historySteps),@(realize)]];
                            }
                            
                            allStepInfoCount += 1;
                            
                            if (idx == timeArray.count-2) {
                                [self.daysStepInfoArr addObject:stepInfoArr];
                                // 整理数据
                                [self sortData:serialQueue block:block];
                            }
                            
                        }];
                    }
                    
                }];
                
            } else {                                                     // 5S以下
                // 先读取全部到内存
                [[StepperManager sharedStepperManager] fetchStepInfoStartingWithDateString:datePath withHandler:^(NSArray *resultArr, NSError *error) {
                    
                    if (!resultArr) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            // 详细信息、有效运动时间、梅脱、步数
                            block(@[[NSArray arrayWithArray:self.daysStepInfoArr], @(0), @(0),@(0),@(0),@(0)]);
                            return;
                        });
                    }
                    
                    [timeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        if (idx < timeArray.count-1) {
                            NSDate *fromDate = (NSDate *)obj;
                            NSDate *toDate = (NSDate *)timeArray[idx+1];
                            
                            __block NSInteger historySteps = 0;
                            // 从结果中筛选
                            [resultArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                
                                NSArray *arr = (NSArray *)obj;
                                NSDate *recordDate = arr[0];
                                
                                if ((([recordDate compare:fromDate] == NSOrderedDescending) && ([recordDate compare:toDate] == NSOrderedAscending)) || ([recordDate compare:toDate] == NSOrderedSame)) {
                                    NSInteger steps = [arr[1] integerValue];
                                    historySteps += steps;
                                }
                            }];
                            
                            // 运动强度 = 步数/2分钟*0.0299
                            double strength = 0;
                            
                                // 每个时间段内的梅脱
                                strength = historySteps/2.0*0.0299;
                                //                                calorie = historySteps/16.0;
                                //                                // 每个时间段内的梅脱
                                //                                strength = calorie/weight/2.0/0.0167;
                                //                                if (historySteps) {
                                //                                    strength = historySteps/2.0/45.0+1;
                                //                                } else {
                                //                                    strength = 0;
                                //                                }
                            
                            if (strength >= 3 && strength <= 6) {
                                // 总的有效运动时间
                                self.validSportTime += 2;
                                self.vaildNumofSteps += historySteps;
                            }
                            
                            if (historySteps>0) {
                                self.totalSportTime +=2;
                            }
                            
                            // 总的梅脱
                            self.validSportValue += strength;
                            // 总步数
                            self.totalNumOfSteps += historySteps;
                            
                            
                            NSInteger realize;
                            
                            if (self.effectiveSportPoint>=[[StorageManager getEffectivepoint] integerValue]) {
                                
                                realize = 1;
                            }else{
                                realize = 0;
                            }
                            
                            
                            NSInteger index  = [self.daysTimeArr indexOfObject:object];
                            
                            if (historySteps == 0) {
                                
                            }else{
                                
                                [stepInfoArr addObject:@[@(index), fromDate, @(strength),@(historySteps),@(realize)]];
                                
                            }
                            
                            allStepInfoCount += 1;
                            
                            if (idx == timeArray.count-2) {
                                [self.daysStepInfoArr addObject:stepInfoArr];
                                // 整理数据
                                [self sortData:serialQueue block:block];
                            }


                        }
                    }];
                    
                }];
            }
        }
    });
}


@end
