//
//  StepHzView.h
//  Udong
//
//  Created by wildyao on 16/3/9.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepHzView : UIView

@property (nonatomic, strong)UIImageView *leftImg;
@property (nonatomic, strong)UIImageView *rightImg;
@property (nonatomic, strong)UILabel *leftLabel1;
@property (nonatomic, strong)UILabel *rightLabel1;
@property (nonatomic, strong)UILabel *leftNumber;
@property (nonatomic, strong)UILabel *rightNumber;
@property (nonatomic, strong)UILabel *leftLabel2;
@property (nonatomic, strong)UILabel *rightLabel2;

- (id)initWithFrame:(CGRect)frame;

- (void)setLeftnumberText:(NSString *)string;

- (void)setRightNumberText:(NSString *)string;

@end
