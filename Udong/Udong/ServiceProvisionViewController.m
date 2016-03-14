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
    self.navigationController.navigationBarHidden = NO;
    [self configView];
    
}

- (void)configView
{
    
    [self configBackItem];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.contentSize = CGSizeMake(self.view.width,self.view.height+10);
    scrollView.frame = self.view.frame;
    [self.view addSubview:scrollView];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.frame];
    [webview loadHTMLString:self.provisionString baseURL:nil];
    [scrollView addSubview:webview];
//    UILabel *lab = [[UILabel alloc] initWithFrame:self.view.frame];
//    lab.text = self.provisionString;
//    lab.font = FONT(13);
//    lab.numberOfLines = 0;
//    lab.lineBreakMode = NSLineBreakByWordWrapping;
//    [lab setTextColor:kColorBlackColor];
//    [scrollView addSubview:lab];
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
