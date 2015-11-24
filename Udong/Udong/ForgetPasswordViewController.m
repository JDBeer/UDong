//
//  ForgetPasswordViewController.m
//  Udong
//
//  Created by wildyao on 15/11/15.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ResetPasswordViewController.h"
#import "YYTextField.h"
#import "FieldBgView.h"
#import "CountDownCapsulation.h"

@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self congfigView];
}

- (void)congfigView
{
//    self.navigationController.navigationBar.tintColor = kColorWhiteColor;
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
    self.getVertifyBtn.titleLabel.font = FONT(13);
    [self.view addSubview:self.getVertifyBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyBoard:)];
    [self.view addGestureRecognizer:tap];
}

- (void)onBtnBack:(UIBarButtonItem *)Item
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)onbtnNext:(id)sender
{
    [self sendVerifyCode];
    [self startTime];
    
    ResetPasswordViewController *ResetVC = [[ResetPasswordViewController alloc] init];
    [self.navigationController pushViewController:ResetVC animated:YES];
}

- (void)sendVerifyCode
{
    
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
