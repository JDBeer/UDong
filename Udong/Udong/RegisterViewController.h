//
//  RggisterViewController.h
//  Udong
//
//  Created by wildyao on 15/11/15.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYTextField.h"
#import "FinishRegisterViewController.h"

@interface RegisterViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, strong)UIImageView *logoImage;
@property (nonatomic, strong)YYTextField *phoneNumberTextField;
@property (nonatomic, strong)UIButton *button;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UIImageView *bgImg;
@property (nonatomic, strong)UIImageView *logRegisterImage;
@property (nonatomic, strong)UIButton *backBtn;
@property (nonatomic, strong)UIButton *accountTfCleanBtn;
@end
