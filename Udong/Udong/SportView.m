//
//  SportView.m
//  Udong
//
//  Created by wildyao on 15/12/21.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "SportView.h"

@implementation SportView
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
    
    double lineWidth = 1;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, false);
    
//  画上下两条线
//    CGContextSetLineWidth(context, lineWidth);
//    CGContextSetStrokeColorWithColor(context, kColorContentColor.CGColor);
//    CGContextMoveToPoint(context, 0, 0);
//    CGContextAddLineToPoint(context, _width, 0);
//    CGContextStrokePath(context);
    
    
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, UIColorFromHex(0x222326).CGColor);
    CGContextMoveToPoint(context, 0, _length);
    CGContextAddLineToPoint(context, _width, _length);
    CGContextStrokePath(context);
    
//   画有效运动矩形，并填充颜色
    CGContextStrokeRect(context,CGRectMake(0, _length/3, self.width, _length/3));
    CGContextFillRect(context,CGRectMake(0, _length/3, self.width, _length/3));
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetFillColorWithColor(context, [ColorManager getColor:@"183438" WithAlpha:1].CGColor);
    CGContextSetStrokeColorWithColor(context, kColorClearColor.CGColor);
    CGContextAddRect(context,CGRectMake(0, _length/3, self.width, _length/3));

    CGContextDrawPath(context, kCGPathFillStroke);
    
    
//   画多出来的半小时数据线
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, UIColorFromHex(0x585759).CGColor);
    CGContextMoveToPoint(context, _interval/2, _length);
    CGContextAddLineToPoint(context, _interval/2, _length-10);
    CGContextStrokePath(context);

//   画24小时线
    
    for (int i=1; i<_count; i++) {
        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, UIColorFromHex(0x585759).CGColor);
        CGContextMoveToPoint(context, _interval/2+i*_interval, _length);
        CGContextAddLineToPoint(context, _interval/2+i*_interval, _length-10);
        CGContextStrokePath(context);
        
        
//   根据24小时线设置时间label
        
        UILabel *label = [[UILabel alloc] init];
        label.text = _dataArray[i-1];
        label.font = FONT(12);
        label.textColor = [ColorManager getColor:@"585759" WithAlpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        label.width = 35;
        label.height = 18;
        label.centerX = _interval/2+(i-1)*_interval;
        label.top = _length+2;
        [self addSubview:label];
    }
    
    CGContextStrokePath(context);
    
    
//   根据传过来的点数组，绘制柱状图
//   1、for循环传过来的时间梅脱数组，得到新的坐标数组
    
    twoMinuteInterval = SCREEN_WIDTH/120;
    MeituoInterval = _length/9;
    
    for (int i=0; i<_pointArray.count; i++) {
        
        
//   计算点数组里的时间和零点的时间间隔
    
        NSString *string = [NSString stringWithFormat:@"%@",_pointArray[i][0]];
        
       
        NSInteger aa = [self getTimeIntervalWithString:string];
        
        
//   计算X，Y坐标
        
        float xPoint = _interval/2+aa*twoMinuteInterval-2*twoMinuteInterval;
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
            CGContextStrokeRect(context, CGRectMake(Xposition-twoMinuteInterval, _length-Yposition, twoMinuteInterval,Yposition));
            CGContextSetStrokeColorWithColor(context, kColorClearColor.CGColor);
            CGContextSetFillColorWithColor(context,UIColorFromHexWithAlpha(0xDABC2A, 1).CGColor);
            CGContextFillRect(context, CGRectMake(Xposition-twoMinuteInterval, _length-Yposition, twoMinuteInterval,Yposition));
            
            CGContextStrokePath(context);
        }else if (Yposition>=3*MeituoInterval&&Yposition<=6*MeituoInterval){
            
            CGContextSetLineWidth(context, 0.1);
            CGContextStrokeRect(context, CGRectMake(Xposition-twoMinuteInterval, _length-Yposition, twoMinuteInterval, Yposition));
            CGContextSetStrokeColorWithColor(context, kColorClearColor.CGColor);
            CGContextSetFillColorWithColor(context, UIColorFromHexWithAlpha(0x66C8E1, 1).CGColor);
            CGContextFillRect(context, CGRectMake(Xposition-twoMinuteInterval, _length-Yposition, twoMinuteInterval, Yposition));
            
            CGContextStrokePath(context);

            
        }else{
            
            CGContextSetLineWidth(context, 0.1);
            CGContextStrokeRect(context, CGRectMake(Xposition-twoMinuteInterval, _length-Yposition, twoMinuteInterval,Yposition));
            CGContextSetStrokeColorWithColor(context, kColorClearColor.CGColor);
            CGContextSetFillColorWithColor(context, UIColorFromHexWithAlpha(0xDE5B61, 1).CGColor);
            CGContextFillRect(context, CGRectMake(Xposition-twoMinuteInterval, _length-Yposition, twoMinuteInterval,Yposition));
            
            CGContextStrokePath(context);
            
        }
    }
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
