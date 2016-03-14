//
//  EffectExplainView.h
//  Udong
//
//  Created by wildyao on 16/1/26.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#define DidPressCloseBtnSuccessNotification @"DidPressCloseBtnSuccessNotification"

@interface EffectExplainView : UIView
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)UIButton *closeBtn;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *label1;
@property (nonatomic, strong)UIButton *orangeBtn;
@property (nonatomic, strong)UILabel *titleLabel1;
@property (nonatomic, strong)UIView *lineView1;
@property (nonatomic, strong)UILabel *label2;
@property (nonatomic, strong)UIButton *blueBtn;
@property (nonatomic, strong)UILabel *titleLabel2;
@property (nonatomic, strong)UIView *lineView2;
@property (nonatomic, strong)UILabel *label3;

- (id)initWithFrame:(CGRect)frame;
- (void)show;

@end
