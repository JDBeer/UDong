//
//  GetBlindVertifyViewController.m
//  Udong
//
//  Created by wildyao on 15/12/8.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "GetBlindVertifyViewController.h"
#import "YYTextField.h"
#import "FieldBgView.h"
#import "FieldBgForWhiteView.h"
#import "CountDownCapsulation.h"
#import "AccountmanagerViewController.h"
#import "MobileBlindViewController.h"

@interface GetBlindVertifyViewController ()

@end

@implementation GetBlindVertifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self configView];
}

- (void)configView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishedCountdownNotification:) name:DidFinishedCountdownNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDoingCountdownNotification:) name:OnDoingCountdownNotification object:nil];
    
    self.VertifyCodeTf = [[YYTextField alloc] initWithFrame:CGRectMake(0, 6, self.view.width-100,50) leftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_code_blue"]] inset:45];
    self.VertifyCodeTf.placeholder = @"您收到的短信验证码";
    [self.VertifyCodeTf setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
    self.VertifyCodeTf.keyboardType = UIKeyboardTypeNumberPad;
    self.VertifyCodeTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.VertifyCodeTf];
    
    FieldBgForWhiteView *bgView = [[FieldBgForWhiteView alloc] initWithFrame:CGRectMake(_VertifyCodeTf.left, _VertifyCodeTf.top, _VertifyCodeTf.width, _VertifyCodeTf.height) inset:45 count:1];
    [self.view insertSubview:bgView belowSubview:_VertifyCodeTf];
    
    self.countDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.countDownBtn.frame = CGRectMake(self.VertifyCodeTf.right, 0, 60, 20);
    self.countDownBtn.centerY = self.VertifyCodeTf.centerY;
    [self.countDownBtn setBackgroundColor:[UIColor clearColor]];
    self.countDownBtn.layer.cornerRadius = 1;
    self.countDownBtn.userInteractionEnabled = NO;
    [self.countDownBtn setTitle:@"" forState:UIControlStateNormal];
    [self.countDownBtn setTitleColor:kColorBtnColor forState:UIControlStateNormal];
    self.countDownBtn.titleLabel.font = FONT(13);
    [self.countDownBtn addTarget:self action:@selector(resendVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.countDownBtn];
    
    self.finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.finishBtn.frame = CGRectMake(45, self.VertifyCodeTf.bottom+20, self.view.width-45*2, 44);
    [self.finishBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.finishBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    [self.finishBtn addTarget:self action:@selector(onbtnNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.finishBtn setBackgroundColor:kColorBtnColor];
    self.finishBtn.titleLabel.font = FONT(15);
    [self.view addSubview:self.finishBtn];

}

- (void)configNav
{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = kColorWhiteColor;
    [self configBackItem];
    self.view.backgroundColor = kColorWhiteColor;
    self.navigationItem.title = @"手机绑定";
}

- (void)configBackItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 20, 20)];
    [btn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
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
//    NSLog(@"%@",countNumber);
    
}

- (void)onBtnBack:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)onbtnNext:(UIButton *)btn
{
    
//    [SVProgressHUD showHUDWithImage:nil status:@"请稍候" duration:-1];
    [APIServiceManager modifiyAccountPhoneNumberWithKey:[StorageManager getSecretKey] code:@"400" phoneNumber:self.phoneString vertifyCode:self.VertifyCodeTf.text idString:[StorageManager getUserId] status:@"1" completionBlock:^(id responObject) {
        NSLog(@"%@",responObject);
        
        if ([responObject[@"flag"] isEqualToString:@"100100"])
        
        {
            [StorageManager deleteAccountNumber];
            [StorageManager saveAccountNumber:self.phoneString];
            [SVProgressHUD showHUDWithImage:nil status:@"绑定成功" duration:1];
            
            NSArray *viewControllers = [self.navigationController viewControllers];
            for (int i=0; i<[viewControllers count]; i++) {
                id obj = [viewControllers objectAtIndex:i];
                
                if ([obj isKindOfClass:[MobileBlindViewController class]]) {
                    [self.navigationController popToViewController:obj animated:YES];
                }
            }
            return ;
            
        }else if([responObject[@"flag"] isEqualToString:@"100500"])
            
        {
            [SVProgressHUD showHUDWithImage:nil status:@"此手机号已经被绑定" duration:1];
            [self.navigationController popViewControllerAnimated:YES];
            return;
         
        }else if([responObject[@"flag"] isEqualToString:@"100300"])
        {
            [SVProgressHUD showHUDWithImage:nil status:@"验证码输入有误" duration:1];
            return ;
        }
        
        [SVProgressHUD showHUDWithImage:nil status:@"绑定失败" duration:1];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)resendVerifyCode:(UIButton *)btn
{
    
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
