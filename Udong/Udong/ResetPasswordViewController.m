//
//  ResetPasswordViewController.m
//  Udong
//
//  Created by wildyao on 15/11/15.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "ForgetPasswordViewController.h"
#import "YYTextField.h"
#import "FieldBgView.h"
#import "CountDownCapsulation.h"

@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
    
}

- (void)configView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishedCountdownNotification:) name:DidFinishedCountdownNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDoingCountdownNotification:) name:OnDoingCountdownNotification object:nil];
    
    self.navigationItem.title = @"重置密码";
    self.view.backgroundColor = kColorWhiteColor;
    [self configBackItem];
    
    self.vertifyCodeTf = [[YYTextField alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH-100, 50) leftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_code_blue"]] inset:45];
    self.vertifyCodeTf.placeholder = @"您收到的短信验证码";
    [self.vertifyCodeTf setValue:FONT(15) forKeyPath:@"_placeholderLabel.font"];
    self.vertifyCodeTf.keyboardType = UIKeyboardTypeNumberPad;
    self.vertifyCodeTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.vertifyCodeTf];
    
    self.countdownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.countdownBtn.frame = CGRectMake(self.vertifyCodeTf.right, 0, 60, 30);
    self.countdownBtn.centerY = self.vertifyCodeTf.centerY;
    [self.countdownBtn setTitleColor:kColorBtnColor forState:UIControlStateNormal];
    self.countdownBtn.titleLabel.font = FONT(16);
    
    [self.view addSubview:self.countdownBtn];
    
    self.phoneNumberTf = [[YYTextField alloc] initWithFrame:CGRectMake(0, self.vertifyCodeTf.bottom, self.vertifyCodeTf.width+self.countdownBtn.width ,self.vertifyCodeTf.height) leftView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_password_blue"]] inset:45];
    self.phoneNumberTf.placeholder = @"6~16个数字或字母";
    [self.phoneNumberTf setValue:FONT(15) forKeyPath:@"_placeholderLabel.font"];
    self.phoneNumberTf.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumberTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.eyeBtn setBackgroundImage:[UIImage imageNamed:@"icon_visible_blue"] forState:UIControlStateNormal];
    [self.eyeBtn setBackgroundImage:[UIImage imageNamed:@"icon_invisible_blue"] forState:UIControlStateSelected];
    self.eyeBtn.bounds = CGRectMake(0, 0, 25, 20);
    [self.eyeBtn addTarget:self action:@selector(pswHiden:) forControlEvents:UIControlEventTouchUpInside];
    self.phoneNumberTf.rightView = self.eyeBtn;
    self.phoneNumberTf.rightViewMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.phoneNumberTf];
    
    
    
    
    
    FieldBgView *bgView = [[FieldBgView alloc] initWithFrame:self.vertifyCodeTf.frame inset:45 count:2];
    [self.view insertSubview:bgView belowSubview:self.vertifyCodeTf];
    
    self.finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.finishBtn.frame = CGRectMake(45, self.phoneNumberTf.bottom+20, self.view.width-45*2, 44);
    [self.finishBtn setBackgroundColor:kColorBtnColor];
    [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.finishBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    self.finishBtn.titleLabel.font = FONT(13);
    [self.finishBtn addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.finishBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyBoard:)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)configBackItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 20, 20)];
    [btn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

- (void)didFinishedCountdownNotification:(NSNotification *)notification
{
    //    NSNumber *countNumber = notification.object;
    [self.countdownBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    self.countdownBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.countdownBtn.userInteractionEnabled = YES;
}

- (void)onDoingCountdownNotification:(NSNotification *)notification
{
    NSNumber *countNumber = notification.object;
    [self.countdownBtn setTitle:[NSString stringWithFormat:@"%@秒",countNumber] forState:UIControlStateNormal];
    self.countdownBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.countdownBtn.userInteractionEnabled = YES;
    
}

- (void)pswHiden:(UIButton *)btn
{
    btn.selected = !btn.selected;
    self.phoneNumberTf.secureTextEntry = !self.phoneNumberTf.secureTextEntry;
    
}


- (void)finish:(id)sender
{
    NSLog(@"重置成功");
}

- (void)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
