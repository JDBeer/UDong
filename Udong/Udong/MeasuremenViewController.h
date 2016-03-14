//
//  MeasuremenViewController.h
//  Udong
//
//  Created by wildyao on 15/12/2.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeasuremenViewController : UIViewController
@property (nonatomic, strong)UIImageView *stepImageView;
@property (nonatomic, strong)UILabel *label1;
@property (nonatomic, strong)UILabel *label2;
@property (nonatomic, strong)UILabel *sexLabel;
@property (nonatomic, strong)UILabel *manLabel;
@property (nonatomic, strong)UILabel *womenLabel;
@property (nonatomic, strong)UIButton *manBtn;
@property (nonatomic, strong)UIButton *womenBtn;
@property (nonatomic, strong)UIButton *NextBtn;
@property (nonatomic, strong)UIButton *backBtn;
@property (nonatomic, assign)int sign;


@end
