//
//  ThirdSharedView.h
//  Udong
//
//  Created by wildyao on 15/11/30.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdSharedView : UIView
@property (nonatomic, strong) UIButton *cancalBtn;
@property (nonatomic, strong) UIView *shareView;
@property (nonatomic, strong) UIImageView *weichatImageView;
@property (nonatomic, strong) UILabel *weichatLabel;
@property (nonatomic, strong) UIImageView *firendCycleImageView;
@property (nonatomic, strong) UILabel *firendCycleLabel;
@property (nonatomic, strong) UIImageView *QQImageView;
@property (nonatomic, strong) UILabel *QQlabel;
@property (nonatomic, strong) UIImageView *weiboImageView;
@property (nonatomic, strong) UILabel *weiboLabel;
- (id)initWithFrame:(CGRect)frame;

- (void)show;

@end
