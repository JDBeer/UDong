//
//  NewSportItemView.h
//  Udong
//
//  Created by wildyao on 16/3/9.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewSportItemView : UIView

@property (nonatomic, strong)UILabel *effectiveLabel;
@property (nonatomic, strong)UILabel *NulleffectiveLabel;
@property (nonatomic, strong)UILabel *leftStepLabel;
@property (nonatomic, strong)UILabel *rightStepLabel;
@property (nonatomic, strong)UILabel *leftNumber;
@property (nonatomic, strong)UILabel *rightNumber;

- (id)initWithFrame:(CGRect)frame;

- (void)setLeftNumberText:(NSString *)leftNumber;

- (void)setRightNumberText:(NSString *)rightNumber;


@end
