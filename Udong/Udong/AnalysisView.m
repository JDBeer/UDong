//
//  AnalysisView.m
//  Udong
//
//  Created by wildyao on 16/1/12.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "AnalysisView.h"

@implementation AnalysisView

- (id)initWithFrame:(CGRect)frame sportLabel:(NSString *)sportLabel numberLabel:(NSString *)numberLabel
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel1.text = @"运动情况";
        self.titleLabel1.textColor = UIColorFromHex(0xACACAC);
        if (IS_IPONE_4_OR_LESS) {
            self.titleLabel1.font = FONT(14);
        }else if (IS_IPHONE_5){
            self.titleLabel1.font = FONT(16);
        }else{
            self.titleLabel1.font = FONT(18);
        }
        
        self.titleLabel1.textAlignment = NSTextAlignmentCenter;
        [self.titleLabel1 sizeToFit];
        [self addSubview:self.titleLabel1];
        
        self.titleLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel2.text = @"身体机能累计";
        self.titleLabel2.textColor = UIColorFromHex(0xACACAC);
        if (IS_IPONE_4_OR_LESS) {
            self.titleLabel2.font = FONT(14);
        }else if (IS_IPHONE_5){
            self.titleLabel2.font = FONT(16);
        }else{
            self.titleLabel2.font = FONT(18);
        }
        self.titleLabel2.textAlignment = NSTextAlignmentCenter;
        [self.titleLabel2 sizeToFit];
        [self addSubview:self.titleLabel2];
        
        self.sportLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.sportLabel.text = sportLabel;
        self.sportLabel.textColor = UIColorFromHex(0xE0E1E2);
        if (IS_IPONE_4_OR_LESS) {
            self.sportLabel.font = FONT(15);
        }else if (IS_IPHONE_5){
           self.sportLabel.font = FONT(20);
        }else{
            self.sportLabel.font = FONT(25);
        }
        self.sportLabel.textAlignment = NSTextAlignmentCenter;
        [self.sportLabel sizeToFit];
        [self addSubview:self.sportLabel];
        
        self.numbelLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.numbelLabel.text = numberLabel;
        self.numbelLabel.textColor = UIColorFromHex(0xE0E1E2);
        if (IS_IPONE_4_OR_LESS) {
            self.numbelLabel.font = FONT(15);
        }else if (IS_IPHONE_5){
            self.numbelLabel.font = FONT(20);
        }else{
            self.numbelLabel.font = FONT(25);
        }
        self.numbelLabel.textAlignment = NSTextAlignmentRight;
        [self.numbelLabel sizeToFit];
        [self addSubview:self.numbelLabel];
        
        self.precentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.precentLabel.text = @"%";
        self.precentLabel.textColor = UIColorFromHex(0xE0E1E2);
        if (IS_IPONE_4_OR_LESS) {
            self.precentLabel.font = FONT(15);
        }else if (IS_IPHONE_5){
            self.precentLabel.font = FONT(20);
        }else{
            self.precentLabel.font = FONT(25);
        }
        self.precentLabel.textAlignment = NSTextAlignmentLeft;
        [self.precentLabel sizeToFit];

        [self addSubview:self.precentLabel];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel1.width =100;
    self.titleLabel1.left = self.left+30;
    self.titleLabel1.top = self.top+50-64;
    
    self.titleLabel2.width = 150;
    self.titleLabel2.right = self.right-30;
    self.titleLabel2.top = self.titleLabel1.top;
    
    self.sportLabel.width = self.titleLabel1.width;
    self.sportLabel.centerX = self.titleLabel1.centerX;
    self.sportLabel.top = self.titleLabel1.bottom+10;
    
    self.numbelLabel.width = 100;
    self.numbelLabel.left = self.titleLabel2.left;
    self.numbelLabel.top = self.sportLabel.top;
    
    self.precentLabel.width = 30;
    self.precentLabel.left = self.numbelLabel.right+5;
    self.precentLabel.bottom = self.numbelLabel.bottom;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
