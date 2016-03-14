//
//  LandScreenView.m
//  Udong
//
//  Created by wildyao on 16/1/9.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "LandScreenView.h"

@implementation LandScreenView
{
    NSInteger _width;
    NSInteger _length;
    NSInteger _count;
    NSInteger _interval;
    NSMutableArray *_dataArray;
    NSMutableArray *_pointArray;//点信息数组
    NSInteger _type;//0表示当天，1表示不是当天
    
    float twoMinuteInterval;
    float MeituoInterval;
}
- (id)initWithFrame:(CGRect)frame width:(NSInteger)width length:(NSInteger)length count:(NSInteger)count interval:(NSInteger)interval dataArray:(NSMutableArray *)dataArray pointArray:(NSMutableArray *)pointArray type:(NSInteger)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorClearColor;
        _width = width;
        _length = length;
        _count = count;
        _interval = interval;
        _dataArray = dataArray;
        _pointArray = pointArray;
        _type = type;
        
        _coordinateArray = [[NSMutableArray alloc] init];

    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    double lineWidth = 0.1;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, false);

//  画上下两条线
    
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, UIColorFromHex(0x585759).CGColor);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, _width, 0);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, UIColorFromHex(0x585759).CGColor);
    CGContextMoveToPoint(context, 0, _length-20);
    CGContextAddLineToPoint(context, _width, _length-20);
    CGContextStrokePath(context);

//  画3小时间隔线
    
    for (int i=0; i<_count; i++) {
        CGContextSetLineWidth(context, lineWidth);
        CGContextSetStrokeColorWithColor(context, UIColorFromHex(0x585759).CGColor);
        CGContextMoveToPoint(context, _interval*i, 0);
        CGContextAddLineToPoint(context, _interval*i, _length-20);
        CGContextStrokePath(context);
    }
  
//  画3小时间隔时间点
    
    for (int i=0; i<_count; i++) {
        
        if (i==8) {
            UILabel *timeLabel = [[UILabel alloc] init];
            timeLabel.frame = CGRectMake((_interval-2)*i-20, _length-18, 40, 15);
            timeLabel.text = _dataArray[i];
            timeLabel.font = FONT(12);
            timeLabel.textColor = UIColorFromHex(0x585759);
            timeLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:timeLabel];
        }else{
            
            UILabel *timeLabel = [[UILabel alloc] init];
            timeLabel.frame = CGRectMake((_interval-2)*i, _length-18, 40, 15);
            timeLabel.text = _dataArray[i];
            timeLabel.font = FONT(12);
            timeLabel.textColor = UIColorFromHex(0x585759);
            timeLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:timeLabel];
        }
    }
    
//   画有效运动矩形，并填充颜色
    CGContextStrokeRect(context,CGRectMake(0, (_length-20)/3, self.width, (_length-20)/3));
    CGContextSetStrokeColorWithColor(context, kColorClearColor.CGColor);
    CGContextSetFillColorWithColor(context,UIColorFromHexWithAlpha(0xB3E7F7, 0.5).CGColor);
    CGContextFillRect(context, CGRectMake(0, (_length-20)/3, self.width, (_length-20)/3));
    CGContextStrokePath(context);
    
//  根据传过来的pointArray，绘制柱状图
    
    twoMinuteInterval = SCREEN_WIDTH/720;
    MeituoInterval = (_length-20)/9;
    
    for (int i=0; i<_pointArray.count; i++) {
        
        
        //   计算点数组里的时间和零点的时间间隔
        
        NSString *string = [NSString stringWithFormat:@"%@",_pointArray[i][0]];
        
        
        NSInteger aa = [self getTimeIntervalWithString:string];
        
        
        //   计算X，Y坐标
        
        float xPoint = aa*twoMinuteInterval-2*twoMinuteInterval;
        NSString *valueString = _pointArray[i][1];
        float value = [valueString floatValue];
        float yPoint = value * MeituoInterval;
        
        NSString *xpointString = [NSString stringWithFormat:@"%f",xPoint];
        NSString *ypointString = [NSString stringWithFormat:@"%f",yPoint];
        
        NSArray *pointArray = @[xpointString,ypointString];
        
        [_coordinateArray addObject:pointArray];
        
    }
    
    //   2、根据新的坐标数组，绘柱状图，并根据是否进入有效运动区间设置填充颜色
    
    for (int i=0; i<_coordinateArray.count; i++) {
        NSString * X = _coordinateArray[i][0];
        NSString * Y = _coordinateArray[i][1];
        
        float Xposition = [X floatValue];
        float Yposition = [Y floatValue];
        
        
        if (Yposition<3*MeituoInterval) {
            CGContextSetLineWidth(context, 0.1);
            CGContextStrokeRect(context, CGRectMake(Xposition-twoMinuteInterval, _length-20-Yposition, twoMinuteInterval, Yposition));
            CGContextSetStrokeColorWithColor(context, kColorClearColor.CGColor);
            CGContextSetFillColorWithColor(context,UIColorFromHexWithAlpha(0xFF9933, 0.74).CGColor);
            CGContextFillRect(context, CGRectMake(Xposition-twoMinuteInterval, _length-20-Yposition, twoMinuteInterval, Yposition));
            
            CGContextStrokePath(context);
        }else if (Yposition>=3*MeituoInterval&&Yposition<=6*MeituoInterval){
            
            CGContextSetLineWidth(context, 0.1);
            CGContextStrokeRect(context, CGRectMake(Xposition-twoMinuteInterval, _length-20-Yposition, twoMinuteInterval, Yposition));
            CGContextSetStrokeColorWithColor(context, kColorClearColor.CGColor);
            CGContextSetFillColorWithColor(context, UIColorFromHexWithAlpha(0x39C1E8, 1).CGColor);
            CGContextFillRect(context, CGRectMake(Xposition-twoMinuteInterval, _length-20-Yposition, twoMinuteInterval, Yposition));
            
            CGContextStrokePath(context);
            
            
        }else{
            
            CGContextSetLineWidth(context, 0.1);
            CGContextStrokeRect(context, CGRectMake(Xposition-twoMinuteInterval, _length-20-Yposition, twoMinuteInterval, Yposition));
            CGContextSetStrokeColorWithColor(context, kColorClearColor.CGColor);
            CGContextSetFillColorWithColor(context, UIColorFromHexWithAlpha(0xE24949, 1).CGColor);
            CGContextFillRect(context, CGRectMake(Xposition-twoMinuteInterval, _length-20-Yposition, twoMinuteInterval, Yposition));
            
            CGContextStrokePath(context);
            
        }
    }
    
    UILabel *effectLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 120, 40)];
    effectLabel.centerY = (_length-20)/2;
    effectLabel.text = @"有效运动区间";
    effectLabel.textColor = [ColorManager getColor:@"585759" WithAlpha:1];
    effectLabel.font = FONT(17);
    [self addSubview:effectLabel];

    
}

- (NSInteger)getTimeIntervalWithString:(NSString *)nowDateString
{
    if (_type == 0) {
        //  获取运动的时间点
        NSString *subString = [nowDateString substringToIndex:[nowDateString length]-5];
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *nowDate = [formatter dateFromString:subString];
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:nowDate];
        NSDate *now = [nowDate  dateByAddingTimeInterval:interval*2];
        
        //  获取当天的0点
        NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *todate = [NSDate date];
        NSDateComponents *comps = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:todate];
        [comps setHour:0];
        NSDate *zeroDate = [calender dateFromComponents:comps];
        NSTimeZone *zone1 = [NSTimeZone systemTimeZone];
        NSInteger interval1 = [zone1 secondsFromGMTForDate:zeroDate];
        NSDate *zero = [zeroDate  dateByAddingTimeInterval:interval1];
        
        //  计算两个时间点间的时间间隔
        
        NSTimeInterval val1 = [now timeIntervalSince1970];
        NSTimeInterval val2 = [zero timeIntervalSince1970];
        
        NSTimeInterval cha = val1-val2;
        
        NSInteger twominuteCount = cha/120;
        
        return twominuteCount;
    }else{
        
        //  获取运动的时间点
        NSString *subString = [nowDateString substringToIndex:[nowDateString length]-5];
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *nowDate = [formatter dateFromString:subString];
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:nowDate];
        NSDate *now = [nowDate  dateByAddingTimeInterval:interval*2];
        
        //  获取获取的那一天的0点
        NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *todate = [nowDate dateByAddingTimeInterval:interval];
        NSDateComponents *comps = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:todate];
        [comps setHour:0];
        NSDate *zeroDate = [calender dateFromComponents:comps];
        NSTimeZone *zone1 = [NSTimeZone systemTimeZone];
        NSInteger interval1 = [zone1 secondsFromGMTForDate:zeroDate];
        NSDate *zero = [zeroDate  dateByAddingTimeInterval:interval1];
        
        //  计算两个时间点间的时间间隔
        
        NSTimeInterval val1 = [now timeIntervalSince1970];
        NSTimeInterval val2 = [zero timeIntervalSince1970];
        
        NSTimeInterval cha = val1-val2;
        NSInteger twominuteCount = cha/120;
        
        
        return twominuteCount;
        
    }
    
}

@end
