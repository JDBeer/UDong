//
//  AboutUdongViewController.m
//  Udong
//
//  Created by wildyao on 15/11/30.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "AboutUdongViewController.h"

@interface AboutUdongViewController ()

@end

@implementation AboutUdongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self configView];
}

- (void)configNav
{
    self.navigationItem.title = @"关于我们";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 20, 20)];
    [btn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)configView
{
    self.view.backgroundColor = kColorWhiteColor;
    
    UIImageView *logoImage = [[UIImageView alloc] initWithImage:ImageNamed(@"about_logo")];
    logoImage.centerX = self.view.centerX;
    logoImage.top = self.view.top+56;
    [self.view addSubview:logoImage];
    
    UILabel *logolabel = [[UILabel alloc] init];
    logolabel.text = @"优动Version1.0";
    logolabel.textColor = kColorContentColor;
    logolabel.font = FONT(16);
    [logolabel sizeToFit];
    logolabel.centerX = self.view.centerX;
    logolabel.top = logoImage.bottom+20;
    [self.view addSubview:logolabel];
    
    UILabel *anotherLabel = [[UILabel alloc] init];
    anotherLabel.text = @"©2015 hzzkkj.com.All right reserved";
    anotherLabel.textColor = kColorContentColor;
    anotherLabel.font = FONT(14);
    [anotherLabel sizeToFit];
    anotherLabel.centerX = self.view.centerX;
    anotherLabel.bottom = self.view.bottom-80;
    [self.view addSubview:anotherLabel];
    

    UILabel *companyLabel = [[UILabel alloc] init];
    companyLabel.text = @"杭州掌康科技有限公司";
    companyLabel.textColor = kColorContentColor;
    companyLabel.font = FONT(14);
    [companyLabel sizeToFit];
    companyLabel.centerX = self.view.centerX;
    companyLabel.bottom = anotherLabel.top-10;
    [self.view addSubview:companyLabel];
    
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
