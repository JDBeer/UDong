//
//  RulerView.m
//  Udong
//
//  Created by wildyao on 15/12/3.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "RulerView.h"

@implementation RulerView
{
    NSInteger _width;
    NSInteger _length;
    NSInteger _count;
    NSInteger _interval;
    NSMutableArray *_dataArray;

}

- (id)initWithFrame:(CGRect)frame width:(NSInteger)width length:(NSInteger)length count:(NSInteger)count interval:(NSInteger)interval dataArray:(NSMutableArray *)dataArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorClearColor;
        _width = width;
        _length = length;
        _count = count;
        _interval = interval;
        _dataArray = dataArray;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    
    double lineWidth = 0.1;
    double interval = _interval;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, false);
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, kColorClearColor.CGColor);
    
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, kColorClearColor.CGColor);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, _width, 0);
    CGContextStrokePath(context);
    
    
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, kColorClearColor.CGColor);
    CGContextMoveToPoint(context, 0, _length);
    CGContextAddLineToPoint(context, _width ,_length);
    CGContextStrokePath(context);
    
    for (int i=1; i<_count; i++) {
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, interval*i, 0);
        CGContextAddLineToPoint(context, interval*i, 20);
        CGContextSetStrokeColorWithColor(context, kColorContentColor.CGColor);
        UILabel *label = [[UILabel alloc] init];
        label.text = _dataArray[i-1];
        label.textColor = kColorContentColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.width = 50;
        label.height = 30;
        label.centerX = interval*i;
        label.top = 20+10;
        [self addSubview:label];

        CGContextStrokePath(context);
        
    }
    
    CGContextStrokePath(context);
}


@end
