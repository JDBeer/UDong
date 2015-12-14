//
//  ForgetPasswordViewController.m
//  Udong
//
//  Created by wildyao on 15/11/15.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ResetPasswordViewController.h"
#import "LoginViewController.h"
#import "YYTextField.h"
#import "FieldBgView.h"
#import "CountDownCapsulation.h"
#import "Tool.h"

@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self congfigView];
}

- (void)congfigView
{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = kColorWhiteColor;
    [self configBackItem];
    self.view.backgroundColor = kColorWhiteColor;
    self.navigationItem.title = @"忘记密码";
    
    self.phoneTf = [[YYTextField alloc] initWithFrame:CGRectMake(0, 70, self.view.width-45, 50) leftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_telephone_blue"]] inset:45];
    self.phoneTf.placeholder = @"请输入您注册时的手机号码";
    [self.phoneTf setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
    self.phoneTf.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.phoneTf];
    
    FieldBgView *bgView = [[FieldBgView alloc] initWithFrame:CGRectMake(_phoneTf.left, _phoneTf.top, _phoneTf.width, _phoneTf.height) inset:45 count:1];
    [self.view insertSubview:bgView belowSubview:self.phoneTf];
    
    self.getVertifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getVertifyBtn.frame = CGRectMake(45, self.phoneTf.bottom+20, self.view.width-45*2, 44);
    [self.getVertifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getVertifyBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    [self.getVertifyBtn addTarget:self action:@selector(onbtnNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.getVertifyBtn setBackgroundColor:kColorBtnColor];
    self.getVertifyBtn.titleLabel.font = FONT(15);
    [self.view addSubview:self.getVertifyBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyBoard:)];
    [self.view addGestureRecognizer:tap];
}

- (void)onbtnNext:(id)sender
{
   
    
    NSString *number = [self.phoneTf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (![Tool validateMobile:number]) {
        [SVProgressHUD showHUDWithImage:nil status:@"请输入正确的手机号码" duration:2];
        return;
    }
    
    if (self.phoneTf.text.length == 0) {
        [SVProgressHUD showHUDWithImage:nil status:@"请输入手机号码" duration:2];
        return;
    }
    
    [self sendVerifyCode];
    
    
}

- (void)sendVerifyCode
{
    [SVProgressHUD showHUDWithImage:nil status:@"请稍候" duration:1];
    [APIServiceManager getVertifyCodeWithSecretKey:[StorageManager getSecretKey] mobileNumber:self.phoneTf.text completionBlock:^(id responObject) {
        NSString *flagString = responObject[@"flag"];
        NSString *message = responObject[@"message"];
        if ([flagString isEqualToString:@"100100"]) {
            [SVProgressHUD dismiss];
            [self startTime];
            ResetPasswordViewController *ressetVC = [[ResetPasswordViewController alloc] init];
            ressetVC.phoneNumberString = self.phoneTf.text;
            [self.navigationController pushViewController:ressetVC animated:YES];
        }else{
            [SVProgressHUD showHUDWithImage:nil status:message duration:1.0];
        }
        
    } failureBlock:^(NSError *error) {
        
        [SVProgressHUD showHUDWithImage:nil status:@"获取验证码失败" duration:-1];
    }];

}

- (void)dissmissKeyBoard:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}

- (void)startTime
{
    if ([CountDownCapsulation isTimerValidate]) {
        return;
    }
    [CountDownCapsulation startCountDown:60];
}

- (void)configBackItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 20, 20)];
    [btn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)onBtnBack:(UIBarButtonItem *)Item
{
    NSArray *viewControllers = [[self navigationController] viewControllers];
    for(int i = 0; i < [viewControllers count]; i++){
        id obj = [viewControllers objectAtIndex:i];
        if([obj isKindOfClass:[LoginViewController class]]){
            [[self navigationController] popToViewController:obj animated:YES];
            break;
        }
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
