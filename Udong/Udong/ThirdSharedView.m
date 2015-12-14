//
//  ThirdSharedView.m
//  Udong
//
//  Created by wildyao on 15/11/30.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "ThirdSharedView.h"

@implementation ThirdSharedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.cancalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancalBtn.frame = CGRectMake(0, 0, self.width, 100);
        self.cancalBtn.backgroundColor = kColorBlackColor;
        [self.cancalBtn setTitle:@"取消" forState:UIControlStateNormal];
        self.cancalBtn.layer.cornerRadius = 5;
        self.cancalBtn.layer.masksToBounds = YES;
        [self addSubview:self.cancalBtn];
//        
//        self.shareView = [[UIView alloc] initWithFrame:CGRectZero];
//        self.shareView.backgroundColor = kColorWhiteColor;
//        self.shareView.layer.cornerRadius = 5;
//        self.shareView.layer.masksToBounds = YES;
//        
//        
//        self.weichatImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        self.weichatImageView.image = ImageNamed(@"share_icon_wechat");
//        [self.shareView addSubview:self.weichatImageView];
//        
//        self.weichatLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        self.weichatLabel.text = @"微信";
//        self.weichatLabel.textColor = kColorContentColor;
//        self.weichatLabel.font = FONT(16);
//        [self.weichatLabel sizeToFit];
//        [self.shareView addSubview:self.weichatLabel];
//        
//        
//        self.firendCycleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        self.firendCycleImageView.image = ImageNamed(@"share_icon_moment");
//        [self.shareView addSubview:self.firendCycleImageView];
//        
//        self.firendCycleLabel= [[UILabel alloc] initWithFrame:CGRectZero];
//        self.firendCycleLabel.text = @"朋友圈";
//        self.firendCycleLabel.textColor = kColorContentColor;
//        self.firendCycleLabel.font = FONT(16);
//        [self.firendCycleLabel sizeToFit];
//        [self.shareView addSubview:self.firendCycleLabel];
//
//        
//        self.QQImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        self.QQImageView.image = ImageNamed(@"share_icon_qq");
//        [self.shareView addSubview:self.QQImageView];
//        
//        self.QQlabel= [[UILabel alloc] initWithFrame:CGRectZero];
//        self.QQlabel.text = @"QQ";
//        self.QQlabel.textColor = kColorContentColor;
//        self.QQlabel.font = FONT(16);
//        [self.QQlabel sizeToFit];
//        [self.shareView addSubview:self.QQlabel];
//        
//        
//        self.weiboImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        self.weiboImageView.image = ImageNamed(@"share_icon_weibo");
//        [self.shareView addSubview:self.weiboImageView];
//        
//        self.weiboLabel= [[UILabel alloc] initWithFrame:CGRectZero];
//        self.weiboLabel.text = @"微博";
//        self.weiboLabel.textColor = kColorContentColor;
//        self.weiboLabel.font = FONT(16);
//        [self.weiboLabel sizeToFit];
//        [self.shareView addSubview:self.weiboLabel];
//        
//        
//        [self addSubview:self.shareView];
//        
        self.alpha = 0;
        self.cancalBtn.alpha = 0;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.cancalBtn.centerX = self.centerX;
    self.cancalBtn.bottom = self.bottom-10;
    self.cancalBtn.width = self.width-2*10;
    self.cancalBtn.height = 40;
   
//    
//    self.shareView.centerX = self.centerX;
//    self.shareView.bottom = self.cancalBtn.top-5;
//    self.shareView.width = self.cancalBtn.width;
//    self.shareView.height = 140;
//    
//    self.weichatImageView.left =self.shareView.left+30;
//    self.weichatImageView.top = self.shareView.top+30;
//    self.weichatImageView.width = self.weichatImageView.height = 30;
//    
//    self.weichatLabel.left = self.weichatImageView.left;
//    self.weichatLabel.bottom = self.weichatImageView.bottom-10;
//    
//    self.firendCycleImageView.left = self.weichatImageView.right+60;
//    self.firendCycleImageView.top = self.weichatImageView.top;
//    self.firendCycleImageView.width = self.firendCycleImageView.height = 30;
//    
//    self.firendCycleLabel.left = self.weichatLabel.right+60;
//    self.firendCycleLabel.bottom = self.weichatLabel.bottom;
//    
//    self.QQImageView.left = self.firendCycleImageView.right+60;
//    self.QQImageView.top = self.weichatImageView.top;
//    self.QQImageView.width = self.QQImageView.height = 30;
//    
//    self.QQlabel.left = self.firendCycleLabel.right+60;
//    self.QQlabel.bottom = self.weichatLabel.bottom;
//    
//    self.weiboImageView.left = self.QQImageView.right+60;
//    self.weiboImageView.top = self.weichatImageView.top;
//    self.weiboImageView.width = self.weichatImageView.height = 30;
//    
//    self.weiboLabel.left = self.QQlabel.right+60;
//    self.weiboLabel.bottom = self.weichatLabel.bottom;
    

    
}

- (void)show
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    //    self.closeBtn.transform = CGAffineTransformMakeScale(1.3, 1.3);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
        self.alpha = 1.0;
        self.cancalBtn.alpha = 1.0;
//        self.bg.alpha = 1.0;
//        self.closeBtn.alpha = 1.0;
    }];
     NSLog(@"%@",NSStringFromCGRect(self.cancalBtn.frame));

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
