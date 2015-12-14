//
//  ServiceProvisionViewController.m
//  Udong
//
//  Created by wildyao on 15/11/15.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "ServiceProvisionViewController.h"
#import "LoginViewController.h"

@interface ServiceProvisionViewController ()

@end

@implementation ServiceProvisionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorWhiteColor;
    [self configView];
    
}

- (void)configView
{
    
    [self configBackItem];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 200, 0)];
    lab.text = @"服务条款";
    lab.font = FONT(18);
    [lab setTextColor:kColorGrayColor];
    [lab sizeToFit];
    [self.view addSubview:lab];
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
