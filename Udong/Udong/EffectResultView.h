//
//  EffectResultView.h
//  Udong
//
//  Created by wildyao on 16/1/15.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EffectResultView : UIView

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIImageView *runImageView;
@property (nonatomic, strong)UIImageView *clockImageView;
@property (nonatomic, strong)UILabel *label1;
@property (nonatomic, strong)UILabel *label2;
@property (nonatomic, strong)UILabel *label3;
@property (nonatomic, strong)UILabel *label4;

- (id)initWithFrame:(CGRect)frame;

@end
