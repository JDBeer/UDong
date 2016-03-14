//
//  NoNetWorkViewController.m
//  Udong
//
//  Created by wildyao on 16/2/2.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "NoNetWorkViewController.h"
#import "MyInformationViewController.h"
#import "AccountmanagerViewController.h"
#import "FeedbackViewController.h"
#import "AnalysisViewController.h"
#import "MineViewController.h"

@interface NoNetWorkViewController ()

@end

@implementation NoNetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.titleLabel isEqualToString:@"分析"]) {
        
    }else{
        [self configNav];
    }
    
    float height;
    if (IS_IPONE_4_OR_LESS) {
        height = 100;
    }else if (IS_IPHONE_5){
        height = 150;
    }else{
        height = 200;
    }
    
    self.view.backgroundColor = kColorWhiteColor;
   
    self.netImageView = [[UIImageView alloc] initWithImage:ImageNamed(@"icon_nowifi")];
    self.netImageView.frame = CGRectMake(0, height, 30, 30);
    self.netImageView.centerX = self.view.centerX;
    [self.view addSubview:self.netImageView];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.netImageView.bottom+40, 200, 30)];
    self.label.centerX = self.netImageView.centerX;
    self.label.textColor = kColorContentColor;
    self.label.font = FONT(16);
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text = @"亲，你的手机网络不稳定哦!";
    [self.view addSubview:self.label];
    
    self.reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reloadBtn.frame = CGRectMake(0, self.label.bottom+20, 150, 40);
    self.reloadBtn.centerX = self.netImageView.centerX;
    self.reloadBtn.layer.cornerRadius = self.reloadBtn.height/2;
    self.reloadBtn.layer.masksToBounds = YES;
    self.reloadBtn.backgroundColor = kColorClearColor;
    self.reloadBtn.layer.borderColor = kColorCellSeparator.CGColor;
    self.reloadBtn.layer.borderWidth = 1;
    
    [self.reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
    [self.reloadBtn setTitleColor:kColorContentColor forState:UIControlStateNormal];
    [self.reloadBtn addTarget:self action:@selector(reloadaaa:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.reloadBtn];
    
}

- (void)reloadaaa:(id)sender
{
    
    if ([self.titleLabel isEqualToString:@"消息中心"]) {
        MyInformationViewController *MyInfoVC = [[MyInformationViewController alloc] init];
        [self addChildViewController:MyInfoVC];
        [self.view addSubview:MyInfoVC.view];
    }
    
    if ([self.titleLabel isEqualToString:@"帐号管理"]) {
         AccountmanagerViewController *accountVC = [[AccountmanagerViewController alloc] init];
        [self addChildViewController:accountVC];
        [self.view addSubview:accountVC.view];
    }
    
    if ([self.titleLabel isEqualToString:@"意见反馈"]) {
        FeedbackViewController *feedVC = [[FeedbackViewController alloc] init];
        [self addChildViewController:feedVC];
        [self.view addSubview:feedVC.view];
    }
    
    if ([self.titleLabel isEqualToString:@"分析"]) {
        AnalysisViewController *analysisVC = [[AnalysisViewController alloc] init];
        [self addChildViewController:analysisVC];
        analysisVC.navigationController.navigationBarHidden = NO;
        [self.view addSubview:analysisVC.view];
    }
    
    if ([self.titleLabel isEqualToString:@"我的"]) {
        MineViewController *mineVC = [[MineViewController alloc] init];
        [self addChildViewController:mineVC];
        mineVC.navigationController.navigationBarHidden = NO;
        [self.view addSubview:mineVC.view];
    }
    
    
}

- (void)configNav
{
    self.view.backgroundColor = kColorWhiteColor;
    
    self.navigationItem.title = self.titleLabel;
    self.navigationController.navigationBar.shadowImage = nil;
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSFontAttributeName : FONT(18),
                                                                    
                                                                    UITextAttributeTextColor : kColorBlackColor,
                                                                    UITextAttributeTextShadowColor : kColorClearColor,
                                                                    };
    
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
