//
//  PswChangeViewController.m
//  Udong
//
//  Created by wildyao on 15/11/26.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "PswChangeViewController.h"
#import "PswChangeTxetField.h"
#import "FieldBgView.h"

@interface PswChangeViewController ()

@end

@implementation PswChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self confogNav];
    [self configView];
    
}

- (void)configView
{
    UILabel *oldPswLabel = [[UILabel alloc] init];
    oldPswLabel.text = @"旧密码";
    oldPswLabel.bounds = CGRectMake(0, 0, 60, 50);
    oldPswLabel.font = FONT(15);
    
    UILabel *newPswLabel = [[UILabel alloc] init];
    newPswLabel.text = @"新密码";
    newPswLabel.bounds = CGRectMake(0, 0, 60, 50);
    newPswLabel.font = FONT(15);
    
    UILabel *confirmPswLabel = [[UILabel alloc] init];
    confirmPswLabel.text = @"确认密码";
    confirmPswLabel.bounds = CGRectMake(0, 0, 60, 50);
    confirmPswLabel.font = FONT(15);
    
    self.oldPswTf = [[PswChangeTxetField alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH-45, 50) leftView:oldPswLabel inset:45];
    self.oldPswTf.placeholder = @"你当前的密码";
    [self.oldPswTf setValue:FONT(15) forKeyPath:@"_placeholderLabel.font"];
    self.oldPswTf.keyboardType = UIKeyboardTypeNumberPad;
    self.oldPswTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.oldPswTf];
    
    self.newpswTf = [[PswChangeTxetField alloc] initWithFrame:CGRectMake(0, self.oldPswTf.bottom, self.oldPswTf.width, self.oldPswTf.height) leftView:newPswLabel inset:45];
    self.newpswTf.placeholder = @"6~16个数字或字母";
    [self.newpswTf setValue:FONT(15) forKeyPath:@"_placeholderLabel.font"];
    self.newpswTf.keyboardType = UIKeyboardTypeNumberPad;
    self.newpswTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.newpswTf];

    self.confirmPswTf = [[PswChangeTxetField alloc] initWithFrame:CGRectMake(0, self.newpswTf.bottom, self.oldPswTf.width, self.oldPswTf.height) leftView:confirmPswLabel inset:45];
    self.confirmPswTf.placeholder = @"再输一次新密码";
    [self.confirmPswTf setValue:FONT(15) forKeyPath:@"_placeholderLabel.font"];
    self.confirmPswTf.keyboardType = UIKeyboardTypeNumberPad;
    self.confirmPswTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.confirmPswTf];
    
    FieldBgView *bgView = [[FieldBgView alloc] initWithFrame:CGRectMake(_oldPswTf.left, _oldPswTf.top, _oldPswTf.width, _oldPswTf.height*3) inset:45 count:3];
    [self.view insertSubview:bgView belowSubview:self.oldPswTf];
    
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmBtn.frame = CGRectMake(45, self.confirmPswTf.bottom+40, SCREEN_WIDTH-45*2, HEIGHT_FLATBUTTON);
    [self.confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    [self.confirmBtn addTarget:self action:@selector(onBtnBackTo:) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmBtn setBackgroundColor:kColorBtnColor];
    [self.view addSubview:self.confirmBtn];
    
}

- (void)confogNav
{
    self.navigationItem.title = @"密码修改";
    
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

- (void)onBtnBackTo:(id)sender
{
    if (self.oldPswTf.text.length == 0) {
        [SVProgressHUD showHUDWithImage:nil status:@"请输入您当前密码" duration:2];
        return;
    }
    if (self.newpswTf.text.length == 0) {
        [SVProgressHUD showHUDWithImage:nil status:@"请输入您的新密码" duration:2];
        return;
    }
    
    if (self.confirmPswTf.text.length == 0) {
        [SVProgressHUD showHUDWithImage:nil status:@"请确认您的新密码" duration:2];
        return;
    }
    
    if (![self.confirmPswTf.text isEqualToString:self.newpswTf.text]) {
        [SVProgressHUD showHUDWithImage:nil status:@"密码不一致" duration:2];
        return;
    }
    
    [SVProgressHUD showHUDWithImage:nil status:@"请稍候" duration:-1];
    
    [APIServiceManager ChangePasswordWithSecretKey:[StorageManager getSecretKey] phoneNumber:[StorageManager getAccountNumber] status:@"1" code:@"600" oldPassWord:self.oldPswTf.text newPassword:self.newpswTf.text completionBlock:^(id responObject) {
        
        NSString *flagString = responObject[@"flag"];
        NSString *message = responObject[@"message"];
        if ([flagString isEqualToString:@"100100"]) {
            [SVProgressHUD showHUDWithImage:nil status:@"修改成功" duration:1];
            [StorageManager saveNewPassword:self.newpswTf.text];
           [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showHUDWithImage:nil status:message duration:1.0];
        }
        
    } failureBlock:^(NSError *error) {
        
        [SVProgressHUD showHUDWithImage:nil status:@"修改密码失败" duration:-1];
    }];
    
    
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
