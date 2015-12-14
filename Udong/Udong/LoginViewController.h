//
//  LoginViewController.h
//  Udong
//
//  Created by wildyao on 15/11/15.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UITextField *accountField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIImageView *LoginImage;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *forgetBtn;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIImageView *bgImg;
@property (nonatomic, strong) UIImageView *cleanImg;
@property (nonatomic, strong) UIButton *accountTfCleanBtn;
@property (nonatomic, strong) UIImageView *eyeImg;
@property (nonatomic, strong) UIButton *passwordTfCleanBtn;
@property (nonatomic, strong) UIButton *logRegisterbtn;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSMutableDictionary *deviceDictionary;

@end
