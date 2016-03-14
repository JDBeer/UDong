//
//  MeasuremenViewController.m
//  Udong
//
//  Created by wildyao on 15/12/2.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "MeasuremenViewController.h"
#import "MeasurementAgeViewController.h"

@interface MeasuremenViewController ()

@property (nonatomic, assign) double scale;
@property (nonatomic, assign) double interval1;
@property (nonatomic, assign) double interval2;
@property (nonatomic, assign) double interval3;
@property (nonatomic, assign) double interval4;
@property (nonatomic, assign) double interval5;
@property (nonatomic, assign) double interval6;
@property (nonatomic, assign) double interval7;
@property (nonatomic, assign) double imageHeight;
@property (nonatomic, assign) double buttonHeight;

@end

@implementation MeasuremenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNumber];
    [self configView];
    
}

- (void)configView
{
    
    self.view.backgroundColor = kColorWhiteColor;
    self.navigationController.navigationBarHidden = YES;
    self.stepImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.left+30, self.interval1+25, self.view.right-2*30, 25)];
    self.stepImageView.image = ImageNamed(@"progress-bar_1");
    [self.view addSubview:self.stepImageView];

    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(10, 35, 23, 23);
    [self.backBtn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(OnBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
    
    
    CGSize Size1 = [@"以下将根据您的体质评估" sizeWithAttributes:@{NSFontAttributeName:FONT(17)}];
    self.label1 = [[UILabel alloc] init];
    self.label1.text = @"以下将根据您的体质评估";
    self.label1.font = FONT(17);
    self.label1.textColor = kColorBlackColor;
    self.label1.top = self.stepImageView.bottom+_interval2;
    self.label1.width = Size1.width;
    self.label1.height = Size1.height;
    self.label1.centerX = self.stepImageView.centerX;
    [self.view addSubview:self.label1];
    
    CGSize size2 = [@"为您推荐合适的有效运动量" sizeWithAttributes:@{NSFontAttributeName:FONT(17)}];
    self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(self.label1.centerX, self.label1.bottom+_interval3, size2.width, size2.height)];
    self.label2.numberOfLines = 0;
    self.label2.lineBreakMode = NSLineBreakByWordWrapping;
    self.label2.text = @"为您推荐合适的有效运动量";
    self.label2.font =  FONT(17);
    self.label2.textColor = kColorBlackColor;
    CGSize size = [self.label2 sizeThatFits:CGSizeMake(self.label2.frame.size.width, MAXFLOAT)];
    self.label2.frame =CGRectMake(self.label1.centerX-(self.label2.width)/2, self.label1.bottom+_interval3, size2.width, size.height);
    
    [self.view addSubview:self.label2];

    
    CGSize size3 = [@"性别" sizeWithAttributes:@{NSFontAttributeName:FONT(22)}];
    self.sexLabel = [[UILabel alloc] init];
    self.sexLabel.text = @"性别";
    self.sexLabel.font = FONT(22);
    self.sexLabel.textColor = UIColorFromHexWithAlpha(0x999999,1);
    self.sexLabel.top = self.label2.bottom+_interval4;
    self.sexLabel.width = size3.width;
    self.sexLabel.height = size3.height;
    self.sexLabel.centerX = self.stepImageView.centerX;
    [self.view addSubview:self.sexLabel];
    
    
    self.manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.manBtn.tag = 1;
    self.manBtn.frame = CGRectMake(self.view.centerX-90, self.sexLabel.bottom+_interval5, 60, 60);
    [self.manBtn setBackgroundImage:[UIImage imageNamed:@"avatar_gender_boy"] forState:UIControlStateNormal];
    [self.manBtn setBackgroundImage:[UIImage imageNamed:@"avatar_gender_boy_chosed"] forState:UIControlStateSelected];
    [self.manBtn addTarget:self action:@selector(Press:) forControlEvents:UIControlEventTouchUpInside];
    self.manBtn.selected = YES;
    [self.view addSubview:self.manBtn];
    
    
    self.womenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.womenBtn.tag = 2;
    self.womenBtn.frame = CGRectMake(self.view.centerX+40, self.sexLabel.bottom+_interval5, 60, 60);
    [self.womenBtn setBackgroundImage:ImageNamed(@"avatar_gender_girl") forState:UIControlStateNormal];
    [self.womenBtn setBackgroundImage:ImageNamed(@"avatar_gender_girl_chosed") forState:UIControlStateSelected];
    [self.womenBtn addTarget:self action:@selector(Press:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.womenBtn];

    self.NextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.NextBtn.bottom = self.view.bottom-_interval7;
    self.NextBtn.width = 160;
    self.NextBtn.height = _buttonHeight;
    self.NextBtn.centerX = self.view.centerX;
    [self.NextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.NextBtn setTitleColor:kColorBtnColor forState:UIControlStateNormal];
    [self.NextBtn addTarget:self action:@selector(ToNext:) forControlEvents:UIControlEventTouchUpInside];
    self.NextBtn.layer.borderWidth = 0.5;
    self.NextBtn.layer.borderColor = kColorBtnColor.CGColor;
    self.NextBtn.layer.cornerRadius = self.NextBtn.height/2;
    self.NextBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.NextBtn];
    
}

- (void)Press:(id)sender
{
    UIButton *btn = sender;
    
    if (btn.tag == 1) {
        btn.selected = !btn.selected;
        self.womenBtn.selected = !btn.selected;
    }else{
        btn.selected = !btn.selected;
        self.manBtn.selected = !btn.selected;
    }
    if (btn.selected == YES) {
        if (btn.tag == 1) {
            [StorageManager saveSex:@"M"];
        }else
        {
            [StorageManager saveSex:@"F"];
        }
    }
}

- (void)OnBtnBack:(id)sender
{
    if (self.sign == 111) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)ToNext:(id)sender
{
    
    if ([StorageManager getSex] == nil) {
        [StorageManager saveSex:@"M"];
    }
    
    MeasurementAgeViewController *meaAgeVC = [[MeasurementAgeViewController alloc] init];
    
    [self.navigationController pushViewController:meaAgeVC animated:NO];
}

- (void)configNumber
{
    if (IS_IPONE_4_OR_LESS) {
        _interval1 = 50;
        _interval2 = 20;
        _interval3 = 10;
        _interval4 = 25;
        _interval5 = 40;
        _interval6 = 4;
        _interval7 = 70;
        _imageHeight = 60;
        _buttonHeight = 30;
    }else if (IS_IPHONE_5){
        _scale = 568.0/667;
        _interval1 = 58*_scale;
        _interval2 = 30*_scale;
        _interval3 = 21*_scale;
        _interval4 = 50*_scale;
        _interval5 = 80*_scale;
        _interval6 = 7*_scale;
        _interval7 = 100*_scale;
        _imageHeight = 88*_scale;
        _buttonHeight = 45*_scale;
    }else if (IS_IPHONE_6){
        _scale = 1;
        _interval1 = 58;
        _interval2 = 30;
        _interval3 = 21;
        _interval4 = 70;
        _interval5 = 80;
        _interval6 = 7;
        _interval7 = 100;
        _imageHeight = 88;
        _buttonHeight = 45;
    }else if (IS_IPHONE_6P){
        _scale = 736/667;
        _interval1 = 58*_scale;
        _interval2 = 30*_scale;
        _interval3 = 21*_scale;
        _interval4 = 50*_scale;
        _interval5 = 80*_scale;
        _interval6 = 7*_scale;
        _interval7 = 100*_scale;
        _imageHeight = 88*_scale;
        _buttonHeight = 45*_scale;
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
