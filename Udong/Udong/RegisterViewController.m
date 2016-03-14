//
//  RggisterViewController.m
//  Udong
//
//  Created by wildyao on 15/11/15.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "RegisterViewController.h"
#import "CountDownCapsulation.h"
#import "FieldBgView.h"
#import "Tool.h"


#define INTERVAL 20
#define INTERVAL_MIDDLE 10

@interface RegisterViewController () 
@property (nonatomic, assign) double buttonBottom;
@property (nonatomic, assign) double labelInterval;
@property (nonatomic, assign) double scale;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) double interval;
@property (nonatomic, assign) double buttonHeight;
@property (nonatomic, assign) double textFieldInterval;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorWhiteColor;
    [self configNumber];
    [self configView];
}

- (void)configView
{
    [self configBackItem];
    
    self.bgImg = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.bgImg.userInteractionEnabled = YES;
    self.bgImg.image = ImageNamed(@"background");
    [self.view addSubview:self.bgImg];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(10, 35, 23, 23);
    [self.backBtn setBackgroundImage:ImageNamed(@"navbar_icon_back_white") forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
    
    
    self.logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
    self.logoImage.centerX = self.view.centerX;
    self.logoImage.top = _height;
    [self.bgImg addSubview:self.logoImage];
    
    self.phoneNumberTextField = [[YYTextField alloc] initWithFrame:CGRectMake(0, self.logoImage.bottom +_interval,SCREEN_WIDTH-45, _buttonHeight) leftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon_telephone"]] inset:45];
    self.phoneNumberTextField.placeholder = @"请输入您的手机号码";
    [self.phoneNumberTextField setValue:[ColorManager getColor:@"ffffff" WithAlpha:0.3] forKeyPath:@"_placeholderLabel.textColor"];
    self.phoneNumberTextField.delegate = self;
    self.phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNumberTextField.tintColor = kColorWhiteColor;
    self.phoneNumberTextField.textColor = kColorWhiteColor;
    
    UIImageView *cleanImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon_delete"]];
    
    self.phoneNumberTextField.rightView = cleanImg;
    self.phoneNumberTextField.rightViewMode = UITextFieldViewModeWhileEditing;
    self.phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    
    [self.bgImg addSubview:self.phoneNumberTextField];
    
    [self.phoneNumberTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.accountTfCleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.accountTfCleanBtn.frame = CGRectMake(self.phoneNumberTextField.width-19, 16, 40, 40);
    [self.accountTfCleanBtn addTarget:self action:@selector(deleteString:) forControlEvents:UIControlEventTouchUpInside];
    [self.phoneNumberTextField addSubview:self.accountTfCleanBtn];
    
    
    FieldBgView *bg = [[FieldBgView alloc] initWithFrame:self.phoneNumberTextField.frame inset:45 count:1];
    [self.bgImg insertSubview:bg belowSubview:self.phoneNumberTextField];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(45, self.phoneNumberTextField.bottom+_textFieldInterval, SCREEN_WIDTH-90,_buttonHeight);
    [self.button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.button setBackgroundColor:[ColorManager getColor:@"2fbec8" WithAlpha:1]];
    self.button.layer.cornerRadius = self.button.height/2;
    self.button.layer.masksToBounds = YES;
    [self.button addTarget:self action:@selector(pushToVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    self.button.titleLabel.font = FONT(17);
    [self.bgImg addSubview:self.button];
    
    CGSize rightSize = [@"用已有帐号登录" sizeWithAttributes:@{NSFontAttributeName:FONT(13)}];
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(self.button.right-rightSize.width, self.button.bottom+_textFieldInterval, rightSize.width, rightSize.height);
    [self.rightBtn setTitle:@"用已有帐号登录" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    [self.rightBtn.titleLabel setFont:FONT(13)];
    [self.rightBtn addTarget:self action:@selector(onBtnForget:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImg addSubview:self.rightBtn];
    
    
    for (int i=0; i<3; i++) {
        self.logRegisterImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"login_icon_%d",i+1]]];
        self.logRegisterImage.bottom = self.view.bottom-_buttonBottom;
        if (i==0) {
            self.logRegisterImage.left = self.view.left +60;
        }else if (i==1)
        {
            self.logRegisterImage.centerX = self.view.centerX;
        }else if (i==2)
        {
            self.logRegisterImage.right = self.view.right-60;
        }
        [self.bgImg addSubview:self.logRegisterImage];
    }

    CGSize labelSize = [@"使用合作伙伴登录" sizeWithAttributes:@{NSFontAttributeName:FONT(13)}];
    UILabel *plabel = [[UILabel alloc] init];
    plabel.centerX = self.view.centerX;
    plabel.bottom = self.logRegisterImage.top-_labelInterval;
    plabel.bounds = CGRectMake(0, 0, labelSize.width, labelSize.height);
    plabel.text = @"使用合作伙伴登录";
    plabel.textColor = [ColorManager getColor:@"ffffff" WithAlpha:0.3];
    plabel.font = FONT(13);
    [self.bgImg addSubview:plabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyBoard:)];
    [self.view addGestureRecognizer:tap];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)deleteString:(UIButton *)btn
{
//    [self.phoneNumberTextField becomeFirstResponder];
    
    self.phoneNumberTextField.text = nil;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phoneNumberTextField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}

- (void)configBackItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 20, 20)];
    [btn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushToVerifyCode:(UIButton *)btn
{
    FinishRegisterViewController *finishRVC = [[FinishRegisterViewController alloc] init];
    finishRVC.phoneNumberString = self.phoneNumberTextField.text;
    
    NSString *number = [self.phoneNumberTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (self.phoneNumberTextField.text.length == 0) {
        [SVProgressHUD showHUDWithImage:nil status:@"请输入手机号码" duration:2];
        return;
    }
    
    if (![Tool validateMobile:number]) {
        [SVProgressHUD showHUDWithImage:nil status:@"请输入正确的手机号码" duration:2];
        return;
    }
    
    [SVProgressHUD showProgressWithStatus:@"请稍候" duration:-1];
    
    [APIServiceManager PhoneRegisterWithSecretKey:[StorageManager getSecretKey] phoneNumber:self.phoneNumberTextField.text completionBlock:^(id responObject) {
        
        NSString *flagString = responObject[@"flag"];
        NSString *message = responObject[@"message"];
        if ([flagString isEqualToString:@"100100"]) {
            [SVProgressHUD dismiss];
            [self sendVerifyCode];
        }else{
            
            if ([flagString isEqualToString:@"100501"]) {
                [SVProgressHUD showHUDWithImage:nil status:@"操作过于频繁，请稍候再试" duration:1];
                return ;
            }
            
            [SVProgressHUD showHUDWithImage:nil status:message duration:1];
        }
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
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

- (void)sendVerifyCode
{
    NSString *key = [StorageManager getSecretKey];
    
    [SVProgressHUD showProgressWithStatus:@"请稍候" duration:-1];
    
    [APIServiceManager getVertifyCodeWithSecretKey:key mobileNumber:self.phoneNumberTextField.text completionBlock:^(id responObject) {
        NSString *flagString = responObject[@"flag"];
        NSString *message = responObject[@"message"];
        if ([flagString isEqualToString:@"100100"]) {
            [SVProgressHUD dismiss];
            [self startTime];
            FinishRegisterViewController *finishRVC = [[FinishRegisterViewController alloc] init];
            finishRVC.phoneNumberString = self.phoneNumberTextField.text;
            [self.navigationController pushViewController:finishRVC animated:YES];
        }else if ([flagString isEqualToString:@"100501"])
        {
            [SVProgressHUD showHUDWithImage:nil status:@"验证码发送过于频繁，请稍候再试" duration:1.0];
        }else
        {
            [SVProgressHUD showHUDWithImage:nil status:message duration:1.0];
        }
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showHUDWithImage:nil status:@"登录失败" duration:-1];
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void)configNumber
{
    
    if (IS_IPONE_4_OR_LESS) {
        _scale = 480.0/667;
        _height = 100*_scale;
        _interval =60*_scale;
        _buttonHeight =44*_scale;
        _buttonBottom = 54*_scale;
        _labelInterval = 30*_scale;
        _textFieldInterval = 30*_scale;
    }else if (IS_IPHONE_5){
        _scale = 568.0/667;
        _height = 100*_scale;
        _interval = 60*_scale;
        _buttonHeight = 44*_scale;
        _buttonBottom = 54*_scale;
        _labelInterval = 30*_scale;
        _textFieldInterval = 30*_scale;
    }else if (IS_IPHONE_6){
        _scale = 1;
        _height = 100;
        _interval = 60;
        _buttonHeight = 44;
        _buttonBottom = 54;
        _labelInterval = 30;
        _textFieldInterval = 30;
        _textFieldInterval = 30*_scale;
    }else if (IS_IPHONE_6P){
        _scale = 736/667;
        _height = 100*_scale;
        _interval = 60*_scale;
        _buttonHeight = 44*_scale;
        _buttonBottom = 54*_scale;
        _labelInterval = 30*_scale;
        _textFieldInterval = 30*_scale;
    }
    
}

- (void)onBtnForget:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
