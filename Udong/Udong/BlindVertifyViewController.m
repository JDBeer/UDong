//
//  BlindVertifyViewController.m
//  Udong
//
//  Created by wildyao on 15/12/8.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "BlindVertifyViewController.h"
#import "YYTextField.h"
#import "FieldBgView.h"
#import "Tool.h"
#import "CountDownCapsulation.h"
#import "GetBlindVertifyViewController.h"
#import "FieldBgForWhiteView.h"
@interface BlindVertifyViewController ()

@end

@implementation BlindVertifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
}

- (void)configView
{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = kColorWhiteColor;
    self.navigationController.navigationBar.translucent = NO;
    [self configBackItem];
    self.view.backgroundColor = kColorWhiteColor;
    self.navigationItem.title = @"手机绑定";
    
    self.phoneTf = [[YYTextField alloc] initWithFrame:CGRectMake(0, 6, self.view.width-45, 50) leftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_telephone_blue"]] inset:45];
    self.phoneTf.placeholder = @"请输入您的手机号码";
    [self.phoneTf setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
    self.phoneTf.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.phoneTf];
    
    FieldBgForWhiteView *bgView = [[FieldBgForWhiteView alloc] initWithFrame:CGRectMake(_phoneTf.left, _phoneTf.top, _phoneTf.width, _phoneTf.height) inset:45 count:1];
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

- (void)configBackItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 20, 20)];
    [btn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
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
    
    [SVProgressHUD showHUDWithImage:ImageNamed(@"icon_dialogbg") status:nil duration:1.5];
    [APIServiceManager getVertifyCodeWithSecretKey:[StorageManager getSecretKey] mobileNumber:self.phoneTf.text completionBlock:^(id responObject) {
        NSString *flagString = responObject[@"flag"];
        NSString *message = responObject[@"message"];
        if ([flagString isEqualToString:@"100100"]) {
            [self startTime];
            GetBlindVertifyViewController *GetBlindVC = [[GetBlindVertifyViewController alloc] init];
            GetBlindVC.phoneString = self.phoneTf.text;
            [self.navigationController pushViewController:GetBlindVC animated:YES];
        }else{
            [SVProgressHUD showHUDWithImage:nil status:message duration:1.0];
        }
        
    } failureBlock:^(NSError *error) {
        
        [SVProgressHUD showHUDWithImage:nil status:@"获取验证码失败" duration:-1];
    }];

    
}

- (void)startTime
{
    if ([CountDownCapsulation isTimerValidate]) {
        return;
    }
    [CountDownCapsulation startCountDown:60];

}


- (void)onBtnBack:(UIBarButtonItem *)Item
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dissmissKeyBoard:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
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
