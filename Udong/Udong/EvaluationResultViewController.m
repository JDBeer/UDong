//
//  EvaluationResultViewController.m
//  Udong
//
//  Created by wildyao on 15/12/9.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "EvaluationResultViewController.h"
#import "MasterTabBarViewController.h"

@interface EvaluationResultViewController ()
@property (nonatomic, assign) double scale;
@property (nonatomic, assign) double interval1;
@property (nonatomic, assign) double interval2;
@property (nonatomic, assign) double interval3;
@property (nonatomic, assign) double interval4;
@property (nonatomic, assign) double interval5;
@property (nonatomic, assign) double interval6;
@property (nonatomic, assign) double pointLabelHeight;
@property (nonatomic, assign) double imageHeight;

@end

@implementation EvaluationResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNumber];
    [self configView];
}

- (void)configView
{
    self.view.backgroundColor = kColorWhiteColor;
    
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(10, 35, 23, 23);
    [self.backBtn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
    
    CGSize Size = [@"我的有效运动目标" sizeWithAttributes:@{NSFontAttributeName:FONT(18)}];
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.width = Size.width;
    self.titleLabel.height = Size.height;
    self.titleLabel.centerX = self.view.centerX;
    self.titleLabel.top = _interval1;
    self.titleLabel.text = @"我的有效运动目标";
    self.titleLabel.font = FONT(18);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = UIColorFromHex(0x666666);
    [self.view addSubview:self.titleLabel];
    
    
    NSString *pointLabelString = [NSString stringWithFormat:@"%@",self.pointLabelNumber];
    CGSize Size2 = [pointLabelString sizeWithAttributes:@{NSFontAttributeName:FONT_BOLD(60)}];
    self.pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom+_interval2, Size2.width, Size2.height)];
    self.pointLabel.centerX = self.view.centerX;
    self.pointLabel.textAlignment = NSTextAlignmentCenter;
    self.pointLabel.text = pointLabelString;
    self.pointLabel.font = FONT_BOLD(60);
    self.pointLabel.textColor = kColorBtnColor;
    [self.view addSubview:self.pointLabel];
    
    CGSize Size1 = [@"点" sizeWithAttributes:@{NSFontAttributeName:FONT(13)}];
    self.explainLabel = [[UILabel alloc] init];
    self.explainLabel.width = Size1.width;
    self.explainLabel.height = Size1.height;
    self.explainLabel.left = self.pointLabel.right;
    self.explainLabel.bottom = self.pointLabel.bottom-10;
    self.explainLabel.text = @"点";
    self.explainLabel.font = FONT(13);
    self.explainLabel.textColor = UIColorFromHex(0x666666);
    [self.view addSubview:self.explainLabel];
    
    self.titleLabelTwo = [[UILabel alloc]initWithFrame:CGRectMake(55, self.pointLabel.bottom+_interval3,self.view.width-75 , 50)];
    self.titleLabelTwo.centerX = self.view.centerX;
    self.titleLabelTwo.numberOfLines = 0;
    self.titleLabelTwo.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabelTwo.text = self.descriptionString;
    CGSize size = [self.titleLabelTwo  sizeThatFits:CGSizeMake(self.titleLabelTwo.frame.size.width, MAXFLOAT)];
    self.titleLabelTwo.frame =CGRectMake(55, self.pointLabel.bottom+_interval3, self.view.width-75 , size.height);
    self.titleLabelTwo.font = [UIFont systemFontOfSize:14];
    self.titleLabelTwo.textColor = kColorContentColor;
    [self.view addSubview:self.titleLabelTwo];
    
    self.imageView1 = [[UIImageView alloc] initWithImage:ImageNamed(@"icon_bulb")];
    self.imageView1.top = self.titleLabelTwo.top+5;
    self.imageView1.right = self.titleLabelTwo.left-10;
    self.imageView1.width = self.imageView1.height = 20;
    [self.view addSubview:self.imageView1];
    
    
    self.effectResultView = [[EffectResultView alloc] initWithFrame:CGRectMake(0, self.titleLabelTwo.bottom+_interval4, SCREEN_WIDTH, _imageHeight)];
    [self.view addSubview:self.effectResultView];
    
    
    self.beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.beginBtn.frame = CGRectMake(45, SCREEN_HEIGHT-_interval6-HEIGHT_FLATBUTTON, SCREEN_WIDTH-90, HEIGHT_FLATBUTTON);
    [self.beginBtn setBackgroundColor:UIColorFromHex(0x21BEC9)];
    [self.beginBtn setTitle:@"开始运动" forState:UIControlStateNormal];
    [self.beginBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    self.beginBtn.layer.cornerRadius = HEIGHT_FLATBUTTON/2;
    self.beginBtn.layer.masksToBounds = YES;
    [self.beginBtn addTarget:self action:@selector(ToMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.beginBtn];
    
    
    

}

- (void)ToMainView:(id)sender
{
    MasterTabBarViewController *MasterVC = [[MasterTabBarViewController alloc] init];
    [self.navigationController pushViewController:MasterVC animated:YES];
}

- (void)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configNumber
{
    if (IS_IPONE_4_OR_LESS) {
        _scale = 480.0/667;
        _interval1 = 50;
        _interval2 = 20;
        _interval3 = 20;
        _interval4 = 25;
        _interval5 = 40;
        _interval6 = 50;
        _pointLabelHeight = 36;
        _imageHeight = 90;
        
    }else if (IS_IPHONE_5){
        _scale = 568.0/667;
        _interval1 = _scale*60;
        _interval2 = 30;
        _interval3 = 30;
        _interval4 = 40;
        _interval5 =_scale* 59;
        _interval6 = _scale*65;
        _pointLabelHeight = _scale*56;
        _imageHeight = _scale*150;
       
    }else if (IS_IPHONE_6){
        _scale = 1;
        _interval1 = 60;
        _interval2 = 75;
        _interval3 = 63;
        _interval4 = 45;
        _interval5 = 59;
        _interval6 = 73;
        _pointLabelHeight = 90;
        _imageHeight = 150;
        
    }else if (IS_IPHONE_6P){
        _scale = 736/667;
        _interval1 = _scale*75;
        _interval2 = _scale*75;
        _interval3 = _scale*63;
        _interval4 = _scale*45;
        _interval5 =_scale* 59;
        _interval6 = _scale*73;
        _pointLabelHeight = _scale*56;
        _imageHeight = _scale*150;
       
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
