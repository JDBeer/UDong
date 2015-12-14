//
//  ItemView.h
//  Udong
//
//  Created by wildyao on 15/11/25.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemView : UIView
@property (nonatomic, strong)UILabel *TitleLabel1;
@property (nonatomic, strong)UILabel *SubTitleLabel1;
@property (nonatomic, strong)UILabel *TitleLabel2;
@property (nonatomic, strong)UILabel *SubTitleLabel2;
@property (nonatomic, strong)UILabel *TitleLabel3;
@property (nonatomic, strong)UILabel *SubTitleLabel3;

- (id)initWithFrame:(CGRect)frame title1:(NSString *)title1 subTitle1:(NSString *)subTitle1 title2:(NSString *)title2 subTitle2:(NSString *)subTitle2 title3:(NSString *)title3 subTitle3:(NSString *)subTitle3;

@end
