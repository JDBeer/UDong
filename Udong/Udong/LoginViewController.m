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

#define INTERVAL 15
#define INTERVAL_MIDDLE 10

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UITextField *accountField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *forgetBtn;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"登录";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
    
}

- (void)configView
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(onBtnRegister)];
    self.navigationItem.rightBarButtonItem.tintColor = kColorBlackColor;
    
    
    self.scrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollview];
    
    self.accountField = [[YYTextField alloc] initWithFrame:CGRectMake(0, MARGIN_TOP, SCREEN_WIDTH, 44) leftView:nil inset:15];
    self.accountField.delegate = self;
    self.accountField.borderStyle = UITextBorderStyleNone;
    self.accountField.placeholder = @"请输入您的手机号";
    self.accountField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.accountField.returnKeyType = UIReturnKeyNext;
    self.accountField.keyboardType = UIKeyboardTypeNumberPad;
    [self.scrollview addSubview:self.accountField];
    
    self.passwordField = [[YYTextField alloc] initWithFrame:CGRectMake(0, self.accountField.bottom, SCREEN_WIDTH, 44) leftView:nil inset:15];
    self.passwordField.delegate = self;
    self.passwordField.borderStyle = UITextBorderStyleNone;
    self.passwordField.placeholder = @"请输入您的密码";
    self.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordField.returnKeyType = UIReturnKeyDone;
    self.passwordField.secureTextEntry = YES;
    [self.scrollview addSubview:self.passwordField];
    
    FieldBgView *bg = [[FieldBgView alloc] initWithFrame:CGRectMake(_accountField.left, _accountField.top, _accountField.width, _accountField.height*2) inset:15 count:2];
    [self.scrollview insertSubview:bg belowSubview:self.accountField];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(15, self.passwordField.bottom+INTERVAL,self.view.width-2*15, HEIGHT_FLATBUTTON);
    [self.loginBtn setBackgroundColor:kColorGrayColor];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:kColorBlackColor forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = FONT(15);
    
    self.loginBtn.layer.cornerRadius = HEIGHT_FLATBUTTON/2;
    
    [self.scrollview addSubview:self.loginBtn];
    
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyBoard:)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)onBtnRegister
{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)dissmissKeyBoard:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
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
