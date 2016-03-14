//
//  StepHzView.m
//  Udong
//
//  Created by wildyao on 16/3/9.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "StepHzView.h"

@implementation StepHzView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = kColorClearColor;
        
        self.leftImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.leftImg.image = ImageNamed(@"icon_bupin");
        [self addSubview:self.leftImg];
        
        self.rightImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.rightImg.image = ImageNamed(@"icon_chixushijian");
        [self addSubview:self.rightImg];
        
        self.leftLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.leftLabel1.text = @"当前步频";
        self.leftLabel1.font = FONT(15);
        self.leftLabel1.textColor = UIColorFromHex(0x999999);
        self.leftLabel1.textAlignment = NSTextAlignmentCenter;
        [self.leftLabel1 sizeToFit];
        [self addSubview:self.leftLabel1];
        
        self.leftLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.leftLabel2.text = @"步/分钟";
        self.leftLabel2.font = FONT(15);
        self.leftLabel2.textColor = UIColorFromHex(0x999999);
        self.leftLabel2.textAlignment = NSTextAlignmentCenter;
        [self.leftLabel2 sizeToFit];
        [self addSubview:self.leftLabel2];
        
        self.rightLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.rightLabel1.text = @"有效持续时间";
        self.rightLabel1.font = FONT(15);
        self.rightLabel1.textColor = UIColorFromHex(0x999999);
        self.rightLabel1.textAlignment = NSTextAlignmentCenter;
        [self.rightLabel1 sizeToFit];
        [self addSubview:self.rightLabel1];
        
        self.rightLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.rightLabel2.text = @"分钟";
        self.rightLabel2.font = FONT(15);
        self.rightLabel2.textColor = UIColorFromHex(0x999999);
        self.rightLabel2.textAlignment = NSTextAlignmentCenter;
        [self.rightLabel2 sizeToFit];
        [self addSubview:self.rightLabel2];
        
        self.leftNumber = [[UILabel alloc] initWithFrame:CGRectZero];
        self.leftNumber.font = FONT(20);
        self.leftNumber.textColor = UIColorFromHex(0xAFAFAF);
        self.leftNumber.textAlignment = NSTextAlignmentCenter;
        [self.leftNumber sizeToFit];
        [self addSubview:self.leftNumber];
        
        
        self.rightNumber = [[UILabel alloc] initWithFrame:CGRectZero];
        self.rightNumber.font = FONT(20);
        self.rightNumber.textColor = UIColorFromHex(0xAFAFAF);
        self.rightNumber.textAlignment = NSTextAlignmentCenter;
        [self.rightNumber sizeToFit];
        [self addSubview:self.rightNumber];

    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.leftImg.width = self.leftImg.height = 20;
    self.leftImg.left = 20;
    self.leftImg.top = 15;
    
    CGSize size = [LabelHelper getSizeWith:self.leftLabel1.text font:15];
    self.leftLabel1.width = size.width;
    self.leftLabel1.height = size.height;
    self.leftLabel1.left = self.leftImg.right+5;
    self.leftLabel1.centerY = self.leftImg.centerY;
    
    CGSize size1 = [LabelHelper getSizeWith:self.leftNumber.text font:20];
    self.leftNumber.width = size1.width;
    self.leftNumber.height = size1.height;
    self.leftNumber.left = self.leftLabel1.right+5;
    self.leftNumber.centerY = self.leftImg.centerY;
    
    
    CGSize size2 = [LabelHelper getSizeWith:self.leftLabel2.text font:15];
    self.leftLabel2.width = size2.width;
    self.leftLabel2.height = size2.height;
    self.leftLabel2.left = self.leftNumber.right+5;
    self.leftLabel2.centerY = self.leftImg.centerY;
    
    CGSize size3 = [LabelHelper getSizeWith:self.rightLabel2.text font:15];
    self.rightLabel2.width = size3.width;
    self.rightLabel2.height = size3.height;
    self.rightLabel2.right = self.right-20;
    self.rightLabel2.centerY = self.leftImg.centerY;

    CGSize size4 = [LabelHelper getSizeWith:self.rightNumber.text font:20];
    self.rightNumber.width = size4.width;
    self.rightNumber.height = size4.height;
    self.rightNumber.right = self.rightLabel2.left-5;
    self.rightNumber.centerY = self.leftImg.centerY;
    
    
    CGSize size5 = [LabelHelper getSizeWith:self.rightLabel1.text font:15];
    self.rightLabel1.width = size5.width;
    self.rightLabel1.height = size5.height;
    self.rightLabel1.right = self.rightNumber.left-5;
    self.rightLabel1.centerY = self.leftImg.centerY;
    
    self.rightImg.width = self.rightImg.height = 20;
    self.rightImg.right = self.rightLabel1.left-5;
    self.rightImg.centerY = self.leftImg.centerY;

}


- (void)setLeftnumberText:(NSString *)string
{
    self.leftNumber.text = string;
}

- (void)setRightNumberText:(NSString *)string
{
    self.rightNumber.text = string;
}

- (void)drawRect:(CGRect)rect
{
    
}


@end
