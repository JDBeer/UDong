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
    
    
    CGSize Size = [@"适合我的最低运动量" sizeWithAttributes:@{NSFontAttributeName:FONT(14)}];
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.width = Size.width;
    self.titleLabel.height = Size.height;
    self.titleLabel.centerX = self.view.centerX;
    self.titleLabel.top = _interval1;
    self.titleLabel.text = @"适合我的最低运动量";
    self.titleLabel.font = FONT(14);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = kColorBlackColor;
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
    
    CGSize Size1 = [@"有效运动点" sizeWithAttributes:@{NSFontAttributeName:FONT(13)}];
    self.explainLabel = [[UILabel alloc] init];
    self.explainLabel.width = Size1.width;
    self.explainLabel.height = Size1.height;
    self.explainLabel.left = self.pointLabel.right;
    self.explainLabel.bottom = self.pointLabel.bottom-10;
    self.explainLabel.text = @"有效运动点";
    self.explainLabel.font = FONT(13);
    self.explainLabel.textColor = kColorBtnColor;
    [self.view addSubview:self.explainLabel];
    
    self.explainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.explainBtn.frame = CGRectMake(self.explainLabel.right+4, 0, 20, 20);
    self.explainBtn.bottom = self.explainLabel.bottom;
    [self.explainBtn setTitle:@"?" forState:UIControlStateNormal];
    [self.explainBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    self.explainBtn.titleLabel.font = FONT(13);
    [self.explainBtn setBackgroundColor:kColorBtnColor];
    self.explainBtn.layer.cornerRadius = self.explainBtn.height/2;
    self.explainBtn.layer.masksToBounds = YES;
    [self.explainBtn addTarget:self action:@selector(explainViewAppear:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.explainBtn];
    
    self.titleLabelTwo = [[UILabel alloc]initWithFrame:CGRectMake(20, self.pointLabel.bottom+_interval3,self.view.width-40 , 50)];
    self.titleLabelTwo.centerX = self.view.centerX;
    self.titleLabelTwo.numberOfLines = 0;
    self.titleLabelTwo.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabelTwo.text = self.descriptionString;
    CGSize size = [self.titleLabelTwo  sizeThatFits:CGSizeMake(self.titleLabelTwo.frame.size.width, MAXFLOAT)];
    self.titleLabelTwo.frame =CGRectMake(20, self.pointLabel.bottom+_interval3, self.view.width-40 , size.height);
    self.titleLabelTwo.font = [UIFont systemFontOfSize:14];
    self.titleLabelTwo.textColor = kColorContentColor;
    [self.view addSubview:self.titleLabelTwo ];
    
    self.imageView = [[UIImageView alloc] initWithImage:ImageNamed(@"example_main")];
    self.imageView.bounds = CGRectMake(0, 0, self.view.width-40, _imageHeight);
    self.imageView.top = self.titleLabelTwo.bottom+_interval4;
    self.imageView.centerX = self.view.centerX;
    [self.view addSubview:self.imageView];
    
    self.beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.beginBtn.frame = CGRectMake(0, SCREEN_HEIGHT-HEIGHT_FLATBUTTON, SCREEN_WIDTH, HEIGHT_FLATBUTTON);
    [self.beginBtn setBackgroundColor:kColorBtnColor];
    [self.beginBtn setTitle:@"开始运动" forState:UIControlStateNormal];
    [self.beginBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    [self.beginBtn addTarget:self action:@selector(ToMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.beginBtn];
    
    
    

}

- (void)ToMainView:(id)sender
{
    MasterTabBarViewController *MasterVC = [[MasterTabBarViewController alloc] init];
    [self.navigationController pushViewController:MasterVC animated:YES];
}

- (void)explainViewAppear:(id)sender
{
    
}

- (void)configNumber
{
    if (IS_IPONE_4_OR_LESS) {
        _scale = 480.0/667;
        _interval1 = 56;
        _interval2 = 68;
        _interval3 = 45;
        _interval4 = 25;
        _pointLabelHeight = 36;
        _imageHeight = 90;
        
    }else if (IS_IPHONE_5){
        _scale = 568.0/667;
        _interval1 = _scale*66;
        _interval2 = _scale*108;
        _interval3 = _scale*75;
        _interval4 = _scale*45;
        _pointLabelHeight = _scale*56;
        _imageHeight = _scale*150;
       
    }else if (IS_IPHONE_6){
        _scale = 1;
        _interval1 = 66;
        _interval2 = 108;
        _interval3 = 75;
        _interval4 = 45;
        _pointLabelHeight = 90;
        _imageHeight = 150;
        
    }else if (IS_IPHONE_6P){
        _scale = 736/667;
        _interval1 = _scale*66;
        _interval2 = _scale*108;
        _interval3 = _scale*75;
        _interval4 = _scale*45;
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
