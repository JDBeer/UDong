//
//  FinishRegisterViewController.m
//  Udong
//
//  Created by wildyao on 15/11/19.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "FinishRegisterViewController.h"
#import "RegisterViewController.h"
#import "ServiceProvisionViewController.h"
#import "FieldBgView.h"
#import "CountDownCapsulation.h"
#import "MasterTabBarViewController.h"
#import "DeviceHandleManager.h"

#define INTERVAL 20
#define INTERVAL_MIDDLE 10

@interface FinishRegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, assign) double buttonBottom;
@property (nonatomic, assign) double labelInterval;
@property (nonatomic, assign) double scale;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) double interval;
@property (nonatomic, assign) double buttonHeight;
@property (nonatomic, assign) double textFieldInterval;


@end

@implementation FinishRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNumber];
    [self configData];
    [self configView];
   
}

- (void)configView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishedCountdownNotification:) name:DidFinishedCountdownNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDoingCountdownNotification:) name:OnDoingCountdownNotification object:nil];
    
    [self configBackItem];
    
    self.bgImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.bgImage.userInteractionEnabled = YES;
    self.bgImage.image = ImageNamed(@"background");
    [self.view addSubview:self.bgImage];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(10, 35, 23, 23);
    [self.backBtn setBackgroundImage:ImageNamed(@"navbar_icon_back_white") forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
    
    self.logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
    self.logoImage.centerX = self.view.centerX;
    self.logoImage.top = _height;
    [self.bgImage addSubview:self.logoImage];
    
    
    self.VertifyCodeTf = [[YYTextField alloc] initWithFrame:CGRectMake(0, self.logoImage.bottom+_interval, SCREEN_WIDTH-100, _buttonHeight) leftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon_code"]] inset:45];
    self.VertifyCodeTf.delegate = self;
    self.VertifyCodeTf.borderStyle = UITextBorderStyleNone;
    self.VertifyCodeTf.placeholder = @"验证码";
    self.VertifyCodeTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.VertifyCodeTf.returnKeyType = UIReturnKeyNext;
    self.VertifyCodeTf.keyboardType = UIKeyboardTypeNumberPad;
    [self.VertifyCodeTf setValue:[ColorManager getColor:@"ffffff" WithAlpha:0.3] forKeyPath:@"_placeholderLabel.textColor"];
    self.cleanImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon_delete"]];
//    self.VertifyCodeTf.rightView=self.countDownBtn;
//    self.VertifyCodeTf.rightViewMode = UITextFieldViewModeWhileEditing;
    [self.bgImage addSubview:self.VertifyCodeTf];
    
    self.countDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.countDownBtn.frame = CGRectMake(self.VertifyCodeTf.right, 0, 60, 20);
    self.countDownBtn.centerY = self.VertifyCodeTf.centerY;
    [self.countDownBtn setBackgroundColor:[UIColor clearColor]];
    self.countDownBtn.layer.cornerRadius = 1;
    self.countDownBtn.userInteractionEnabled = NO;
    [self.countDownBtn setTitle:@"" forState:UIControlStateNormal];
    [self.countDownBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    self.countDownBtn.titleLabel.font = FONT(13);
    [self.countDownBtn addTarget:self action:@selector(resendVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImage addSubview:self.countDownBtn];
    

    self.passwordTf = [[YYTextField alloc] initWithFrame:CGRectMake(0, self.VertifyCodeTf.bottom, SCREEN_WIDTH-45, _buttonHeight) leftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon_password"]] inset:45];
    self.passwordTf.delegate = self;
    self.passwordTf.borderStyle = UITextBorderStyleNone;
    self.passwordTf.placeholder = @"密码";
    [self.passwordTf setValue:UIColorFromHexWithAlpha(0xFFFFFF, 0.3) forKeyPath:@"_placeholderLabel.textColor"];
    self.passwordTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTf.returnKeyType = UIReturnKeyDone;
    self.passwordTf.secureTextEntry = YES;
    self.passwordTf.rightView=self.cleanImg;
    self.passwordTf.rightViewMode = UITextFieldViewModeWhileEditing;
    [self.bgImage addSubview:self.passwordTf];
    
    self.passwordTfCleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.passwordTfCleanBtn.frame = CGRectMake(self.passwordTf.width-19, 21, 19, 19);
    [self.passwordTfCleanBtn addTarget:self action:@selector(deleteString:) forControlEvents:UIControlEventTouchUpInside];
    [self.passwordTf addSubview:self.passwordTfCleanBtn];
    
    FieldBgView *bg = [[FieldBgView alloc] initWithFrame:CGRectMake(self.VertifyCodeTf.left, self.VertifyCodeTf.top, self.VertifyCodeTf.width+self.countDownBtn.width, self.VertifyCodeTf.height*2) inset:45 count:2];
    [self.bgImage insertSubview:bg belowSubview:self.VertifyCodeTf];


    self.finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.finishBtn.frame = CGRectMake(45, self.passwordTf.bottom+_textFieldInterval,self.view.width-2*45, _buttonHeight);
    [self.finishBtn setBackgroundColor:kColorGrayColor];
    [self.finishBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.finishBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    [self.finishBtn addTarget:self action:@selector(onBtnToHomepage:) forControlEvents:UIControlEventTouchUpInside];
    [self.finishBtn setBackgroundColor:[ColorManager getColor:@"2fbec8" WithAlpha:1]];
    self.finishBtn.titleLabel.font = FONT(17);
    [self.bgImage addSubview:self.finishBtn];
    
    CGSize privisionLabel = [@"完成注册表示您接受我们的" sizeWithAttributes:@{NSFontAttributeName:FONT(13)}];
    self.ProvisionLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, self.finishBtn.bottom+_textFieldInterval, privisionLabel.width, privisionLabel.height)];
    self.ProvisionLabel.text = @"完成注册表示您接受我们的";
    self.ProvisionLabel.font = FONT(13);
    self.ProvisionLabel.textAlignment = NSTextAlignmentCenter;
    self.ProvisionLabel.textColor = kColorWhiteColor;
    [self.bgImage addSubview:self.ProvisionLabel];
    
    CGSize btnLabel = [@"《服务条款》" sizeWithAttributes:@{NSFontAttributeName:FONT(13)}];
    self.ProvisionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ProvisionBtn .frame = CGRectMake(self.ProvisionLabel.right, self.finishBtn.bottom+_textFieldInterval,btnLabel.width ,btnLabel.height);
    [self.ProvisionBtn setTitle:@"《服务条款》" forState:UIControlStateNormal];
    [self.ProvisionBtn setTitleColor:kColorBtnColor forState:UIControlStateNormal];
    self.ProvisionBtn.titleLabel.font = FONT(13);
    [self.ProvisionBtn addTarget:self action:@selector(pushToProvisionVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImage addSubview:self.ProvisionBtn];
    
    
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
        [self.bgImage addSubview:self.logRegisterImage];
    }

    CGSize labelSize = [@"使用合作伙伴登录" sizeWithAttributes:@{NSFontAttributeName:FONT(13)}];
    UILabel *plabel = [[UILabel alloc] init];
    plabel.centerX = self.view.centerX;
    plabel.bottom = self.logRegisterImage.top-_labelInterval;
    plabel.bounds = CGRectMake(0, 0, labelSize.width, labelSize.height);
    plabel.text = @"使用合作伙伴登录";
    plabel.textColor = [ColorManager getColor:@"ffffff" WithAlpha:0.3];
    plabel.font = FONT(13);
    [self.bgImage addSubview:plabel];
    
   
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

- (void)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onBtnToHomepage:(id)sender
{
    MasterTabBarViewController *mastVC = [[MasterTabBarViewController alloc] init];
    if (self.VertifyCodeTf.text.length == 0) {
        [SVProgressHUD showHUDWithImage:nil status:@"请输入验证码" duration:2];
        return;
    }
    
    if (self.passwordTf.text.length == 0) {
        [SVProgressHUD showHUDWithImage:nil status:@"请输入密码" duration:2];
        return;
    }
    
    [SVProgressHUD showHUDWithImage:nil status:@"请稍候" duration:-1];
    [APIServiceManager registerWithSecretKey:[StorageManager getSecretKey] openudid:self.deviceDictionary[OpenUdidKey] deviceOS:self.deviceDictionary[DeviceOSKey] deviceModel:self.deviceDictionary[DcviceModelKey] deviceResolution:self.deviceDictionary[DeviceResolutionKey] deviceVersion:self.deviceDictionary[DeviceVersionKey] userId:[StorageManager getUserId] phoneNumber:self.phoneNumberString password:self.passwordTf.text vertifyCode:self.VertifyCodeTf.text completionBlock:^(id responObject) {
        
        NSString *flagString = responObject[@"flag"];
        NSString *message = responObject[@"message"];
//        NSLog(@"----%@-----%@----%@",responObject,flagString,message);
        if ([flagString isEqualToString:@"100100"]) {
             NSString *IdString= responObject[@"user"][@"id"];
            [SVProgressHUD dismiss];
//            注册时清空本地数据，存入最新数据
            [StorageManager deleteRelatedInfo];
            [StorageManager saveAccountNumber:self.phoneNumberString];
            [StorageManager saveUserId:IdString];
            [StorageManager savepsw:self.passwordTf.text];
            [self.navigationController pushViewController:mastVC animated:YES];
        }else
        {
            [SVProgressHUD showHUDWithImage:nil status:message duration:1.0];
        }
        
       
    } failureBlock:^(NSError *error) {
        
        [SVProgressHUD showHUDWithImage:nil status:@"注册失败" duration:-1];
    }];
    
    
}

- (void)pushToProvisionVC:(id)sender
{
    ServiceProvisionViewController *servicePsVC = [[ServiceProvisionViewController alloc] init];
    
    NSString *key = [StorageManager getSecretKey];
    
    [APIServiceManager getProvisionWithSecretKey:key type:@"1" completionBlock:^(id responObject) {
        NSString *flagString = responObject[@"flag"];
        NSString *message = responObject[@"message"];
        if ([flagString isEqualToString:@"100100"]) {
            [SVProgressHUD dismiss];
            [self.navigationController pushViewController:servicePsVC animated:YES];
        }else{
            
            [SVProgressHUD showHUDWithImage:nil status:message duration:1.0];
        }
       
    } failureBlock:^(NSError *error) {
        
        [SVProgressHUD showHUDWithImage:nil status:@"获取服务条款失败" duration:1.0];
    }];
    
    
    
    
}

- (void)deleteString:(id)sender
{
    if (self.passwordTf.text) {
        self.passwordTf.text = nil;
    }
}

- (void)resendVerifyCode:(id)sender
{
    
}

- (void)dissmissKeyBoard:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}

- (void)didFinishedCountdownNotification:(NSNotification *)notification
{
//    NSNumber *countNumber = notification.object;
    [self.countDownBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    self.countDownBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.countDownBtn.userInteractionEnabled = YES;
}

- (void)onDoingCountdownNotification:(NSNotification *)notification
{
    NSNumber *countNumber = notification.object;
    [self.countDownBtn setTitle:[NSString stringWithFormat:@"%@秒",countNumber] forState:UIControlStateNormal];
    self.countDownBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.countDownBtn.userInteractionEnabled = YES;

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
