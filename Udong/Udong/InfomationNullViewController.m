//
//  InfomationNullViewController.m
//  Udong
//
//  Created by wildyao on 15/12/8.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "InfomationNullViewController.h"

@interface InfomationNullViewController ()
@property (nonatomic, assign) double scale;
@property (nonatomic, assign) double interval1;
@property (nonatomic, assign) double interval2;
@property (nonatomic, assign) double imageHeight;


@end

@implementation InfomationNullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNumber];
    [self configNav];
    [self configView];
}

- (void)configNav
{
    self.navigationItem.title = @"消息";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 20, 20)];
    [btn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)configView
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _interval1, 100, _imageHeight)];
    self.imageView.centerX = self.view.centerX;
    self.imageView.image = ImageNamed(@"icon_message_big");
    [self.view addSubview:self.imageView];
    
    CGSize Size = [@"空空如也，您还未收到消息哦~" sizeWithAttributes:@{NSFontAttributeName:FONT(15)}];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imageView.bottom+_interval2, Size.width, Size.height)];
    self.label.centerX = self.view.centerX;
    self.label.text = @"空空如也，您还未收到消息哦~";
    self.label.font = FONT(15);
    self.label.textColor = kColorGrayColor;
    [self.view addSubview:self.label];
}

- (void)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configNumber
{
    if (IS_IPONE_4_OR_LESS) {
        _scale = 480.0/667;
        _interval1 = 90;
        _interval2 = 20;
        _imageHeight = 40;
        
    }else if (IS_IPHONE_5){
        _scale = 568.0/667;
        _interval1 = 170*_scale;
        _interval2 = 40*_scale;
        _imageHeight = 80*_scale;
        
    }else if (IS_IPHONE_6){
        _scale = 1;
        _interval1 = 170;
        _interval2 = 40;
        _imageHeight = 80;
        
    }else if (IS_IPHONE_6P){
        _scale = 736/667;
        _interval1 = 170*_interval1;
        _interval2 = 40*_interval2;
        _imageHeight = 80*_scale;
        
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
