//
//  EffectiveView.m
//  Udong
//
//  Created by wildyao on 16/1/21.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "EffectiveView.h"

@implementation EffectiveView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorClearColor;
        
        self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button1.frame = CGRectZero;
        self.button1.backgroundColor = UIColorFromHex(0xFB9215);
        [self addSubview:self.button1];
        
        self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button2.frame = CGRectZero;
        self.button2.backgroundColor = UIColorFromHex(0x2FBEC8);
        [self addSubview:self.button2];
        
        self.label1 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label1.textAlignment = NSTextAlignmentLeft;
        self.label1.textColor = UIColorFromHex(0xA7A7A7);
        self.label1.font = FONT(13);
        self.label1.text = @"过剩能量消耗期";
        [self.label1 sizeToFit];
        [self addSubview:self.label1];
        
        self.label2 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label2.textAlignment = NSTextAlignmentLeft;
        self.label2.textColor = UIColorFromHex(0xA7A7A7);
        self.label2.font = FONT(13);
        self.label2.text = @"身体机能提升期";
        [self.label2 sizeToFit];
        [self addSubview:self.label2];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.button1.left = 25;
    self.button1.centerY = self.centerY;
    self.button1.width = self.button1.height = 10;
    
    self.label1.left = self.button1.right+5;
    self.label1.centerY = self.button1.centerY;
    self.label1.width = 100;
    
    self.label2.right = self.width-25;
    self.label2.centerY = self.button1.centerY;
    self.label2.width = 100;
    
    self.button2.right = self.label2.left-15;
    self.button2.centerY = self.button1.centerY-5;
    self.button2.width = self.button2.height = 10;
    
    
    
}

- (void)drawRect:(CGRect)rect
{
    
    
}


@end
