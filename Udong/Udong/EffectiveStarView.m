//
//  EffectiveStarView.m
//  PalmMedicine
//
//  Created by wildyao on 15/5/10.
//  Copyright (c) 2015年 Wild Yaoyao. All rights reserved.
//

#import "EffectiveStarView.h"

@implementation EffectiveStarView

- (id)initWithFrame:(CGRect)frame andContainerView:(UIView *)containerView
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        _bg = [UIButton buttonWithType:UIButtonTypeCustom];
        _bg.frame = [[UIScreen mainScreen] bounds];
        _bg.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        _bg.alpha = 0.0;
        [_bg addTarget:self action:@selector(onBtnBg:) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:_bg];
        self.containerView = containerView;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.scrollView];
        
        self.titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLbl.text = @"神奇的星运动";
        self.titleLbl.font = FONT(19);
        self.titleLbl.textColor = KColorBlueColor;
        [self.titleLbl sizeToFit];
        [self.scrollView addSubview:self.titleLbl];
        
        self.green1 = [[UIView alloc] initWithFrame:CGRectZero];
        self.green1.backgroundColor = KColorBlueColor;
        [self.scrollView addSubview:self.green1];
        
        self.green2 = [[UIView alloc] initWithFrame:CGRectZero];
        self.green2.backgroundColor = KColorBlueColor;
        [self.scrollView addSubview:self.green2];
        
        self.star1 = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.star1.image = ImageNamed(@"stars_target");
        [self.scrollView addSubview:self.star1];
        
        self.star2 = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.star2.image = ImageNamed(@"stars_effective");
        [self.scrollView addSubview:self.star2];
        
        self.starLbl1 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.starLbl1.text = @"目标星";
        self.starLbl1.textColor = UIColorFromHex(0x898b8a);
        self.starLbl1.font = FONT(14);
        [self.starLbl1 sizeToFit];
        [self.scrollView addSubview:self.starLbl1];
        
        self.starLbl2 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.starLbl2.text = @"完成星";
        self.starLbl2.textColor = UIColorFromHex(0x898b8a);
        self.starLbl2.font = FONT(14);
        [self.starLbl2 sizeToFit];
        [self.scrollView addSubview:self.starLbl2];
        
        self.subtitleLbl1 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.subtitleLbl1.text = @"什么是星运动？";
        self.subtitleLbl1.font = FONT(17);
        [self.subtitleLbl1 sizeToFit];
        [self.scrollView addSubview:self.subtitleLbl1];
        
        self.subtitleLbl2 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.subtitleLbl2.text = @"怎样才能完成星？";
        self.subtitleLbl2.font = self.subtitleLbl1.font;
        [self.subtitleLbl2 sizeToFit];
        [self.scrollView addSubview:self.subtitleLbl2];
        
        self.contentLbl1 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.contentLbl1.text = @"我们通过10万多人的运动跟踪与分析，发现保持健康的关键是运动的“持续时间”和“运动强度”";
        self.contentLbl1.textColor = UIColorFromHex(0x898b8a);
        self.contentLbl1.font = FONT(14);
        [self.contentLbl1 sizeToFit];
        self.contentLbl1.numberOfLines = 0;
        [self.scrollView addSubview:self.contentLbl1];
        
        self.contentLbl2 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.contentLbl2.text = @"我们把对健康有帮助的持续10分钟以上并且保持一定强度的运动提炼出来，叫做“星运动”。";
        self.contentLbl2.textColor = UIColorFromHex(0x898b8a);
        self.contentLbl2.font = self.contentLbl1.font;
        [self.contentLbl2 sizeToFit];
        self.contentLbl2.numberOfLines = 0;
        [self.scrollView addSubview:self.contentLbl2];
        
        self.contentLbl3 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.contentLbl3.text = @"保持连续快走10分钟，保持您的运动在有效运动范围内才能累计足够多的完成星！";
        self.contentLbl3.textColor = UIColorFromHex(0x898b8a);
        self.contentLbl3.font = self.contentLbl1.font;
        [self.contentLbl3 sizeToFit];
        self.contentLbl3.numberOfLines = 0;
        [self.scrollView addSubview:self.contentLbl3];
        
        self.graphIv = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.graphIv.image = ImageNamed(@"graphEffect");
        [self.scrollView addSubview:self.graphIv];
        
        [self.containerView addSubview:self];
        
        self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"delete_buttom_nav"] forState:UIControlStateNormal];
        [self.closeBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:self.closeBtn];
        
        self.alpha = 0.0;
        self.closeBtn.alpha = 0.0;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLbl.top = 30;
    self.titleLbl.centerX = self.width/2;

    self.green1.height = 23;
    self.green1.width = 7;
    self.green1.left = 10;
    self.green1.top = self.titleLbl.bottom+15;
    
    self.subtitleLbl1.left = self.green1.right+6;
    self.subtitleLbl1.centerY = self.green1.centerY;
    
    self.contentLbl1.top = self.subtitleLbl1.bottom+5;
    self.contentLbl1.left = self.subtitleLbl1.left;
    self.contentLbl1.width = self.width-_contentLbl1.left-10;
    self.contentLbl1.height = [self.contentLbl1.text sizeWithFont:self.contentLbl1.font constrainedToSize:CGSizeMake(self.contentLbl1.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height;
    
    self.star1.height = self.star1.width = 40;
    self.star1.top = self.contentLbl1.bottom+5;
    self.star1.right = self.width/2-20;
    
    self.star2.height = self.star2.width = 40;
    self.star2.top = self.star1.top;
    self.star2.left = self.width/2+20;
    
    self.starLbl1.top = self.star1.bottom+5;
    self.starLbl1.centerX = self.star1.centerX;
    
    self.starLbl2.top = self.starLbl1.top;
    self.starLbl2.centerX = self.star2.centerX;

    self.contentLbl2.top = self.starLbl1.bottom+5;
    self.contentLbl2.left = self.contentLbl1.left;
    self.contentLbl2.width = self.contentLbl1.width;
    self.contentLbl2.height = [self.contentLbl2.text sizeWithFont:self.contentLbl2.font constrainedToSize:CGSizeMake(self.contentLbl2.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height;
    
    self.green2.height = self.green1.height;
    self.green2.width = self.green1.width;
    self.green2.left = self.green1.left;
    self.green2.top = self.contentLbl2.bottom+15;
    
    self.subtitleLbl2.left = self.subtitleLbl1.left;
    self.subtitleLbl2.centerY = self.green2.centerY;
    
    self.contentLbl3.top = self.subtitleLbl2.bottom+5;
    self.contentLbl3.left = self.contentLbl1.left;
    self.contentLbl3.width = self.contentLbl1.width;
    self.contentLbl3.height = [self.contentLbl3.text sizeWithFont:self.contentLbl3.font constrainedToSize:CGSizeMake(self.contentLbl3.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height;
    
    self.graphIv.width = self.contentLbl3.width;
    self.graphIv.height = 100;
    self.graphIv.left = self.contentLbl3.left;
    self.graphIv.top = self.contentLbl3.bottom+5;
    
    self.scrollView.left = 0;
    self.scrollView.top = 0;
    self.scrollView.width = self.bounds.size.width;
    self.scrollView.height = (self.graphIv.bottom+30 > self.containerView.height-40) ? self.containerView.height-40 : self.graphIv.bottom+30;
    
    if (self.graphIv.bottom+30 > self.containerView.height-40) {
        CGSize size = self.scrollView.contentSize;
        size.height = self.graphIv.bottom+30;
        self.scrollView.contentSize = size;
    } else {
        
    }
    
    CGRect frame = self.frame;
    frame.size.width = self.containerView.width-20*2;
    frame.size.height = self.scrollView.height;
    frame.origin.y = self.containerView.bounds.size.height/2-frame.size.height/2;
    frame.origin.x = 20;
    self.frame = frame;
    
    self.closeBtn.height = self.closeBtn.width = 27;
    self.closeBtn.centerX = self.right;
    self.closeBtn.centerY = self.top;
}

- (void)show
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
//    self.closeBtn.transform = CGAffineTransformMakeScale(1.3, 1.3);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
        self.alpha = 1.0;
        self.bg.alpha = 1.0;
        self.closeBtn.alpha = 1.0;
    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
//        self.closeBtn.transform = CGAffineTransformMakeScale(0.1, 0.1);
        
        self.alpha = 0.0;
        self.bg.alpha = 0.0;
        self.closeBtn.alpha = 0.0;
        
        [self.closeBtn removeFromSuperview], self.closeBtn = nil;
        
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
        
        [self.bg removeFromSuperview], self.bg = nil;
        [self removeFromSuperview];
    }];
}

- (void)onBtnBg:(id)sender
{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
//        self.closeBtn.transform = CGAffineTransformMakeScale(0.1, 0.1);
        
        self.alpha = 0.0;
        self.bg.alpha = 0.0;
        self.closeBtn.alpha = 0.0;
        
        [self.closeBtn removeFromSuperview], self.closeBtn = nil;
        
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
        
        [self.bg removeFromSuperview], self.bg = nil;
        [self removeFromSuperview];
    }];
}


@end
