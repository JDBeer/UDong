//
//  ItemView.m
//  Udong
//
//  Created by wildyao on 15/11/25.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "ItemView.h"

@implementation ItemView
    
- (id)initWithFrame:(CGRect)frame title1:(NSString *)title1 subTitle1:(NSString *)subTitle1 title2:(NSString *)title2 subTitle2:(NSString *)subTitle2 title3:(NSString *)title3 subTitle3:(NSString *)subTitle3
{
    self = [super initWithFrame:frame];
    if (self) {
        self.TitleLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.TitleLabel1 setText:title1];
        [self.TitleLabel1 setTextAlignment:NSTextAlignmentLeft];
        [self.TitleLabel1 setFont:FONT(16)];
        [self.TitleLabel1 setTextColor:kColorContentColor];
        [self addSubview:self.TitleLabel1];
        
        self.SubTitleLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.SubTitleLabel1 setText:subTitle1];
        [self.SubTitleLabel1 setTextAlignment:NSTextAlignmentLeft];
        [self.SubTitleLabel1 setFont:FONT(17)];
        [self.SubTitleLabel1 setTextColor:kColorWhiteColor];
        [self addSubview:self.SubTitleLabel1];
        
        [self.TitleLabel1 sizeToFit];
        [self.SubTitleLabel1 sizeToFit];
        
        
        self.TitleLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.TitleLabel2 setText:title2];
        [self.TitleLabel2 setTextAlignment:NSTextAlignmentCenter];
        [self.TitleLabel2 setFont:FONT(16)];
        [self.TitleLabel2 setTextColor:kColorContentColor];
        [self addSubview:self.TitleLabel2];
        
        self.SubTitleLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.SubTitleLabel2 setText:subTitle2];
        [self.SubTitleLabel2 setTextAlignment:NSTextAlignmentCenter];
        [self.SubTitleLabel2 setFont:FONT(17)];
        [self.SubTitleLabel2 setTextColor:kColorWhiteColor];
        [self addSubview:self.SubTitleLabel2];
        
        [self.TitleLabel2 sizeToFit];
        [self.SubTitleLabel2 sizeToFit];
        
        self.TitleLabel3 = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.TitleLabel3 setText:title3];
        [self.TitleLabel3 setTextAlignment:NSTextAlignmentRight];
        [self.TitleLabel3 setFont:FONT(16)];
        [self.TitleLabel3 setTextColor:kColorContentColor];
        [self addSubview:self.TitleLabel3];
        
        self.SubTitleLabel3 = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.SubTitleLabel3 setText:subTitle3];
        [self.SubTitleLabel3 setTextAlignment:NSTextAlignmentCenter];
        [self.SubTitleLabel3 setFont:FONT(17)];
        [self.SubTitleLabel3 setTextColor:kColorWhiteColor];
        [self addSubview:self.SubTitleLabel3];
        
        [self.TitleLabel3 sizeToFit];
        [self.SubTitleLabel3 sizeToFit];
        
    }
    return self;
}

- (void)layoutSubviews
{
    if (IS_IPHONE_6P||IS_IPHONE_6) {
        self.TitleLabel2.width = 80;
        self.TitleLabel2.centerX = self.centerX;
        self.TitleLabel2.top =5;
        
        self.SubTitleLabel2.width = self.TitleLabel2.width;
        self.SubTitleLabel2.centerX = self.TitleLabel2.centerX;
        self.SubTitleLabel2.top = self.TitleLabel2.bottom + 10;
        
        self.TitleLabel1.width = self.TitleLabel2.width;
        self.TitleLabel1.left = 40;
        self.TitleLabel1.top = self.TitleLabel2.top;
        
        self.SubTitleLabel1.width = self.SubTitleLabel2.width;
        self.SubTitleLabel1.left = 45;
        self.SubTitleLabel1.top = self.SubTitleLabel2.top;
        
        self.TitleLabel3.width = self.TitleLabel2.width;
        self.TitleLabel3.right = self.right-40;
        self.TitleLabel3.top = self.TitleLabel2.top;
        
        self.SubTitleLabel3.width = self.SubTitleLabel2.width;
        self.SubTitleLabel3.right = self.TitleLabel3.right;
        self.SubTitleLabel3.top = self.SubTitleLabel2.top;
    }else{
        
        self.TitleLabel2.width = 80;
        self.TitleLabel2.centerX = self.centerX;
        self.TitleLabel2.top =5;
        
        self.SubTitleLabel2.width = self.TitleLabel2.width;
        self.SubTitleLabel2.centerX = self.TitleLabel2.centerX;
        self.SubTitleLabel2.top = self.TitleLabel2.bottom + 10;
        
        self.TitleLabel1.width = self.TitleLabel2.width;
        self.TitleLabel1.left = 40;
        self.TitleLabel1.top = self.TitleLabel2.top;
        
        self.SubTitleLabel1.width = self.SubTitleLabel2.width;
        self.SubTitleLabel1.left = 45;
        self.SubTitleLabel1.top = self.SubTitleLabel2.top;
        
        self.TitleLabel3.width = self.TitleLabel2.width;
        self.TitleLabel3.right = self.right-20;
        self.TitleLabel3.top = self.TitleLabel2.top;
        
        self.SubTitleLabel3.width = self.SubTitleLabel2.width;
        self.SubTitleLabel3.right = self.TitleLabel3.right;
        self.SubTitleLabel3.top = self.SubTitleLabel2.top;

    }
    
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
