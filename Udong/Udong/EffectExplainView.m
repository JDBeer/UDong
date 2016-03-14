//
//  EffectExplainView.m
//  Udong
//
//  Created by wildyao on 16/1/26.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "EffectExplainView.h"

@implementation EffectExplainView
{
    NSInteger _lineSpace;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (IS_IPONE_4_OR_LESS||IS_IPHONE_5) {
            _lineSpace = 4;
        }else{
            _lineSpace = 9;
        }
        
        
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.bgView.backgroundColor = UIColorFromHex(0xCDCDCD);
        [self addSubview:self.bgView];
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectZero];
        self.contentView.backgroundColor = kColorWhiteColor;
        [self.bgView addSubview:self.contentView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.text = @"有效运动的效果";
        self.titleLabel.textColor = UIColorFromHex(0x333333);
        self.titleLabel.font = FONT(18);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        
        self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"icon_guanbi1"] forState:UIControlStateNormal];
        [self.closeBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.closeBtn];
        
        self.label1 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label1.text = @"能量过剩是身体机能变差的主要原因，有效运动可消耗体内摄入和储存的过剩能量(糖和脂肪)。有效运动的效果分为2个阶段:";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.label1.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];

        [paragraphStyle setLineSpacing:_lineSpace];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.label1.text length])];
        self.label1.attributedText = attributedString;
        [self.label1 sizeToFit];
        self.label1.textColor = UIColorFromHex(0x9A9A9A);
        self.label1.font = FONT(15);
        self.label1.numberOfLines = 0;
        [self.label1 sizeToFit];
        [self.contentView addSubview:self.label1];
        
        self.orangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.orangeBtn.backgroundColor = UIColorFromHex(0xFB9215);
        [self.contentView addSubview:self.orangeBtn];
        
        self.titleLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel1.text = @"过剩能量消耗期";
        self.titleLabel1.font = self.titleLabel.font;
        self.titleLabel.textColor = UIColorFromHex(0x333333);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel1];
        
        self.lineView1 = [[UIView alloc] initWithFrame:CGRectZero];
        self.lineView1.backgroundColor = UIColorFromHex(0xCDCDCD);
        [self.contentView addSubview:self.lineView1];
        
        self.label2 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label2.text = @"只要产生有效运动,就开始消耗每日摄入的过剩能量(脂肪和葡萄糖)";
        NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:self.label2.text];
        NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:_lineSpace];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [self.label2.text length])];
        self.label2.attributedText = attributedString1;
        self.label2.textColor = UIColorFromHex(0x9A9A9A);
        self.label2.font = FONT(15);
        self.label2.numberOfLines = 0;
        [self.label2 sizeToFit];
        [self.contentView addSubview:self.label2];
        
        self.blueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.blueBtn.backgroundColor = UIColorFromHex(0x2EBEC8);
        [self.contentView addSubview:self.blueBtn];
        
        self.titleLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel2.text = @"身体机能提升期";
        self.titleLabel2.font = self.titleLabel.font;
        self.titleLabel2.textColor = UIColorFromHex(0x6D6D6D);
        self.titleLabel2.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel2];
        
        self.lineView2 = [[UIView alloc] initWithFrame:CGRectZero];
        self.lineView2.backgroundColor = UIColorFromHex(0xCDCDCD);
        [self.contentView addSubview:self.lineView2];
        
        self.label3 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label3.text = @"达到有效运动建议目标,过剩能量已经被消耗完毕。此时进入身体代谢负平衡阶段,引发身体良性应激反应,从而促进身体机能的根本改善";
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:self.label3.text];
        NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle2 setLineSpacing:_lineSpace];
        [attributedString2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle2 range:NSMakeRange(0, [self.label3.text length])];
        self.label3.attributedText = attributedString2;
        self.label3.textColor = UIColorFromHex(0x9A9A9A);
        self.label3.font = FONT(15);
        self.label3.numberOfLines = 0;
        [self.label3 sizeToFit];
        [self.contentView addSubview:self.label3];


        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.left = self.left+20;
    self.contentView.width = self.width-40;
    if (IS_IPONE_4_OR_LESS||IS_IPHONE_5) {
        self.contentView.height = self.height/1.2;
    }else{
        self.contentView.height = self.height/1.5;
    }
    self.contentView.centerY = self.centerY;
    self.contentView.layer.cornerRadius = 5;
    self.contentView.layer.masksToBounds = YES;
    
   
    self.titleLabel.centerX = self.contentView.centerX-75;
    self.titleLabel.top = self.top+40;
    self.titleLabel.width = 130;
    self.titleLabel.height = 20;
    
    self.closeBtn.height = self.closeBtn.width = 15;
    self.closeBtn.right = self.contentView.right-35;
    self.closeBtn.top = self.titleLabel.top-20;
    
    self.label1.left = self.contentView.left+15;
    self.label1.top = self.titleLabel.bottom+15;
    self.label1.width = self.contentView.width-30;
    self.label1.centerX = self.titleLabel.centerX;
    self.label1.height = [self.label1.text sizeWithFont:self.label1.font constrainedToSize:CGSizeMake(self.label1.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height+9*2;
    
    self.orangeBtn.left = self.label1.left;
    self.orangeBtn.top = self.label1.bottom+25;
    self.orangeBtn.width = self.orangeBtn.height = 12;
    
    self.titleLabel1.left = self.orangeBtn.right+10;
    self.titleLabel1.centerY =self.orangeBtn.top;
    self.titleLabel1.width = self.titleLabel.width;
    self.titleLabel1.height = self.titleLabel.height-8;
    
    self.lineView1.left = self.label1.left;
    self.lineView1.top = self.titleLabel1.bottom+10;
    self.lineView1.width = self.label1.width;
    self.lineView1.height = 1;
    
    self.label2.left = self.label1.left;
    self.label2.top = self.lineView1.bottom+5;
    self.label2.width = self.label1.width;
    self.label2.centerX = self.label1.centerX;
    self.label2.height =  [self.label2.text sizeWithFont:self.label2.font constrainedToSize:CGSizeMake(self.label2.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height+9;
    
    self.blueBtn.left = self.orangeBtn.left;
    self.blueBtn.bottom = self.label2.bottom+25;
    self.blueBtn.width = self.blueBtn.height = 12;
    
    self.titleLabel2.left = self.blueBtn.right+10;
    self.titleLabel2.centerY =self.blueBtn.top;
    self.titleLabel2.width = self.titleLabel.width;
    self.titleLabel2.height = self.titleLabel.height-8;
    
    self.lineView2.left = self.label1.left;
    self.lineView2.top = self.titleLabel2.bottom+10;
    self.lineView2.width = self.label2.width;
    self.lineView2.height = 1;
    
    self.label3.left = self.label1.left;
    self.label3.top = self.lineView2.bottom+5;
    self.label3.width = self.label1.width;
    self.label3.centerX = self.label1.centerX;
    self.label3.height =  [self.label3.text sizeWithFont:self.label3.font constrainedToSize:CGSizeMake(self.label3.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height+9*3;
    
    
}

- (void)show
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    //    self.closeBtn.transform = CGAffineTransformMakeScale(1.3, 1.3);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
        self.alpha = 1.0;
        self.contentView.alpha = 1.0;
        self.closeBtn.alpha = 1.0;
    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
        //        self.closeBtn.transform = CGAffineTransformMakeScale(0.1, 0.1);
        
        self.alpha = 0.0;
        self.contentView.alpha = 0.0;
        self.closeBtn.alpha = 0.0;
        
        [self.closeBtn removeFromSuperview], self.closeBtn = nil;
        
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
        
        [self.contentView removeFromSuperview], self.contentView = nil;
        [self removeFromSuperview];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:DidPressCloseBtnSuccessNotification object:nil];

    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
