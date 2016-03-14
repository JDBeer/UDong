//
//  AnalysisChatView.m
//  Udong
//
//  Created by wildyao on 16/1/13.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "AnalysisChatView.h"

@implementation AnalysisChatView
{
    NSString *_type;
    NSMutableArray *_pointArray;
    NSMutableArray *_precentArray;
    NSArray *_dateArray;
    
    
    
}

- (id)initWithFrame:(CGRect)frame pointArray:(NSMutableArray *)pointArray type:(NSString *)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorClearColor;
    
        _type = type;
        
        [_pointArray removeAllObjects];
        [_coordinateArray removeAllObjects];
        
        if (pointArray!=nil) {
//            _pointArray = [self insertDate:pointArray type:_type];
            _pointArray = pointArray;
        }else{
            _pointArray = pointArray = nil;
        }
        
        _coordinateArray = [[NSMutableArray alloc] init];
        
        self.blueView = [[UIImageView alloc] initWithImage:ImageNamed(@"icon_sign")];
        self.blueView.frame = CGRectMake(10, 0, 5, 15);
        [self addSubview:self.blueView];
        
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.blueView.right+10, 0, 180, 15)];
        self.descriptionLabel.text = @"每日身体机能变化";
        self.descriptionLabel.textColor = UIColorFromHex(0x999999);
        self.descriptionLabel.font = FONT(15);
        [self addSubview:self.descriptionLabel];

//       根据type值得到横坐标和纵坐标数组
        _precentArray = [self getPrecentArray:type];
        _dateArray = [self getDateArray:type];
        
    }
    return self;
}

- (void)setupTheGrad
{
    CAShapeLayer *backgroundLayer = [CAShapeLayer layer];
    
    backgroundLayer.frame = self.bounds;
    backgroundLayer.fillColor = kColorBtnColor.CGColor;
    backgroundLayer.backgroundColor = [UIColor redColor].CGColor;
    backgroundLayer.strokeColor = [UIColor redColor].CGColor;
    backgroundLayer.lineWidth = 1;
    self.backgroundLayer = backgroundLayer;
    
    CGMutablePathRef backgroundPath = CGPathCreateMutable();
    
    if ([_type isEqualToString:@"1"]) {
        //    1.取X，Y轴间隔值
        
        double dateInterval = (self.width-65)/_pointArray.count;
        double bodyInterval = (25*5)/5;
        
        //    2.换算坐标
        
        for (int i=0; i<_pointArray.count; i++) {
            
            float X = 55+20+dateInterval*i;
            NSString *Yposition = _pointArray[i][0];
            float Y = [Yposition floatValue]*bodyInterval;
            
            NSString *xpointString = [NSString stringWithFormat:@"%f",X];
            NSString *ypointString = [NSString stringWithFormat:@"%f",Y];
            
            NSArray *pointArray = @[xpointString,ypointString];
            
            [_coordinateArray addObject:pointArray];
            
        }

    }else if ([_type isEqualToString:@"2"]){
        //  根据传过来的pointArray绘点
        
        //    1.取X，Y轴间隔值
        
        double dateInterval = (self.width-65-50)/_pointArray.count;
        double bodyInterval = (25*5)/12.5;
        
        //    2.换算坐标
        
        for (int i=0; i<_pointArray.count; i++) {
            
            double X = 55+20+dateInterval*i;
            NSString *Yposition = _pointArray[i][0];
            double Y = [Yposition floatValue]*bodyInterval;
            
            NSString *xpointString = [NSString stringWithFormat:@"%f",X];
            NSString *ypointString = [NSString stringWithFormat:@"%f",Y];
            
            NSArray *pointArray = @[xpointString,ypointString];
            
            [_coordinateArray addObject:pointArray];
            
    }
        
    }else{
        
        //  根据传过来的pointArray绘点
        
        //    1.取X，Y轴间隔值
        
        double dateInterval = (self.width-65-50)/_pointArray.count;
        double bodyInterval = (25*5)/15;
        
        
        //    2.换算坐标
        
        for (int i=0; i<_pointArray.count; i++) {
            
            double X = 55+20+dateInterval*i;
            NSString *Yposition = _pointArray[i][0];
            double Y = [Yposition floatValue]*bodyInterval;
            NSString *xpointString = [NSString stringWithFormat:@"%f",X];
            NSString *ypointString = [NSString stringWithFormat:@"%f",Y];
            NSArray *pointArray = @[xpointString,ypointString];
            
            [_coordinateArray addObject:pointArray];
            
        }
    }
    
    
//  获取第一个点
    NSString * X = _coordinateArray[0][0];
    NSString * Y = _coordinateArray[0][1];
    
    float Xposition = [X floatValue];
    float Yposition = [Y floatValue];
    CGPathMoveToPoint(backgroundPath, NULL, Xposition, (25*5+15+15)-Yposition);
    
    //  添加终点
    for (int i=1; i<_coordinateArray.count; i++) {
        NSString * X = _coordinateArray[i][0];
        NSString * Y = _coordinateArray[i][1];
        
        float XPosition = [X floatValue];
        float YPosition = [Y floatValue];
        //   画背景
        CGPathAddLineToPoint(backgroundPath, NULL, XPosition, (25*5+15+15)-YPosition);
        
    }
   
    //  获取右下角的点
    NSString *lastX = [_coordinateArray lastObject][0];
    NSString *lastY = [_coordinateArray lastObject][1];
    
    float lastXPosition = [lastX floatValue];
    float lastYPosition = [lastY floatValue];
    
    // 获取右边底部的点
    
    CGPathAddLineToPoint(backgroundPath, NULL, lastXPosition, 25*5+15+15);
    
    // 回到第一个点
    CGPathAddLineToPoint(backgroundPath, NULL, Xposition, (25*5+15+15)-Yposition);
    
    CGPathCloseSubpath(backgroundPath);
    
    backgroundLayer.path = backgroundPath;
    [self.layer addSublayer:self.backgroundLayer];
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.backgroundLayer.bounds;
    gradientLayer.colors = @[(id)[kColorBtnColor CGColor], (id)[kColorBtnColor CGColor]];
    // 起始点
    gradientLayer.startPoint = CGPointMake(0, 0);
    // 结束点
    gradientLayer.endPoint   = CGPointMake(0, 1);
    // 渐变需要应用的layer
    gradientLayer.mask = self.backgroundLayer;

    
}


- (void)drawRect:(CGRect)rect
{
    CAShapeLayer *backgroundLayer = [CAShapeLayer layer];
    
    backgroundLayer.frame = self.bounds;
    backgroundLayer.fillColor = kColorBtnColor.CGColor;
    backgroundLayer.backgroundColor = [UIColor redColor].CGColor;
    backgroundLayer.strokeColor = [UIColor redColor].CGColor;
    backgroundLayer.lineWidth = 1;
    self.backgroundLayer = backgroundLayer;
    
    CGMutablePathRef backgroundPath = CGPathCreateMutable();
    
    double lineWidth = 1;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, false);
    double interVal = 25;
    
    if (_pointArray == nil) {
        //  画代表机能的六条线
        for (int i=0; i<_precentArray.count; i++) {
            CGContextSetLineWidth(context, 0.2);
            CGContextSetStrokeColorWithColor(context, UIColorFromHex(0x565F65).CGColor);
            CGContextMoveToPoint(context, 55, self.descriptionLabel.bottom+15+interVal*i);
            CGContextAddLineToPoint(context, self.width-10, self.descriptionLabel.bottom+15+interVal*i);
            CGContextStrokePath(context);
            
            UILabel *precentLabel = [[UILabel alloc] init];
            precentLabel.text = _precentArray[i];
            if (IS_IPONE_4_OR_LESS) {
                precentLabel.font = FONT(10);
            }else{
                precentLabel.font = FONT(12);
            }
            precentLabel.textAlignment = NSTextAlignmentCenter;
            precentLabel.textColor = UIColorFromHex(0x999999);
            precentLabel.width = 40;
            precentLabel.height = 12;
            precentLabel.centerY = self.descriptionLabel.bottom+15+interVal*i;
            precentLabel.left = 10;
            
            [self addSubview:precentLabel];
            
        }
        
        //  画时间label
        
        for (int i=0; i<_dateArray.count; i++) {
            UILabel *dateLabel = [[UILabel alloc] init];
            dateLabel.text = _dateArray[i];
            if (IS_IPONE_4_OR_LESS) {
                dateLabel.font = FONT(8);
            }else{
                dateLabel.font = FONT(10);
            }
            dateLabel.textAlignment = NSTextAlignmentCenter;
            dateLabel.textColor = UIColorFromHex(0x999999);
            dateLabel.width = 35;
            dateLabel.height = 12;
            
            if (IS_IPONE_4_OR_LESS||IS_IPHONE_5) {
                dateLabel.centerX = 55+20+34*i;
            }else if (IS_IPHONE_6){
                dateLabel.centerX = 55+20+40*i;
            }else if (IS_IPHONE_6P){
                dateLabel.centerX = 55+20+50*i;
            }
            
            dateLabel.bottom = self.descriptionLabel.bottom+10+interVal*6;
            
            [self addSubview:dateLabel];
        }

    }else{
        //  画代表机能的六条线
        for (int i=0; i<_precentArray.count; i++) {
            CGContextSetLineWidth(context, lineWidth);
            CGContextSetStrokeColorWithColor(context, UIColorFromHex(0x565F65).CGColor);
            CGContextMoveToPoint(context, 55, self.descriptionLabel.bottom+15+interVal*i);
            CGContextAddLineToPoint(context, self.width-10, self.descriptionLabel.bottom+15+interVal*i);
            CGContextStrokePath(context);
            
            UILabel *precentLabel = [[UILabel alloc] init];
            precentLabel.text = _precentArray[i];
            if (IS_IPONE_4_OR_LESS) {
                precentLabel.font = FONT(10);
            }else{
                precentLabel.font = FONT(12);
            }
            precentLabel.textAlignment = NSTextAlignmentCenter;
            precentLabel.textColor = UIColorFromHex(0x999999);
            precentLabel.width = 40;
            precentLabel.height = 12;
            precentLabel.centerY = self.descriptionLabel.bottom+15+interVal*i;
            precentLabel.left = 10;
            
            [self addSubview:precentLabel];
            
        }
        
        //  画时间label
        
        for (int i=0; i<_dateArray.count; i++) {
            UILabel *dateLabel = [[UILabel alloc] init];
            dateLabel.text = _dateArray[i];
            if (IS_IPONE_4_OR_LESS) {
                dateLabel.font = FONT(8);
            }else{
                dateLabel.font = FONT(10);
            }
            dateLabel.textAlignment = NSTextAlignmentCenter;
            dateLabel.textColor = UIColorFromHex(0x999999);
            dateLabel.width = 35;
            dateLabel.height = 12;
            
            double interr = (self.width-75-30)/(_dateArray.count-1);
            
//            if (IS_IPONE_4_OR_LESS||IS_IPHONE_5) {
//                dateLabel.centerX = 55+20+34*i;
//            }else if (IS_IPHONE_6){
//                dateLabel.centerX = 55+20+40*i;
//            }else if (IS_IPHONE_6P){
//                dateLabel.centerX = 55+20+50*i;
//            }
            dateLabel.centerX = 55+20+interr*i;
            
            dateLabel.bottom = self.descriptionLabel.bottom+10+interVal*6;
            
            [self addSubview:dateLabel];
        }

        if ([_type isEqualToString:@"1"]) {
            //  根据传过来的pointArray绘点
            
            //    1.取X，Y轴间隔值
            
            double dateInterval = (self.width-75-30)/(_dateArray.count-1);
            
            double bodyInterval = (interVal*5)/5;
            
            //    2.换算坐标
            
            for (int i=0; i<_pointArray.count; i++) {
                
               //一周的第一天0点
                NSInteger date = [self getDateArrayFirstTimeDate:@"1"];
                
                NSString *aa = _pointArray[i][1];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yy-MM-dd"];
                
                NSDate *pointDate = [formatter dateFromString:aa];
                
                
                //得到pointArray中返回的运动日期时间戳
                NSInteger pointTimeSp = [pointDate timeIntervalSince1970];
                
                //计算间隔的天数
                NSInteger interValDay = (pointTimeSp-date)/OneDaySeconds;
                
                float X = 55+20+dateInterval*interValDay;
                NSString *Yposition = _pointArray[i][0];
                float Y = [Yposition floatValue]*bodyInterval;
                
                NSString *xpointString = [NSString stringWithFormat:@"%f",X];
                NSString *ypointString = [NSString stringWithFormat:@"%f",Y];
                
                NSArray *pointArray = @[xpointString,ypointString];
                
                [_coordinateArray addObject:pointArray];
                
            }
            
            
            //   3.根据换算坐标画线
            //   画起点
            NSString * X = _coordinateArray[0][0];
            NSString * Y = _coordinateArray[0][1];
            
            double Xposition = [X floatValue];
            double Yposition = [Y floatValue];
            CGContextSetLineWidth(context, lineWidth);
            CGContextSetStrokeColorWithColor(context, kColorWhiteColor.CGColor);
            CGContextSetLineCap(context, kCGLineCapRound);
            CGContextSetLineJoin(context, kCGLineJoinRound);
            
            CGContextMoveToPoint(context, Xposition, (interVal*5+15+15)-Yposition);
            CGPathMoveToPoint(backgroundPath, NULL, Xposition, (interVal*5+15+15)-Yposition);
            
            //  添加终点
            for (int i=1; i<_coordinateArray.count; i++) {
                NSString * X = _coordinateArray[i][0];
                NSString * Y = _coordinateArray[i][1];
                
                float XPosition = [X floatValue];
                float YPosition = [Y floatValue];
                CGContextAddLineToPoint(context, XPosition,(interVal*5+15+15)-YPosition);
                
            }
            
            CGContextStrokePath(context);
            
            //   4.画圆点
            
            for (int i=0; i<_coordinateArray.count; i++) {
                
                NSString * X = _coordinateArray[i][0];
                NSString * Y = _coordinateArray[i][1];
                
                float XPosition = [X floatValue];
                float YPosition = [Y floatValue];
                
                CGContextSetStrokeColorWithColor(context, kColorBtnColor.CGColor);//画笔线的颜色
                CGContextSetFillColorWithColor(context, kColorBtnColor.CGColor);//填充颜色
                CGContextSetLineWidth(context, 1.0);
                CGContextAddArc(context, XPosition, (interVal*5+15+15)-YPosition, 2, 0, 2*M_PI, 0); //添加一个圆
                CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
                
            }
            
        }else if ([_type isEqualToString:@"2"]){
            
            //  根据传过来的pointArray绘点
            
            //    1.取X，Y轴间隔值
           
            double dateInterval = (self.width-75-30)/(31-1);
            double bodyInterval = (interVal*5)/12.5;
            
            //    2.换算坐标
            
            for (int i=0; i<_pointArray.count; i++) {
                
                
                //一个月的第一天0点
                NSInteger date = [self getDateArrayFirstTimeDate:@"2"];
                
                
                NSString *aa = _pointArray[i][1];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yy-MM-dd"];
                
                NSDate *pointDate = [formatter dateFromString:aa];
                
                //得到pointArray中返回的运动日期时间戳
                NSInteger pointTimeSp = [pointDate timeIntervalSince1970];
                
                //计算间隔的天数
                NSInteger interValDay = (pointTimeSp-date)/OneDaySeconds;

                
                
                double X = 55+20+dateInterval*interValDay;
                NSString *Yposition = _pointArray[i][0];
            
                double Y = [Yposition floatValue]*bodyInterval;
                
                NSString *xpointString = [NSString stringWithFormat:@"%f",X];
                NSString *ypointString = [NSString stringWithFormat:@"%f",Y];
                
                NSArray *pointArray = @[xpointString,ypointString];
                
                [_coordinateArray addObject:pointArray];
                
            }
            
            //    NSLog(@"%@",_coordinateArray);
            
        
            //   3.根据换算坐标画线
            //   画起点
            NSString * X = _coordinateArray[0][0];
            NSString * Y = _coordinateArray[0][1];
            
            float Xposition = [X floatValue];
            float Yposition = [Y floatValue];
            CGContextSetLineWidth(context, lineWidth);
            CGContextSetStrokeColorWithColor(context, kColorWhiteColor.CGColor);
            CGContextSetLineCap(context, kCGLineCapRound);
            CGContextSetLineJoin(context, kCGLineJoinRound);
            CGContextMoveToPoint(context, Xposition, (interVal*5+15+15)-Yposition);
            
            //  添加终点
            for (int i=1; i<_coordinateArray.count; i++) {
                NSString * X = _coordinateArray[i][0];
                NSString * Y = _coordinateArray[i][1];
                
                float XPosition = [X floatValue];
                float YPosition = [Y floatValue];
                CGContextAddLineToPoint(context, XPosition,(interVal*5+15+15)-YPosition);
                //   画背景
//                CGPathAddLineToPoint(backgroundPath, NULL, XPosition, (interVal*5+15+15)-YPosition);
                
            }
            
            //    获取最后一个点的底部坐标
            
//            NSString *lastX = [_coordinateArray lastObject][0];
//            NSString *lastY = [_coordinateArray lastObject][1];
//            
//            float lastXPosition = [lastX floatValue];
//            float lastYPosition = [lastY floatValue];
            
            CGContextStrokePath(context);
            
            
            //    5.添加渐变图层
            
            // 获取第一个点和右边底部的点
            
//            CGPathAddLineToPoint(backgroundPath, NULL, lastXPosition, interVal*5+15+15);
            // 回到第一个点
//            CGPathAddLineToPoint(backgroundPath, NULL, Xposition, (interVal*5+15+15)-Yposition);
            
            // 关闭path，形成封闭区域
//            CGPathCloseSubpath(backgroundPath);

//            self.backgroundLayer.path = backgroundPath;
//            [self.layer addSublayer:self.backgroundLayer];
//            
//            
//            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//            gradientLayer.frame = self.backgroundLayer.bounds;
//            gradientLayer.colors = @[(id)[kColorBtnColor CGColor], (id)[[UIColor whiteColor] CGColor]];
//            // 起始点
//            gradientLayer.startPoint = CGPointMake(0, 0);
//            // 结束点
//            gradientLayer.endPoint   = CGPointMake(0, 1);
//            // 渐变需要应用的layer
//            gradientLayer.mask = self.backgroundLayer;

        }else{
            
            //  根据传过来的pointArray绘点
            
            //    1.取X，Y轴间隔值
            
            double dateInterval = (self.width-75-30)/(91-1);
            double bodyInterval = (interVal*5)/15;
            
            
            //    2.换算坐标
            
            for (int i=0; i<_pointArray.count; i++) {
                
                
                //三个月的第一天0点
                NSInteger date = [self getDateArrayFirstTimeDate:@"3"];
                
                NSString *aa = _pointArray[i][1];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yy-MM-dd"];
                
                NSDate *pointDate = [formatter dateFromString:aa];
                
                //得到pointArray中返回的运动日期时间戳
                NSInteger pointTimeSp = [pointDate timeIntervalSince1970];
                
                //计算间隔的天数
                NSInteger interValDay = (pointTimeSp-date)/OneDaySeconds;
                
                double X = 55+20+dateInterval*interValDay;
                NSString *Yposition = _pointArray[i][0];
                double Y = [Yposition floatValue]*bodyInterval;
                
                
                NSString *xpointString = [NSString stringWithFormat:@"%f",X];
                NSString *ypointString = [NSString stringWithFormat:@"%f",Y];
                
                NSArray *pointArray = @[xpointString,ypointString];
                
                [_coordinateArray addObject:pointArray];
                
            }
            
            //    NSLog(@"%@",_coordinateArray);
            
            
            
            //   3.根据换算坐标画线
            //   画起点
            NSString * X = _coordinateArray[0][0];
            NSString * Y = _coordinateArray[0][1];
            
            float Xposition = [X floatValue];
            float Yposition = [Y floatValue];
            CGContextSetLineWidth(context, lineWidth);
            CGContextSetStrokeColorWithColor(context, kColorWhiteColor.CGColor);
            CGContextSetLineCap(context, kCGLineCapRound);
            CGContextSetLineJoin(context, kCGLineJoinRound);
            CGContextMoveToPoint(context, Xposition, (interVal*5+15+15)-Yposition);
            //  添加终点
            for (int i=1; i<_coordinateArray.count; i++) {
                NSString * X = _coordinateArray[i][0];
                NSString * Y = _coordinateArray[i][1];
                
                float XPosition = [X floatValue];
                float YPosition = [Y floatValue];
                CGContextAddLineToPoint(context, XPosition,(interVal*5+15+15)-YPosition);
                
            }
            
            CGContextStrokePath(context);
            
        }

    }
    
}

- (NSMutableArray *)getPrecentArray:(NSString *)type
{
    NSMutableArray *precentArray = [[NSMutableArray alloc] init];
    if ([type isEqualToString:@"1"]) {
         precentArray = [[NSMutableArray alloc] initWithObjects:@"5%",@"4%",@"3%",@"2%",@"1%",@"0", nil];
    }else if ([type isEqualToString:@"2"]){
         precentArray = [[NSMutableArray alloc] initWithObjects:@"12.5%",@"10.0%",@"7.5%",@"5.0%",@"2.5%",@"0", nil];
    }else{
        precentArray = [[NSMutableArray alloc] initWithObjects:@"15%",@"12%",@"9%",@"6%",@"3%",@"0", nil];
    }
    return precentArray;
}

- (NSArray *)getDateArray:(NSString *)type
{
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    NSArray *reverseArray = [[NSArray alloc] init];
    NSDate *date = [NSDate date];
    NSDate *nowDate = [date dateByAddingTimeInterval:8*3600];
    
    if ([type isEqualToString:@"1"]) {
        for (int i=0; i<7; i++) {
            NSDate *weekDate = [nowDate dateByAddingTimeInterval:-OneDaySeconds*i-8*3600];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM/dd"];
            NSString *dateString = [formatter stringFromDate:weekDate];
            
            [dateArray addObject:dateString];
            
            reverseArray = [[dateArray reverseObjectEnumerator] allObjects];
            
    }
    }else if ([type isEqualToString:@"2"]){
        
        for (int i=0; i<7; i++) {
            NSDate *weekDate = [nowDate dateByAddingTimeInterval:-5*OneDaySeconds*i-8*3600];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM/dd"];
            NSString *dateString = [formatter stringFromDate:weekDate];
            [dateArray addObject:dateString];
            
            reverseArray = [[dateArray reverseObjectEnumerator] allObjects];
    }
    }else{
        
        for (int i=0; i<7; i++) {
            NSDate *weekDate = [nowDate dateByAddingTimeInterval:-15*OneDaySeconds*i-8*3600];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM/dd"];
            NSString *dateString = [formatter stringFromDate:weekDate];
            [dateArray addObject:dateString];
            
            reverseArray = [[dateArray reverseObjectEnumerator] allObjects];
            
        }
    }
    return reverseArray;
}

- (NSMutableArray *)insertDate:(NSMutableArray *)pointArray type:(NSString *)type
{
    
    NSMutableArray *yyArray = [pointArray mutableCopy];
    
    if ([type isEqualToString:@"1"]) {
        if (pointArray.count<7) {
            NSString *lastDateString = pointArray.firstObject[1];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [formatter dateFromString:lastDateString];
            NSDate *lastDate = [date dateByAddingTimeInterval:8*3600];
            
            for (int i=0; i<=7-pointArray.count; i++) {
                
                NSDate *addtionDate = [lastDate dateByAddingTimeInterval:-OneDaySeconds*(i+1)];
                NSString *addtionDateSrting = [NSString stringWithFormat:@"%@",addtionDate];
                NSString *subString = [addtionDateSrting substringWithRange:NSMakeRange(0, 10)];
                NSArray *addtionArray = @[@"0",subString];
                [yyArray insertObject:addtionArray atIndex:0];
            }
            
        }
    }

    if ([type isEqualToString:@"2"]) {
        if (pointArray.count<30) {
             NSString *lastDateString = pointArray.firstObject[1];
             NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [formatter dateFromString:lastDateString];
            NSDate *lastDate = [date dateByAddingTimeInterval:8*3600];
            
            for (int i=0; i<=30-pointArray.count; i++) {
                
                NSDate *addtionDate = [lastDate dateByAddingTimeInterval:-OneDaySeconds*(i+1)];
                NSString *addtionDateSrting = [NSString stringWithFormat:@"%@",addtionDate];
                NSString *subString = [addtionDateSrting substringWithRange:NSMakeRange(0, 10)];
                NSArray *addtionArray = @[@"0",subString];
                [yyArray insertObject:addtionArray atIndex:0];
            }
            
        }
    }
    
    
    if ([type isEqualToString:@"3"]) {
        if (pointArray.count<90) {
            NSString *lastDateString = pointArray.firstObject[1];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [formatter dateFromString:lastDateString];
            NSDate *lastDate = [date dateByAddingTimeInterval:8*3600];
            
            for (int i=0; i<=90-pointArray.count; i++) {
                
                NSDate *addtionDate = [lastDate dateByAddingTimeInterval:-OneDaySeconds*(i+1)];
                NSString *addtionDateSrting = [NSString stringWithFormat:@"%@",addtionDate];
                NSString *subString = [addtionDateSrting substringWithRange:NSMakeRange(0, 10)];
                NSArray *addtionArray = @[@"0",subString];
                [yyArray insertObject:addtionArray atIndex:0];
            }
            
        }
    }

    return yyArray;
    
}

- (NSInteger)getDateArrayFirstTimeDate:(NSString *)type
{
    if ([type isEqualToString:@"1"]) {
        NSDate *weekDate = [[NSDate date] dateByAddingTimeInterval:-OneDaySeconds*6-8*3600];
        
        NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *todate = [weekDate dateByAddingTimeInterval:8*3600];
        NSDateComponents *comps = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:todate];
        [comps setHour:0];
        NSDate *zeroDate = [calender dateFromComponents:comps];
        NSInteger aa = [zeroDate timeIntervalSince1970];
        
        return aa;

    }else if ([type isEqualToString:@"2"]) {
        NSDate *weekDate = [[NSDate date] dateByAddingTimeInterval:-OneDaySeconds*30-8*3600];
        
        NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *todate = [weekDate dateByAddingTimeInterval:8*3600];
        NSDateComponents *comps = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:todate];
        [comps setHour:0];
        NSDate *zeroDate = [calender dateFromComponents:comps];
        NSInteger aa = [zeroDate timeIntervalSince1970];
        
        return aa;
    }else{
        
        NSDate *weekDate = [[NSDate date] dateByAddingTimeInterval:-OneDaySeconds*90-8*3600];
        
        NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *todate = [weekDate dateByAddingTimeInterval:8*3600];
        NSDateComponents *comps = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:todate];
        [comps setHour:0];
        NSDate *zeroDate = [calender dateFromComponents:comps];
        NSInteger aa = [zeroDate timeIntervalSince1970];
        
        return aa;
    }
    
}


@end
