//
//  NewSportItemView.m
//  Udong
//
//  Created by wildyao on 16/3/9.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "NewSportItemView.h"

@implementation NewSportItemView

{
    NSString * left;
    NSString * right;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorClearColor;
        
        self.effectiveLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.effectiveLabel.textColor = UIColorFromHex(0x999999);
        self.effectiveLabel.font = FONT(15);
        self.effectiveLabel.textAlignment = NSTextAlignmentCenter;
        self.effectiveLabel.text = @"有效运动";
        [self.effectiveLabel sizeToFit];
        [self addSubview:self.effectiveLabel];
        
        self.NulleffectiveLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.NulleffectiveLabel.textColor = UIColorFromHex(0x999999);
        self.NulleffectiveLabel.font = FONT(15);
        self.NulleffectiveLabel.textAlignment = NSTextAlignmentCenter;
        self.NulleffectiveLabel.text = @"无效运动";
        [self.NulleffectiveLabel sizeToFit];
        [self addSubview:self.NulleffectiveLabel];
        
        
        self.leftNumber = [[UILabel alloc] initWithFrame:CGRectZero];
        self.leftNumber.textColor = UIColorFromHex(0xCDCDCD);
        self.leftNumber.font = FONT(24);
        self.leftNumber.textAlignment = NSTextAlignmentRight;
        [self.leftNumber sizeToFit];
        [self addSubview:self.leftNumber];
        
        self.rightNumber = [[UILabel alloc] initWithFrame:CGRectZero];
        self.rightNumber.textColor = UIColorFromHex(0xCDCDCD);
        self.rightNumber.font = FONT(24);
        self.rightNumber.textAlignment = NSTextAlignmentCenter;
        [self.rightStepLabel sizeToFit];
        [self addSubview:self.rightNumber];
        
        self.leftStepLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.leftStepLabel.textColor = UIColorFromHex(0x999999);
        self.leftStepLabel.font = FONT(15);
        self.leftStepLabel.textAlignment = NSTextAlignmentCenter;
        self.leftStepLabel.text = @"步";
        [self.leftStepLabel sizeToFit];
        [self addSubview:self.leftStepLabel];
        
        
        self.rightStepLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.rightStepLabel.textColor = UIColorFromHex(0x999999);
        self.rightStepLabel.font = FONT(15);
        self.rightStepLabel.textAlignment = NSTextAlignmentCenter;
        self.rightStepLabel.text = @"步";
        [self.rightStepLabel sizeToFit];
        [self addSubview:self.rightStepLabel];

        
    }
    
    return self;
}


- (void)setLeftNumberText:(NSString *)leftNumber
{
    
    self.leftNumber.text = leftNumber;
    
    [self.leftNumber sizeToFit];
}

- (void)setRightNumberText:(NSString *)rightNumber
{
    
    self.rightNumber.text = rightNumber;
    [self.rightNumber sizeToFit];
}

- (void)layoutSubviews
{
   
    float halfWidth = self.width/2;
    
    CGSize size = [LabelHelper getSizeWith:self.effectiveLabel.text font:15];
    self.effectiveLabel.height = size.height;
    self.effectiveLabel.width = size.width;
    self.effectiveLabel.centerX = halfWidth/2;
    self.effectiveLabel.top = 10;
    
    
    CGSize size1 = [LabelHelper getSizeWith:self.NulleffectiveLabel.text font:15];
    self.NulleffectiveLabel.height = size1.height;
    self.NulleffectiveLabel.width = size1.width;
    self.NulleffectiveLabel.centerX = halfWidth+halfWidth/2;
    self.NulleffectiveLabel.top = self.effectiveLabel.top;
    
    
    CGSize size2 = [LabelHelper getSizeWith:self.leftNumber.text font:24];
    self.leftNumber.height = size2.height;
    self.leftNumber.width = size2.width;
    self.leftNumber.centerX = self.effectiveLabel.centerX;
    self.leftNumber.top = self.effectiveLabel.bottom+10;
    
    
    
    CGSize size3 = [LabelHelper getSizeWith:self.leftStepLabel.text font:15];
    self.leftStepLabel.width = size3.width;
    self.leftStepLabel.height = size3.height;
    self.leftStepLabel.left = self.leftNumber.right+2;
    self.leftStepLabel.centerY = self.leftNumber.centerY;
    
    
    
    
    CGSize size4 = [LabelHelper getSizeWith:self.rightNumber.text font:24];
    
    CGFloat nameH = size4.height;
    CGFloat nameW = size4.width;
    
    self.rightNumber.height = nameH;
    self.rightNumber.width = nameW;
    self.rightNumber.centerX = self.NulleffectiveLabel.centerX;
    self.rightNumber.top = self.NulleffectiveLabel.bottom+10;
    
    
    
    CGSize size5 = [LabelHelper getSizeWith:self.rightStepLabel.text font:15];
    
    self.rightStepLabel.width = size5.width;
    self.rightStepLabel.height = size5.height;
    self.rightStepLabel.left = self.rightNumber.right+2;
    self.rightStepLabel.centerY = self.rightNumber.centerY;
    
    
    
    
}

- (void)drawRect:(CGRect)rect
{
    
    float halfWidth = self.width/2;
    
    double lineWidth = 1;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, false);
    
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, UIColorFromHex(0x4F4E4D).CGColor);
    CGContextMoveToPoint(context, halfWidth, 0);
    CGContextAddLineToPoint(context, halfWidth, self.height-1);
    CGContextStrokePath(context);
    
    
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, UIColorFromHex(0x4F4E4D).CGColor);
    CGContextMoveToPoint(context, 0, self.height);
    CGContextAddLineToPoint(context, self.width, self.height-1);
    CGContextStrokePath(context);
    
}


@end
