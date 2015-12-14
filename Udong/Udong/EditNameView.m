//
//  EditNameView.m
//  Udong
//
//  Created by wildyao on 15/11/30.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "EditNameView.h"

@implementation EditNameView

- (id)initWithFrame:(CGRect)frame andContainerView:(UIView *)containerView
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorWhiteColor;
        
        containerView.frame = [[UIScreen mainScreen] bounds];
        containerView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        self.containerView = containerView;
        
        self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectZero];
        self.scrollview.backgroundColor = UIColorFromHex(0xf8f8f8);
        [self.containerView addSubview:self.scrollview];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label.text = @"编辑昵称";
        self.label.textColor = kColorContentColor;
        self.label.font = FONT(17);
        [self.label sizeToFit];
        [self.scrollview addSubview:self.label];
        
        self.field = [[UITextField alloc] initWithFrame:CGRectZero];
        self.field.placeholder = @"2~8个字符";
        [self.field setValue:UIColorFromHexWithAlpha(0xe6e6e6, 1) forKeyPath:@"_placeholderLabel.textColor"];
        self.field.backgroundColor =  UIColorFromHex(0xffffff);
        [self.scrollview addSubview:self.field];
        
        self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.leftBtn addTarget:self action:@selector(onBtnGiveup:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollview addSubview:self.leftBtn];
        
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.rightBtn setTitle:@"确认" forState:UIControlStateNormal];
        [self.rightBtn addTarget:self action:@selector(onBtnConfirm:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn setTitleColor:UIColorFromHex(0x2fbec8) forState:UIControlStateNormal];
        [self.scrollview addSubview:self.rightBtn];
        
        
        
    }
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollview.centerX = self.width/2;
    self.scrollview.centerY = self.height/2;
    self.scrollview.width = self.width-20*2;
    self.scrollview.height = 200;
    
    self.label.top = self.scrollview.top+30;;
    self.label.centerX = self.width/2;
    
    self.field.top = self.label.bottom+22;
    self.field.left = self.left+10;
    self.field.right = self.right-10;
    
    self.leftBtn.top = self.field.bottom+15;
    self.leftBtn.left = self.field.left;
    self.leftBtn.width = 60;
    self.leftBtn.height = 30;
    
    self.rightBtn.top = self.field.bottom+15;
    self.rightBtn.right = self.field.right;
    self.rightBtn.width = 60;
    self.rightBtn.height = 30;
    
    
}

- (void)show
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    //    self.closeBtn.transform = CGAffineTransformMakeScale(1.3, 1.3);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
        self.alpha = 1.0;
        self.containerView.alpha = 1.0;
        
    }];
}



- (void)onBtnGiveup:(id)sender
{
    
}

- (void)onBtnConfirm:(id)sender
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
