//
//  MeasurementWeightViewController.h
//  Udong
//
//  Created by wildyao on 15/12/3.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeasurementWeightViewController : UIViewController
@property (nonatomic, strong)UIImageView *stepImageView;
@property (nonatomic, strong)UILabel *label1;
@property (nonatomic, strong)UILabel *label2;
@property (nonatomic, strong)UILabel *shengaoLabel;
@property (nonatomic, strong)UILabel *numberLabel;
@property (nonatomic, strong)UILabel *cmabel;
@property (nonatomic, strong)UIImageView *pointImageView;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UILabel *hidenLabel;

@end
