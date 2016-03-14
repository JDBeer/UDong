//
//  EffectResultView.m
//  Udong
//
//  Created by wildyao on 16/1/15.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "EffectResultView.h"

@implementation EffectResultView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = kColorClearColor;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.text = @"如何达到有效运动";
        self.titleLabel.font = FONT(18);
        self.titleLabel.textColor = UIColorFromHex(0x999999);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.titleLabel sizeToFit];
        [self addSubview:self.titleLabel];
        
        self.runImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.runImageView.image = ImageNamed(@"icon_run");
        [self addSubview:self.runImageView];
        
        self.clockImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.clockImageView.image = ImageNamed(@"icon_shijian");
        [self addSubview:self.clockImageView];
        
        self.label1 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label1.text = @"运动步频≥110步/分钟";
        self.label1.font = FONT(14);
        self.label1.textColor = UIColorFromHex(0x999999);
        self.label1.textAlignment = NSTextAlignmentLeft;
        [self.label1 sizeToFit];
        [self addSubview:self.label1];
        
        self.label2 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label2.text = @"达到运动步频才能引起身体良性的应激反应";
        self.label2.font = FONT(14);
        self.label2.textColor = UIColorFromHex(0x999999);
        self.label2.textAlignment = NSTextAlignmentLeft;
        [self.label2 sizeToFit];
        [self addSubview:self.label2];
        
        self.label3 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label3.text = @"持续时间≥10分钟";
        self.label3.font = FONT(14);
        self.label3.textColor = UIColorFromHex(0x999999);
        self.label3.textAlignment = NSTextAlignmentLeft;
        [self.label3 sizeToFit];
        [self addSubview:self.label3];
        
        self.label4 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label4.text = @"达到运动时间猜对健康有促进作用";
        self.label4.font = FONT(14);
        self.label4.textColor = UIColorFromHex(0x999999);
        self.label4.textAlignment = NSTextAlignmentLeft;
        [self.label4 sizeToFit];
        [self addSubview:self.label4];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.width = 150;
    self.titleLabel.centerX = self.centerX;
    self.titleLabel.top = 20;
    
    self.label1.width = 200;
    self.label1.left = 70;
    self.label1.top = self.titleLabel.bottom+10;
    
    self.label2.width = 300;
    self.label2.left = self.label1.left;
    self.label2.top = self.label1.bottom+2;
    
    self.runImageView.width = self.runImageView.height = 30;
    self.runImageView.left = 30;
    self.runImageView.centerY = self.label1.centerY+5;
    
    self.label3.width = 200;
    self.label3.left = self.label1.left;
    self.label3.top = self.label2.bottom+20;
    
    self.label4.width = 300;
    self.label4.left = self.label1.left;
    self.label4.top = self.label3.bottom+2;
    
    self.clockImageView.width = self.clockImageView.height = 30;
    self.clockImageView.left = self.runImageView.left;
    self.clockImageView.centerY = self.label3.centerY+5;
    
}


- (void)drawRect:(CGRect)rect
{
    double lineWidth = 1;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, false);

    
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0 alpha:0.2].CGColor);
    CGContextMoveToPoint(context, 10, 0);
    CGContextAddLineToPoint(context, SCREEN_WIDTH-10, 0);
    CGContextStrokePath(context);

}
@end
