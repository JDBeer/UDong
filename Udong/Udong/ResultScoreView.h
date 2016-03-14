//
//  ResultScoreView.h
//  PalmMedicine
//
//  Created by wildyao on 15/3/3.
//  Copyright (c) 2015年 Wild Yaoyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultScoreView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *pointView;
@property (nonatomic, strong) UILabel *scoreLbl;
@property (nonatomic, strong) UILabel *subLbl;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIPageControl *pageController;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *countSteplabel;
@property (nonatomic, strong) UILabel *wordlabel;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int type;

@property (nonatomic, assign) float angle;

@property (nonatomic, assign) float gapTimePlus;

- (void)setStrokeColor:(UIColor *)color scorelbColor:(UIColor *)scorelbColor sublabColor:(UIColor *)sublabColor backgroundColor:(UIColor *)bgColor lineWidth:(CGFloat)lineWidth;

- (id)initWithFrame:(CGRect)frame type:(int)type sublabel:(NSString *)sublabel totalStepCount:(NSString *)totalStepCount;

- (void)setLblText:(NSString *)text angle:(CGFloat)angle;

- (void)setcountStepNumber:(NSString *)stepCount;

@end
