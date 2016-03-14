//
//  ScreenClipViewController.m
//  Udong
//
//  Created by wildyao on 16/1/8.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "ScreenClipViewController.h"
#import "UMSocial.h"

@interface ScreenClipViewController ()

@end

@implementation ScreenClipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self configView];
}

- (void)configNav
{
    self.view.backgroundColor = kColorWhiteColor;
    self.navigationItem.title = @"分享";
    self.navigationController.navigationBar.barTintColor = kColorWhiteColor;
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setFrame:CGRectMake(0, 0, 20, 20)];
    [leftbtn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
}

- (void)configView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 74, self.view.width-80, self.view.height-150)];
    imageView.image = self.ScreenImage;
    [self.view addSubview:imageView];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, imageView.bottom+10, SCREEN_WIDTH, SCREEN_HEIGHT-imageView.bottom-10)];
    self.contentView.backgroundColor = kColorBlackColor;
    self.contentView.alpha = 0.3;
    [self.view addSubview:self.contentView];
    
    UIButton *weichatImageview = [UIButton buttonWithType:UIButtonTypeCustom];
    weichatImageview.tag = 1000;
    [weichatImageview setBackgroundImage:ImageNamed(@"share_icon_wechat") forState:UIControlStateNormal];
    [weichatImageview addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    weichatImageview.frame = CGRectMake(25, self.contentView.top+10, (self.contentView.width/4)-50, (self.contentView.width/4)-50);
    [self.view addSubview:weichatImageview];
    
    UIButton *friendImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    [friendImageView setBackgroundImage:ImageNamed(@"share_icon_moment") forState:UIControlStateNormal];
    friendImageView.tag = 1001;
    [friendImageView addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    friendImageView.frame = CGRectMake(weichatImageview.right+50, weichatImageview.top, weichatImageview.width, weichatImageview.height);
    [self.view addSubview:friendImageView];
    
    UIButton *QQImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    QQImageView.tag = 1002;
    [QQImageView addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    [QQImageView setBackgroundImage:ImageNamed(@"share_icon_qq") forState:UIControlStateNormal];
    QQImageView.frame = CGRectMake(friendImageView.right+50, friendImageView.top, friendImageView.width, friendImageView.height);
    [self.view addSubview:QQImageView];
    
    UIButton *WeiboImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    WeiboImageView.tag = 1003;
    [WeiboImageView addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    [WeiboImageView setBackgroundImage:ImageNamed(@"share_icon_weibo") forState:UIControlStateNormal];
    WeiboImageView.frame = CGRectMake(QQImageView.right+50, friendImageView.top, friendImageView.width, friendImageView.height);
    [self.view addSubview:WeiboImageView];
    
}

- (void)onBtnBack:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)shareBtn:(UIButton *)btn
{
    switch (btn.tag) {
        case 1000:
            [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:nil image:self.ScreenImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
            break;
            
        case 1001:
            [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:nil image:self.ScreenImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
            break;
            
        case 1002:
            [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeImage;
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"优动，让你看到运动效果的App" image:self.ScreenImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
            break;
        default:
            break;
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
