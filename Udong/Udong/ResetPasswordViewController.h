//
//  ResetPasswordViewController.h
//  Udong
//
//  Created by wildyao on 15/11/15.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPasswordViewController : UIViewController
@property (nonatomic, strong)UITextField *vertifyCodeTf;
@property (nonatomic, strong)UITextField *phoneNumberTf;
@property (nonatomic, strong)UIButton *finishBtn;
@property (nonatomic, strong)UIButton *countdownBtn;
@property (nonatomic, strong)UIButton *eyeBtn;
@property (nonatomic, strong)NSString *phoneNumberString;

@end
