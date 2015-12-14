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
#import "Tool.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "MasterTabBarViewController.h"
#import "DeviceHandleManager.h"

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
    [self configData];
    [self configView];
    
}

- (void)configView
{
    self.navigationController.navigationBarHidden = YES;
    
    self.bgImg = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.bgImg.userInteractionEnabled = YES;
    self.bgImg.image = ImageNamed(@"background");
    self.contentView = [[UIView alloc] initWithFrame:self.bgImg.frame];
    [self.contentView addSubview:self.bgImg];
    [self.view addSubview:self.contentView];
    
    
    self.LoginImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
    self.LoginImage.centerX = self.view.centerX;
    self.LoginImage.top = _height;
    [self.contentView addSubview:self.LoginImage];
    
    
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
    [self.contentView addSubview:self.accountField];
    
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
    [self.contentView addSubview:self.passwordField];
    
    self.passwordTfCleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.passwordTfCleanBtn.frame = CGRectMake(self.passwordField.width-19, 21, 19, 19);
    [self.passwordTfCleanBtn addTarget:self action:@selector(deleteString:) forControlEvents:UIControlEventTouchUpInside];
    [self.passwordField addSubview:self.passwordTfCleanBtn];
    
    FieldBgView *bg = [[FieldBgView alloc] initWithFrame:CGRectMake(_accountField.left, _accountField.top, _accountField.width, _accountField.height*2) inset:45 count:2];
    [self.contentView insertSubview:bg belowSubview:self.accountField];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(45, self.passwordField.bottom+_textFieldInterval,self.view.width-2*45, _buttonHeight);
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:[ColorManager getColor:@"2fbec8" WithAlpha:1]];
    [self.loginBtn addTarget:self action:@selector(onBtnToHomepage:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.titleLabel.font = FONT(17);
    [self.contentView addSubview:self.loginBtn];
    
    
    CGSize leftSize = [@"忘记密码？" sizeWithAttributes:@{NSFontAttributeName:FONT(13)}];
    self.forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetBtn.frame = CGRectMake(self.loginBtn.left, self.loginBtn.bottom+_textFieldInterval, leftSize.width, leftSize.height);
    [self.forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [self.forgetBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    [self.forgetBtn.titleLabel setFont:FONT(13)];
    [self.forgetBtn addTarget:self action:@selector(onBtnForget:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.forgetBtn];
    
    
    CGSize rightSize = [@"注册帐号" sizeWithAttributes:@{NSFontAttributeName:FONT(13)}];
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.frame = CGRectMake(self.loginBtn.right-rightSize.width, self.loginBtn.bottom+_textFieldInterval, rightSize.width, rightSize.height);
    [self.registerBtn setTitle:@"注册帐号" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    [self.registerBtn.titleLabel setFont:FONT(13)];
    [self.registerBtn addTarget:self action:@selector(onBtnRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.registerBtn];
    
    

    for (int i=0; i<3; i++) {
        self.logRegisterbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.logRegisterbtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"login_icon_%d",i+1]] forState:UIControlStateNormal];
        
        self.logRegisterbtn.frame = CGRectMake(0, 0, 40, 40);
        self.logRegisterbtn.bottom = self.view.bottom-_buttonBottom;
        self.logRegisterbtn.tag = i+1;
        [self.logRegisterbtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i==0) {
            self.logRegisterbtn.left = self.view.left +60;
        }else if (i==1)
        {
            self.logRegisterbtn.centerX = self.view.centerX;
        }else if (i==2)
        {
            self.logRegisterbtn.right = self.view.right-60;
        }
        [self.contentView addSubview:self.logRegisterbtn];
    }
    
    
    
    
    CGSize labelSize = [@"使用合作伙伴登录" sizeWithAttributes:@{NSFontAttributeName:FONT(13)}];
    UILabel *plabel = [[UILabel alloc] init];
    plabel.centerX = self.view.centerX;
    plabel.bottom = self.logRegisterbtn.top-_labelInterval;
    plabel.bounds = CGRectMake(0, 0, labelSize.width, labelSize.height);
    plabel.text = @"使用合作伙伴登录";
    plabel.textColor = [ColorManager getColor:@"ffffff" WithAlpha:0.3];
    plabel.font = FONT(13);
    [self.contentView addSubview:plabel];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyBoard1:)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
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

- (void)onBtnToHomepage:(id)sender
{
// 去除前后空格
    NSString *number = [self.accountField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (number.length == 0) {
        [SVProgressHUD showHUDWithImage:nil status:@"请输入手机号码" duration:2];
        return;
    }
    
    if (![Tool validateMobile:number]) {
        [SVProgressHUD showHUDWithImage:nil status:@"请输入正确的手机号码" duration:2];
        return;
    }

    if (self.passwordField.text.length == 0) {
        [SVProgressHUD showHUDWithImage:nil status:@"请输入密码" duration:2];
        return;
    }
    
    [SVProgressHUD showProgressWithStatus:@"请稍候" duration:-1];
    
    [APIServiceManager LoginWithSecretkey:[StorageManager getSecretKey] phoneNumber:self.accountField.text password:self.passwordField.text Logintype:@"0" openudid:self.deviceDictionary[OpenUdidKey] deviceOS:self.deviceDictionary[DeviceOSKey] deviceModel:self.deviceDictionary[DcviceModelKey] deviceResolution:self.deviceDictionary[DeviceResolutionKey] deviceVersion:self.deviceDictionary[DeviceVersionKey] completionBlock:^(id responObject) {
        NSLog(@"%@",responObject);
        NSString *flagString = responObject[@"flag"];
        NSString *message = responObject[@"message"];
        if ([flagString isEqualToString:@"100100"]) {
            [SVProgressHUD dismiss];
//     清空本地存储的数据，存入最新的数据
            [StorageManager deleteRelatedInfo];
            NSString *idString = [NSString stringWithFormat:@"%@",responObject[@"user"][@"id"]];
            [StorageManager saveAccountNumber:self.accountField.text];
            [StorageManager saveUserId:idString];
            [StorageManager savepsw:self.passwordField.text];
            
            MasterTabBarViewController *tabBarVC = [[MasterTabBarViewController alloc] init];
            [self.navigationController pushViewController:tabBarVC animated:YES];
        }else{
            [SVProgressHUD showHUDWithImage:nil status:message duration:1.0];
        }
        
    } failureBlock:^(NSError *error) {
        
        [SVProgressHUD showHUDWithImage:nil status:@"登录失败" duration:-1];
    }];
    
    
    
   
}

- (void)loginBtnClick:(UIButton *)btn
{
    if (btn.tag == 1) {
        NSLog(@"1");
    }
    if (btn.tag == 2) {
        NSLog(@"2");
    }
    if (btn.tag == 3) {
        NSLog(@"3");
    }
    
}

- (void)configData
{
    self.deviceDictionary = [[NSMutableDictionary alloc] init];
    self.deviceDictionary = [DeviceHandleManager configureBaseData];
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
