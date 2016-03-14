//
//  EvaluationResultViewController.h
//  Udong
//
//  Created by wildyao on 15/12/9.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EffectResultView.h"

@interface EvaluationResultViewController : UIViewController

@property (nonatomic, strong)UIButton *backBtn;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *pointLabel;
@property (nonatomic, strong)UILabel *explainLabel;
@property (nonatomic, strong)UIImageView *imageView1;
@property (nonatomic, strong)UILabel *titleLabelTwo;
@property (nonatomic, strong)UIButton *beginBtn;
@property (nonatomic, strong)EffectResultView *effectResultView;
@property (nonatomic, strong)NSNumber *pointLabelNumber;
@property (nonatomic, strong)NSString *descriptionString;

@end
