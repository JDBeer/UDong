//
//  FinishRegisterViewController.h
//  Udong
//
//  Created by wildyao on 15/11/19.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinishRegisterViewController : UIViewController
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, strong) UITextField *VertifyCodeTf;
@property (nonatomic, strong) UITextField *passwordTf;
@property (nonatomic, strong) UIButton *finishBtn;
@property (nonatomic, strong) UILabel *ProvisionLabel;
@property (nonatomic, strong) UIButton *ProvisionBtn;
@property (nonatomic, strong) UILabel *plabel;
@property (nonatomic, strong) UIButton *ThirdBtn;
@property (nonatomic, strong) UIImageView *cleanImg;
@property (nonatomic, strong) UIButton *passwordTfCleanBtn;
@property (nonatomic, strong) UIImageView *logRegisterImage;
@property (nonatomic, strong) UIButton *countDownBtn;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) NSString *phoneNumberString;
@property (nonatomic, strong) NSMutableDictionary *deviceDictionary;


@end
