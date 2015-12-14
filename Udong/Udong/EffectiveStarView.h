//
//  EffectiveStarView.h
//  PalmMedicine
//
//  Created by wildyao on 15/5/10.
//  Copyright (c) 2015年 Wild Yaoyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EffectiveStarView : UIView

@property (nonatomic, strong) UIButton *bg;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UILabel *subtitleLbl1;
@property (nonatomic, strong) UILabel *subtitleLbl2;

@property (nonatomic, strong) UILabel *contentLbl1;
@property (nonatomic, strong) UILabel *contentLbl2;
@property (nonatomic, strong) UILabel *contentLbl3;

@property (nonatomic, strong) UIView *green1;
@property (nonatomic, strong) UIView *green2;

@property (nonatomic, strong) UIImageView *star1;
@property (nonatomic, strong) UIImageView *star2;

@property (nonatomic, strong) UILabel *starLbl1;
@property (nonatomic, strong) UILabel *starLbl2;

@property (nonatomic, strong) UIImageView *graphIv;

- (id)initWithFrame:(CGRect)frame andContainerView:(UIView *)containerView;
- (void)show;

@end
