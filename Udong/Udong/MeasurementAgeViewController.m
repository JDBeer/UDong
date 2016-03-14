//
//  MeasurementAgeViewController.m
//  Udong
//
//  Created by wildyao on 15/12/3.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "MeasurementAgeViewController.h"
#import "MeasurementHeightViewController.h"
#import "RulerView.h"
#define RuleAgeInterval 70

@interface MeasurementAgeViewController ()<UIScrollViewDelegate>
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
@property (nonatomic, assign) double beginInter;

@property (nonatomic,assign) NSInteger age;

@end

@implementation MeasurementAgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNumber];
    [self configData];
    [self configView];
    
}

- (void)configView
{
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(10, 35, 23, 23);
    [self.backBtn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(OnBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
    
    self.view.backgroundColor = kColorWhiteColor;
    self.stepImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.left+30, self.interval1+25, self.view.right-2*30, 25)];
    self.stepImageView.image = ImageNamed(@"progress-bar_2");
    [self.view addSubview:self.stepImageView];
    
    
    CGSize Size1 = [@"不同年龄的代谢差异" sizeWithAttributes:@{NSFontAttributeName:FONT(17)}];
    self.label1 = [[UILabel alloc] init];
    self.label1.text = @"不同年龄的代谢差异";
    self.label1.font = FONT(17);
    self.label1.textColor = kColorBlackColor;
    self.label1.top = self.stepImageView.bottom+_interval2;
    self.label1.width = Size1.width;
    self.label1.height = Size1.height;
    self.label1.centerX = self.stepImageView.centerX;
    [self.view addSubview:self.label1];
    
    CGSize size2 = [@"将影响您所需的有效运动量" sizeWithAttributes:@{NSFontAttributeName:FONT(17)}];
    self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(self.label1.centerX, self.label1.bottom+_interval3, size2.width, size2.height)];
    self.label2.numberOfLines = 0;
    self.label2.lineBreakMode = NSLineBreakByWordWrapping;
    self.label2.text = @"将影响您所需的有效运动量";
    self.label2.font =  FONT(17);
    self.label2.textColor = kColorBlackColor;
    CGSize size = [self.label2 sizeThatFits:CGSizeMake(self.label2.frame.size.width, MAXFLOAT)];
    self.label2.frame =CGRectMake(self.label1.centerX-(self.label2.width)/2, self.label1.bottom+_interval3, size2.width, size.height);
    
    [self.view addSubview:self.label2];
    
    
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.top = self.label2.bottom+_interval4-25;
    self.numberLabel.width = 40;
    self.numberLabel.height = 40;
    self.numberLabel.centerX = self.view.centerX;
    self.numberLabel.font = FONT_BOLD(25);
    self.numberLabel.textColor = kColorBlackColor;
    [self.view addSubview:self.numberLabel];
    
    self.hidenLabel = [[UILabel alloc] init];
    self.hidenLabel.top = self.label2.bottom+_interval4-25;
    self.hidenLabel.width = 40;
    self.hidenLabel.height = 40;
    self.hidenLabel.text = @"35";
    self.hidenLabel.centerX = self.view.centerX;
    self.hidenLabel.font = FONT_BOLD(25);
    self.hidenLabel.textColor = kColorBlackColor;
    [self.view addSubview:self.hidenLabel];

    
    self.ageLabel = [[UILabel alloc] init];
    self.ageLabel.width = 40;
    self.ageLabel.height = 40;
    self.ageLabel.centerY = self.numberLabel.centerY;
    self.ageLabel.right = self.numberLabel.left-20;
    self.ageLabel.text = @"年龄";
    self.ageLabel.textColor = UIColorFromHexWithAlpha(0x999999,1);
    self.ageLabel.font = FONT(15);
    [self.view addSubview:self.ageLabel];
    
    self.suilabel = [[UILabel alloc] init];
    self.suilabel.width = 40;
    self.suilabel.height = 40;
    self.suilabel.centerY = self.numberLabel.centerY;
    self.suilabel.left = self.numberLabel.right+20;
    self.suilabel.text = @"岁";
    self.suilabel.textColor = UIColorFromHexWithAlpha(0x999999,1);
    self.suilabel.font = FONT(15);
    [self.view addSubview:self.suilabel];

    self.pointImageView = [[UIImageView alloc] init];
    self.pointImageView.width = 20;
    self.pointImageView.height = 25;
    self.pointImageView.centerX = self.view.centerX-5;
    self.pointImageView.top = self.numberLabel.bottom+_interval5;
    self.pointImageView.image = ImageNamed(@"icon_indicator");
    [self.view addSubview:self.pointImageView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.pointImageView.bottom+_interval6, self.view.width, _imageHeight)];
    self.scrollView.backgroundColor = UIColorFromHexWithAlpha(0xEBEBEB,1);
    self.scrollView.contentSize = CGSizeMake(63*RuleAgeInterval, self.scrollView.contentSize.height);
    
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    RulerView *rulerView = [[RulerView alloc] initWithFrame:CGRectMake(0,0, self.scrollView.contentSize.width, self.scrollView.size.height) width:self.scrollView.contentSize.width length:self.scrollView.size.height count:62+1 interval:RuleAgeInterval dataArray:self.dataArray];
    
    [self.scrollView addSubview:rulerView];
    
    self.scrollView.contentOffset = CGPointMake(35*RuleAgeInterval+SCREEN_WIDTH/2+_beginInter,0);
    
//    CALayer *layer = [CALayer layer];
//    layer.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6].CGColor;
//    layer.frame = CGRectMake(0, 0, 70, self.scrollView.size.height);
//    [rulerView.layer addSublayer:layer];
//
//    CALayer *layer1 = [CALayer layer];
//    layer1.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6].CGColor;
//    layer1.frame = CGRectMake(self.view.width-70, 0, 70, self.scrollView.size.height);
//    [rulerView.layer addSublayer:layer1];
    
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.width = 140;
    self.leftBtn.height = _buttonHeight;
    self.leftBtn.right = self.view.centerX-20;
    self.leftBtn.bottom = self.view.bottom-_interval7;
    [self.leftBtn setTitle:@"上一步" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:kColorBtnColor forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(OnBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.layer.borderWidth = 0.5;
    self.leftBtn.layer.borderColor = kColorBtnColor.CGColor;
    self.leftBtn.layer.cornerRadius = self.leftBtn.height/2;
    self.leftBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.leftBtn];

    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.width = 140;
    self.rightBtn.height = _buttonHeight;
    self.rightBtn.left = self.view.centerX+20;
    self.rightBtn.bottom = self.leftBtn.bottom;
    [self.rightBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:kColorBtnColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(OnBtnToNext:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.layer.borderWidth = 0.5;
    self.rightBtn.layer.borderColor = kColorBtnColor.CGColor;
    self.rightBtn.layer.cornerRadius = self.rightBtn.height/2;
    self.rightBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.rightBtn];
    
    
}

- (void)OnBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)OnBtnToNext:(id)sender
{
    if (self.scrollView.contentOffset.x == 0) {
        NSInteger year = 2015-35;
        NSString *yeraString = [NSString stringWithFormat:@"%ld",year];
        NSString *string = [NSString stringWithFormat:@"%@0101080000",yeraString];
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
        NSDate* inputDate = [inputFormatter dateFromString:string];
        //时间戳的值
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[inputDate timeIntervalSince1970]];
        [StorageManager saveAge:timeSp];

    }else{
        
        if (_age == 0) {
            NSInteger year = 2015-35;
            NSString *yeraString = [NSString stringWithFormat:@"%ld",year];
            NSString *string = [NSString stringWithFormat:@"%@0101080000",yeraString];
            NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
            [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
            [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
            NSDate* inputDate = (NSDate *)[inputFormatter dateFromString:string];
            NSDate *date = [inputDate dateByAddingTimeInterval:-8*3600];
            
            //时间戳的值
            NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
            
            [StorageManager saveAge:timeSp];
        }else{
            
            NSInteger year = 2015-_age;
            NSString *yeraString = [NSString stringWithFormat:@"%ld",year];
            NSString *string = [NSString stringWithFormat:@"%@0101080000",yeraString];
            NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
            [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
            [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
            NSDate * inputDate =[inputFormatter dateFromString:string];
            NSDate *date = [inputDate dateByAddingTimeInterval:-8*3600];
            //时间戳的值
            NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
            
            [StorageManager saveAge:timeSp];
        }
    }

    MeasurementHeightViewController *meaHeightVC = [[MeasurementHeightViewController alloc] init];
    [self.navigationController pushViewController:meaHeightVC animated:NO];
}

- (void)configData
{
    _dataArray = [[NSMutableArray alloc] init];
    for (int i=0; i<62; i++) {
        NSString *dataString = [NSString stringWithFormat:@"%d",i+1940];
        [_dataArray addObject:dataString];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    float scale = ((scrollView.contentOffset.x+(SCREEN_WIDTH/2))/RuleAgeInterval);
    if (scale>=10) {
        NSString *string = [NSString stringWithFormat:@"%f",scale];
        NSString *secondString = [NSString stringWithFormat:@"%0.2f",scale];
        NSString *thirdString = [secondString substringFromIndex:3];
        if ([thirdString integerValue]<=57) {
            NSString *ageString = [string substringToIndex:2];
            NSInteger age = 76-[ageString integerValue];
            _age = age;
        }else{
            NSString *ageString = [string substringToIndex:2];
            NSInteger age =75-[ageString integerValue];
            _age = age;
        }
//        NSLog(@"%@--%@",string,thirdString);
    }else{
        NSString *string = [NSString stringWithFormat:@"%f",scale];
        NSString *secondString = [NSString stringWithFormat:@"%0.2f",scale];
        NSString *thirdString = [secondString substringFromIndex:2];
        if ([thirdString integerValue]<=57) {
            NSString *ageString = [string substringToIndex:2];
            NSInteger age = 76-[ageString integerValue];
            _age = age;
        }else{
            NSString *ageString = [string substringToIndex:2];
            NSInteger age = 75-[ageString integerValue];
            _age = age;
        }
//        NSLog(@"%@--%@",string,thirdString);

        
    }
    self.hidenLabel.hidden = YES;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)_age];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float scale = ((scrollView.contentOffset.x+(SCREEN_WIDTH/2))/RuleAgeInterval);
    if (scale>=10) {
        NSString *string = [NSString stringWithFormat:@"%f",scale];
        NSString *secondString = [NSString stringWithFormat:@"%0.2f",scale];
        NSString *thirdString = [secondString substringFromIndex:3];
        if ([thirdString integerValue]<=57) {

            NSString *ageString = [string substringToIndex:2];
            NSInteger age = 76-[ageString integerValue];
            _age = age;
            
//            NSString *subString = [string substringFromIndex:3];
//            scrollView.contentOffset.x-=[subString floatValue]*RuleAgeInterval;
            
        }else{
            NSString *ageString = [string substringToIndex:2];
            NSInteger age = 75-[ageString integerValue];
            _age = age;
        }
//        NSLog(@"%@--%@",string,thirdString);
    }else{
        NSString *string = [NSString stringWithFormat:@"%f",scale];
        NSString *secondString = [NSString stringWithFormat:@"%0.2f",scale];
        NSString *thirdString = [secondString substringFromIndex:2];
        if ([thirdString integerValue]<=57) {
            NSString *ageString = [string substringToIndex:2];
            NSInteger age = 76-[ageString integerValue];
            _age = age;
        }else{
            NSString *ageString = [string substringToIndex:2];
            NSInteger age = 75-[ageString integerValue];
            _age = age;
        }
//        NSLog(@"%@--%@",string,thirdString);
        
        
    }
    self.hidenLabel.hidden = YES;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)_age];
}

- (void)configNumber
{
    if (IS_IPONE_4_OR_LESS) {
        _interval1 = 50;
        _interval2 = 20;
        _interval3 = 10;
        _interval4 = 40;
        _interval5 = 10;
        _interval6 = 4;
        _interval7 = 40;
        _imageHeight = 70;
        _buttonHeight = 30;
    }else if (IS_IPHONE_5){
        _scale = 568.0/667;
        _interval1 = 58*_scale;
        _interval2 = 30*_scale;
        _interval3 = 21*_scale;
        _interval4 = 94*_scale;
        _interval5 = 22*_scale;
        _interval6 = 7*_scale;
        _interval7 = 72*_scale;
        _imageHeight = 88*_scale;
        _buttonHeight = 45*_scale;
        _beginInter = 105;
    }else if (IS_IPHONE_6){
        _scale = 1;
        _interval1 = 58;
        _interval2 = 30;
        _interval3 = 21;
        _interval4 = 94;
        _interval5 = 22;
        _interval6 = 7;
        _interval7 = 72;
        _imageHeight = 88;
        _buttonHeight = 45;
    }else if (IS_IPHONE_6P){
        _scale = 736/667;
        _interval1 = 58*_scale;
        _interval2 = 30*_scale;
        _interval3 = 21*_scale;
        _interval4 = 94*_scale;
        _interval5 = 22*_scale;
        _interval6 = 7*_scale;
        _interval7 = 72*_scale;
        _imageHeight = 88*_scale;
        _buttonHeight = 45*_scale;
        _beginInter = 11;
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
