//
//  ResultScoreView.m
//  PalmMedicine
//
//  Created by wildyao on 15/3/3.
//  Copyright (c) 2015年 Wild Yaoyao. All rights reserved.
//

#import "ResultScoreView.h"

@interface ResultScoreView ()
{
    CAShapeLayer *arcLayer;
    NSInteger count;
    CGFloat gapTime;
    UIColor *_color;
    CGFloat _lineWidth;
    CGFloat _aa;
    NSString *_totalStepCount;
}

@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, assign) NSInteger index;

@end

@implementation ResultScoreView

- (id)initWithFrame:(CGRect)frame type:(int)type sublabel:(NSString *)sublabel totalStepCount:(NSString *)totalStepCount {
    if (self = [super initWithFrame:frame]) {
        
        if (type == 0) {
            self.layer.cornerRadius = frame.size.width/2;
            self.layer.masksToBounds = YES;
        } else {
            self.backgroundColor = [UIColor clearColor];
        }
        
        
        self.arr = [NSMutableArray array];
        self.index = 0;
        gapTime = 0.01;
        
        _totalStepCount = totalStepCount;
        
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        self.scrollView.contentSize = CGSizeMake(self.width*2, self.height);
        self.scrollView.delegate = self;
        self.scrollView.bounces = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];

//    leftView
        
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        
        self.leftView.backgroundColor = kColorClearColor;
        self.leftView.layer.cornerRadius = self.height/2;
        self.leftView.layer.masksToBounds = YES;
        [self.scrollView addSubview:self.leftView];
        
        
        self.scoreLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        self.scoreLbl.text = @"0";
        self.scoreLbl.textAlignment = NSTextAlignmentCenter;

        if (type == 0) {
            self.scoreLbl.font = FONT(50);
        } else {
            self.scoreLbl.textColor = [UIColor whiteColor];
            self.scoreLbl.font = FONT(80);
        }
    
        [self.leftView addSubview:self.scoreLbl];
        
        self.subLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        self.subLbl.textAlignment = NSTextAlignmentCenter;
        
        if (type == 0) {
            self.subLbl.text = [NSString stringWithFormat:@"目标:%@有效运动点",sublabel];
            self.subLbl.font = FONT(12);
            if (IS_IPONE_4_OR_LESS) {
                self.subLbl.font = FONT(10);
            }
            
        } else {
            self.subLbl.text = @"0";
            self.subLbl.textColor = [UIColor whiteColor];
            self.subLbl.font = FONT(23);
        }

        [self.subLbl sizeToFit];
        [self.leftView addSubview:self.subLbl];
        
        
//     rightView
        
        self.rightView = [[UIView alloc] initWithFrame:CGRectMake(self.width, 0, self.width, self.height)];
        
        self.rightView.backgroundColor = kColorClearColor;
        self.rightView.layer.cornerRadius = self.height/2;
        self.rightView.layer.masksToBounds = YES;
       
        [self.scrollView addSubview:self.rightView];
        
        
        self.countSteplabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.countSteplabel.textAlignment = NSTextAlignmentCenter;
        
        if (type == 0) {
            self.countSteplabel.font = FONT(50);
        } else {
            self.countSteplabel.textColor = [UIColor whiteColor];
            self.countSteplabel.font = FONT(80);
        }
        
        [self.rightView addSubview:self.countSteplabel];
        
        
        self.wordlabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.wordlabel.textAlignment = NSTextAlignmentCenter;
        
        if (type == 0) {
            self.wordlabel.text = @"累计运动步数";
            self.wordlabel.font = FONT(12);
            if (IS_IPONE_4_OR_LESS) {
                self.wordlabel.font = FONT(10);
            }
            
        } else {
            self.wordlabel.text = @"累计运动步数";
            self.wordlabel.textColor = [UIColor whiteColor];
            self.wordlabel.font = FONT(23);
        }
        
        [self.wordlabel sizeToFit];
        [self.rightView addSubview:self.wordlabel];
        
        
//      lineView
        self.lineView = [[UIView alloc] initWithFrame:CGRectZero];
        self.lineView.backgroundColor = kColorContentColor;
        [self addSubview:self.lineView];
        
        
        self.pageController = [[UIPageControl alloc] initWithFrame:CGRectZero];
        self.pageController.numberOfPages = 2;
        self.pageController.pageIndicatorTintColor = kColorContentColor;
        self.pageController.currentPageIndicatorTintColor = kColorWhiteColor;
        self.pageController.currentPage = 0;
        
        [self addSubview:self.pageController];
        
        
//        self.pointView = [[UIView alloc] initWithFrame:CGRectZero];
//        self.pointView.backgroundColor = kColorBtnColor;
//        self.pointView.layer.cornerRadius = 5;
//        self.pointView.layer.masksToBounds = YES;
//        [self addSubview:self.pointView];
        
        
        _type = type;
    }
    return self;
}

- (void)setStrokeColor:(UIColor *)color scorelbColor:(UIColor *)scorelbColor sublabColor:(UIColor *)sublabColor backgroundColor:(UIColor *)bgColor lineWidth:(CGFloat)lineWidth
{
    if (_type == 0) {
        
        self.backgroundColor = bgColor;
        self.scoreLbl.textColor = scorelbColor;
        self.subLbl.textColor = sublabColor;
        
        self.countSteplabel.textColor = scorelbColor;
        self.wordlabel.textColor = sublabColor;
    }
   
    _color = color;
    _lineWidth = lineWidth;
}

- (void)setLblText:(NSString *)text angle:(CGFloat)angle
{
    [self.arr removeAllObjects];
    self.index = 0;
    gapTime = 0.01;
    count =0;
    _angle = angle;
    
    self.scoreLbl.text = text;
    [self.scoreLbl sizeToFit];
    
    if ([text isEqualToString:@"?"]) {
        [self flip];
        return;
    }

    count = [text integerValue]+1;
    
    for (NSInteger i = 0 ; i < [text integerValue]+1; i++) {
        [self.arr addObject:@(i)];
    }
    
    _gapTimePlus = (self.arr.count-21)*0.01+15*0.06+6*0.16;

    self.timer = [NSTimer timerWithTimeInterval:gapTime target:self selector:@selector(animate) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}


- (void)setcountStepNumber:(NSString *)stepCount
{
    self.countSteplabel.text = stepCount;
    [self.countSteplabel sizeToFit];

}

- (void)flip
{
//    CABasicAnimation *flipAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//    flipAnimation.duration = 2.0;
//    flipAnimation.toValue = [NSNumber numberWithDouble:-2*M_PI];
//    flipAnimation.cumulative = YES;
//    flipAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    flipAnimation.autoreverses = YES;
//    flipAnimation.repeatCount = FLT_MAX;
//    [self.scoreLbl.layer addAnimation:flipAnimation forKey:nil];
}

- (void)animate
{
   
    self.scoreLbl.text = [NSString stringWithFormat:@"%@", _arr[_index++]];

    [self.scoreLbl sizeToFit];

    if (_index == count-20) {
        [self.timer invalidate];
        gapTime = gapTime+0.05;

        self.timer = [NSTimer timerWithTimeInterval:gapTime target:self selector:@selector(animate) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
    if (_index == count-5) {
        [self.timer invalidate];
        gapTime = gapTime+0.1;

        self.timer = [NSTimer timerWithTimeInterval:gapTime target:self selector:@selector(animate) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
    if (_index == count) {
        [self.timer invalidate];
    }
}

- (void)layoutSubviews {

    if (_type == 0) {
        self.scoreLbl.centerX = self.width/2;
        self.scoreLbl.centerY = self.height/2-10;
        
        self.subLbl.centerX = self.scoreLbl.centerX;
        self.subLbl.top = self.scoreLbl.bottom+10;
        
        self.lineView.top = self.scoreLbl.bottom+3;
        self.lineView.centerX = self.scoreLbl.centerX;
        self.lineView.bounds = CGRectMake(0, 0, self.width-_lineWidth*2, 0.5);
        
        self.pageController.centerX = self.leftView.centerX;
        self.pageController.top = self.subLbl.bottom+6;
        self.pageController.width = 50;
        self.pageController.height = 10;
        
        
        self.countSteplabel.centerX = self.width/2;
        self.countSteplabel.centerY = self.height/2-10;
        
        
        self.wordlabel.centerX = self.countSteplabel.centerX;
        self.wordlabel.top = self.countSteplabel.bottom+10;
        
        
    } else {
        
        self.scoreLbl.centerX = self.width/2;
        self.scoreLbl.centerY = self.height/2-10;
        
        self.subLbl.centerX = self.scoreLbl.centerX;
        self.subLbl.top = self.scoreLbl.bottom+10;
        
        self.lineView.top = self.scoreLbl.bottom+3;
        self.lineView.centerX = self.scoreLbl.centerX;
        self.lineView.bounds = CGRectMake(0, 0, self.width-_lineWidth*2, 0.5);
        
        self.pageController.centerX = self.leftView.centerX;
        self.pageController.top = self.subLbl.bottom+6;
        self.pageController.width = 50;
        self.pageController.height = 10;
        
        self.countSteplabel.centerX = self.width/2;
        self.countSteplabel.centerY = self.height/2-10;
        
        self.wordlabel.centerX = self.countSteplabel.centerX;
        self.wordlabel.top = self.countSteplabel.bottom+10;

    }
}

- (void)drawRect:(CGRect)rect {
    
    if (self.type == 0) {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetAllowsAntialiasing(context, true);
        CGContextSetLineWidth(context, _lineWidth);
        CGContextSetStrokeColorWithColor(context, kColorWhiteColor.CGColor);
        CGContextAddArc(context, rect.size.width/2, rect.size.width/2, CGRectGetWidth(rect)/2, 0, M_PI*2, YES);
        CGContextStrokePath(context);

        CGFloat radius = CGRectGetWidth(rect)/2;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(rect.size.width/2, rect.size.width/2) radius:radius startAngle:-M_PI/2 endAngle:_angle clockwise:YES];
        arcLayer = [CAShapeLayer layer];
        arcLayer.frame = self.bounds;
        arcLayer.path = path.CGPath;
        arcLayer.fillColor = [UIColor clearColor].CGColor;
        arcLayer.strokeColor = _color.CGColor;
        arcLayer.lineWidth = _lineWidth;
        
        [self.layer addSublayer:arcLayer];
        [self drawLineAnimation:arcLayer];
    }
}

-(void)drawLineAnimation:(CALayer*)layer
{
   
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration = _gapTimePlus;
    bas.delegate = self;
    bas.fromValue = [NSNumber numberWithInteger:0];
    bas.toValue = [NSNumber numberWithInteger:1];
    [layer addAnimation:bas forKey:@"key"];
    
    
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGRect rect  = CGRectMake(0, 0, self.width, self.height);
    
    CGFloat radius = CGRectGetWidth(rect)/2;
    
    self.pageController.currentPage = scrollView.contentOffset.x/scrollView.width;
    
    if (self.pageController.currentPage == 0) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(rect.size.width/2, rect.size.width/2) radius:radius startAngle:-M_PI/2 endAngle:_angle clockwise:YES];
        arcLayer = [CAShapeLayer layer];
        arcLayer.frame = self.bounds;
        arcLayer.path = path.CGPath;
        arcLayer.fillColor = [UIColor clearColor].CGColor;
        arcLayer.strokeColor = _color.CGColor;
        arcLayer.lineWidth = _lineWidth;
        
        [self.layer addSublayer:arcLayer];
        
    }else{
        [arcLayer removeFromSuperlayer];
    }
}

//- (void)getTime:(NSNotification *)notification
//{
//    self.timeString = notification.object;
//}

@end
