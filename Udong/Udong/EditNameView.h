//
//  EditNameView.h
//  Udong
//
//  Created by wildyao on 15/11/30.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditNameView : UIView
@property (nonatomic, strong)UIButton *bg;
@property (nonatomic, strong)UIScrollView *scrollview;
@property (nonatomic, strong)UIView *containerView;
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UITextField *field;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;

- (id)initWithFrame:(CGRect)frame andContainerView:(UIView *)containerView;
- (void)show;

@end
