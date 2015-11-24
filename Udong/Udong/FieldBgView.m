//
//  FieldBgView.m
//  Udong
//
//  Created by wildyao on 15/11/16.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "FieldBgView.h"

@implementation FieldBgView
{
    NSInteger _inset;
    NSInteger _count;
}


- (id)initWithFrame:(CGRect)frame inset:(NSInteger)inset count:(NSInteger)count
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _inset = inset;
        _count = count;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    double lineWidth = 0.1;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, false);
    CGContextSetLineWidth(context, lineWidth);
    
    CGContextSetStrokeColorWithColor(context, kColorCellSeparator.CGColor);
    
//    CGContextMoveToPoint(context, _inset, lineWidth);
//    CGContextAddLineToPoint(context, rect.size.width, lineWidth);
    CGContextMoveToPoint(context, _inset, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    
    CGFloat height = rect.size.height/_count;
    
    for (int i = 1; i < _count; i++) {
        CGContextSetLineWidth(context, lineWidth);
        CGContextSetStrokeColorWithColor(context, kColorCellSeparator.CGColor);
        CGContextMoveToPoint(context, _inset, height*i);
        CGContextAddLineToPoint(context, rect.size.width, height*i);
    }
    
    CGContextStrokePath(context);

}


@end
