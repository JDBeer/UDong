//
//  LoginViewController.m
//  Udong
//
//  Created by wildyao on 15/11/15.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "LoginViewController.h"
#import "YYTextField.h"
#import "FieldBgView.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"

#define INTERVAL 20
#define INTERVAL_MIDDLE 10


@interface LoginViewController ()<UITextFieldDelegate>


@property (nonatomic, assign) double buttonBottom;
@property (nonatomic, assign) double labelInterval;
@property (nonatomic, assign) double scale;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) double interval;
@property (nonatomic, assign) double buttonHeight;
@property (nonatomic, assign) double textFieldInterval;
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.navigationController.navigationBarHidden = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNumber];
    [self configView];
    
}

- (void)configView
{
    
    self.bgImg = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.bgImg.userInteractionEnabled = YES;
    self.bgImg.image = ImageNamed(@"background");
    [self.view addSubview:self.bgImg];
    
    
    self.LoginImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
    self.LoginImage.centerX = self.view.centerX;
    self.LoginImage.top = _height;
    [self.bgImg addSubview:self.LoginImage];
    
    
    self.accountField = [[YYTextField alloc] initWithFrame:CGRectMake(0, self.LoginImage.bottom+_interval, SCREEN_WIDTH-45, _buttonHeight) leftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon_telephone"]] inset:45];
    self.accountField.delegate = self;
    self.accountField.borderStyle = UITextBorderStyleNone;
    self.accountField.placeholder = @"手机号码";
    self.accountField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.accountField.returnKeyType = UIReturnKeyNext;
    self.accountField.keyboardType = UIKeyboardTypeNumberPad;
    [self.accountField setValue:[ColorManager getColor:@"ffffff" WithAlpha:0.3] forKeyPath:@"_placeholderLabel.textColor"];
    self.cleanImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon_delete"]];
    self.accountField.rightView=self.cleanImg;
    self.accountField.rightViewMode = UITextFieldViewModeWhileEditing;
    [self.bgImg addSubview:self.accountField];
    
    self.accountTfCleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.accountTfCleanBtn.tag = 1;
    self.accountTfCleanBtn.frame = CGRectMake(self.accountField.width-19, 21, 19, 19);
    [self.accountTfCleanBtn addTarget:self action:@selector(deleteString:) forControlEvents:UIControlEventTouchUpInside];
    [self.accountField addSubview:self.accountTfCleanBtn];
    
    
    
    self.passwordField = [[YYTextField alloc] initWithFrame:CGRectMake(0, self.accountField.bottom, SCREEN_WIDTH-45, _buttonHeight) leftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon_password"]] inset:45];
    self.passwordField.delegate = self;
    self.passwordField.borderStyle = UITextBorderStyleNone;
    self.passwordField.placeholder = @"密码";
    [self.passwordField setValue:UIColorFromHexWithAlpha(0xFFFFFF, 0.3) forKeyPath:@"_placeholderLabel.textColor"];
    self.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordField.returnKeyType = UIReturnKeyDone;
    self.passwordField.secureTextEntry = YES;
    self.eyeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon_invisible"]];
    self.passwordField.rightView=self.eyeImg;
    self.passwordField.rightViewMode = UITextFieldViewModeWhileEditing;
    self.passwordTfCleanBtn.tag = 2;
    [self.bgImg addSubview:self.passwordField];
    
    self.passwordTfCleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.passwordTfCleanBtn.frame = CGRectMake(self.passwordField.width-19, 21, 19, 19);
    [self.passwordTfCleanBtn addTarget:self action:@selector(deleteString:) forControlEvents:UIControlEventTouchUpInside];
    [self.passwordField addSubview:self.passwordTfCleanBtn];
    
    FieldBgView *bg = [[FieldBgView alloc] initWithFrame:CGRectMake(_accountField.left, _accountField.top, _accountField.width, _accountField.height*2) inset:45 count:2];
    [self.bgImg insertSubview:bg belowSubview:self.accountField];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(45, self.passwordField.bottom+_textFieldInterval,self.view.width-2*45, _buttonHeight);
    [self.loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:[ColorManager getColor:@"2fbec8" WithAlpha:1]];
    self.loginBtn.titleLabel.font = FONT(17);
    [self.bgImg addSubview:self.loginBtn];
    
    
    CGSize leftSize = [@"忘记密码？" sizeWithAttributes:@{NSFontAttributeName:FONT(13)}];
    self.forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetBtn.frame = CGRectMake(self.loginBtn.left, self.loginBtn.bottom+_textFieldInterval, leftSize.width, leftSize.height);
    [self.forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [self.forgetBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    [self.forgetBtn.titleLabel setFont:FONT(13)];
    [self.forgetBtn addTarget:self action:@selector(onBtnForget:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImg addSubview:self.forgetBtn];
    
    
    CGSize rightSize = [@"注册帐号" sizeWithAttributes:@{NSFontAttributeName:FONT(13)}];
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.frame = CGRectMake(self.loginBtn.right-rightSize.width, self.loginBtn.bottom+_textFieldInterval, rightSize.width, rightSize.height);
    [self.registerBtn setTitle:@"注册帐号" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    [self.registerBtn.titleLabel setFont:FONT(13)];
    [self.registerBtn addTarget:self action:@selector(onBtnRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImg addSubview:self.registerBtn];

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

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyBoard1:)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)onBtnForget:(id)sender
{
    ForgetPasswordViewController *forgetVC = [[ForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

- (void)onBtnRegister:(id)sender
{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)dissmissKeyBoard:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}

- (void)deleteString:(UIButton *)btn
{
    if (btn.tag == 1)
    {
    self.accountField.text = nil;
        
    }else{
        self.passwordField.secureTextEntry = !self.passwordField.secureTextEntry;
    }
}

- (void)dissmissKeyBoard1:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
   
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
