//
//  SportEffectViewController.m
//  Udong
//
//  Created by wildyao on 15/12/17.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "SportEffectViewController.h"
#import "SportViewController.h"
#import "ScreenClipViewController.h"
#import "SportViewController.h"
#import "EffectiveView.h"
#import "EffectTableViewCell.h"
#import "PICircularProgressView.h"
#import "EffectExplainView.h"
#import "TranslationDataArr.h"
#define Identifier_EffectTabelViewCell @"EffectTabelViewCell"

@interface SportEffectViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) double scale;
@property (nonatomic, assign) double interval1;
@property (nonatomic, assign) double interval2;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) double interval;
@property (nonatomic, assign) double tableViewY;

@end

@implementation SportEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNumber];
    [self configView];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DidBackEffectiveController" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)configView
{
    
    [self synchronizeWithServer];
    
    self.moveSign = 1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appear:) name:DidPressCloseBtnSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedDateSuccess:) name:DidSelectedDateSuccess object:nil];
    
    UIImageView *bgImg = [[UIImageView alloc] initWithImage:ImageNamed(@"background")];
    bgImg.frame = self.view.frame;
    bgImg.userInteractionEnabled = YES;
    [self.view addSubview:bgImg];
    
    self.contentView= [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.contentView.contentSize = CGSizeMake(SCREEN_WIDTH,0);
    [self.view addSubview:self.contentView];
    
    
    //根据运动界面传过来的时间，转换成0点时间戳
    
    if ([self.timeString isEqualToString:@"今天"]) {
        
        NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *todate = [NSDate date];
        NSDateComponents *comps = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:todate];
        [comps setHour:0];
        NSDate *zeroDate = [calender dateFromComponents:comps];
        NSInteger zeroDateString = [zeroDate timeIntervalSince1970];
        self.zeroStr = [NSString stringWithFormat:@"%ld",(long)zeroDateString];
    }else if ([self.timeString isEqualToString:@"昨天"]){
        
        NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *todate = [NSDate date];
        NSDateComponents *comps = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:todate];
        [comps setHour:0];
        NSDate *zeroDate = [calender dateFromComponents:comps];
        NSInteger zeroDateString = [zeroDate timeIntervalSince1970]-24*3600;
        self.zeroStr = [NSString stringWithFormat:@"%ld",(long)zeroDateString];
    }else{
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *zero = [formatter dateFromString:self.timeString];
        NSInteger zeroDateString = [zero timeIntervalSince1970];
        self.zeroStr = [NSString stringWithFormat:@"%ld",(long)zeroDateString];
        
    }
    
    [APIServiceManager GetOnedaySportEffectWithKey:[StorageManager getSecretKey] userID:[StorageManager getUserId] dateString:self.zeroStr completionBlock:^(id responObject) {
        
        if ([responObject[@"flag"] isEqualToString:@"100100"]) {
            self.infoArray = responObject[@"sResultsOfDay"][@"sportsResultDetails"];
            
            NSString *ererary =[NSString stringWithFormat:@"%@",responObject[@"sResultsOfDay"][@"bfc"]];
            
            if ([ererary isEqualToString:@"0"]) {
                self.precentString = @"0";
            }else
            {
                float b = [ererary floatValue];
                if (b>=10) {
                    self.precentString = [ererary substringToIndex:4];
                }else{
                    self.precentString = [ererary substringToIndex:3];
                }
            }
            
            id earning = responObject[@"sResultsOfDay"][@"earning"];
            float earn = [earning floatValue];
            
            id eev = responObject[@"sResultsOfDay"][@"eev"];
            float ee = [eev floatValue];
            
            float cha = earn/ee;
            
            if (cha<1.0) {
                self.angle = (0.75/2)*cha;
            }else{
                self.angle = (0.75/2)+(0.75/10)*cha;
            }
            
            self.PIView = [[PICircularProgressView alloc] init];
            self.PIView.precentLb = self.precentString;
            self.PIView.angleFloat = self.angle;
            self.PIView.bounds = CGRectMake(0, 0, _height,_height);
            self.PIView.centerX = self.view.centerX;
            self.PIView.top = 110;
            self.PIView.backgroundColor = kColorClearColor;
            self.PIView.moveSign = self.moveSign;
            [self.contentView addSubview:self.PIView];
            
            self.explainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.explainBtn.bounds = CGRectMake(0, 0, 20, 20);
            self.explainBtn.left = self.PIView.right+15;
            self.explainBtn.top = self.PIView.top+5;
            [self.explainBtn setBackgroundImage:ImageNamed(@"icon_quenstion") forState:UIControlStateNormal];
            self.explainBtn.layer.cornerRadius = 10;
            self.explainBtn.layer.masksToBounds = YES;
            [self.explainBtn addTarget:self action:@selector(explainBtnPress:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.contentView addSubview:self.explainBtn];
            
            self.dayLabel = [[UILabel alloc] init];
            self.dayLabel.frame = CGRectMake(0, 0, 100, 14);
            self.dayLabel.centerX = self.view.centerX;
            self.dayLabel.top = 80;
            self.dayLabel.textAlignment = NSTextAlignmentCenter;
            self.dayLabel.text = self.timeString;
            self.dayLabel.textColor = kColorWhiteColor;
            self.dayLabel.font = FONT(16);
            [self.contentView addSubview:self.dayLabel];
            
            self.effectiveView = [[EffectiveView alloc] initWithFrame:CGRectMake(0, _interval, self.view.width, 20)];
            [self.contentView addSubview:self.effectiveView];
            
            
            if ([self.infoArray class]==[NSNull class]||self.infoArray.count == 0||[self.infoArray class] == [NSNull null]){
                
                [self configNullDataView];
                
            }else{
                
                self.contentView.contentSize = CGSizeMake(SCREEN_WIDTH, _tableViewY+64+self.infoArray.count*160);
                
                [self configTableView];
            }
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *aa =[NSString stringWithFormat:@"%@",self.infoArray[indexPath.row][@"type"]];
    NSInteger type = [aa integerValue];
    
    EffectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_EffectTabelViewCell forIndexPath:indexPath];
    
    if (type == 0) {
//      时间戳转时间
        NSString *aa = self.infoArray[indexPath.row][@"time"];
        NSInteger time = [aa integerValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time+8*3600];
        NSString *timeString = [NSString stringWithFormat:@"%@",date];
        NSString *subString = [timeString substringWithRange:NSMakeRange(10, 10)];
        NSString *sting = [subString substringToIndex:6];
//      有效运动点四舍五入
        NSString *sportPoint = self.infoArray[indexPath.row][@"earnings"];
        float point = [sportPoint floatValue];
        int a;
        a = (int)(point+0.5);
//      比率四舍五入
        NSString *rateString = self.infoArray[indexPath.row][@"rate"];
        float rate = [rateString floatValue];
        int b;
        b = (int)(rate+0.5);
        
        cell.timeLabel.text = sting;
        cell.headImageView.image = ImageNamed(@"icon_nengliang");
        cell.number1.text = [NSString stringWithFormat:@"%d",a];
        cell.number1.textColor = UIColorFromHex(0xFA8E19);
        cell.pointlabel.textColor = UIColorFromHex(0xFA8E19);
        cell.label2.text = @"过热能量消耗";
        cell.number2.text = [NSString stringWithFormat:@"%d",b];
        cell.number2.textColor = UIColorFromHex(0xFA8E19);
        cell.precentLabel.textColor = UIColorFromHex(0xFA8E19);
//      持续时间
        id cc = self.infoArray[indexPath.row][@"lastMins"];
        NSInteger lastMin = [cc integerValue];
        NSString *min = [NSString stringWithFormat:@"%ld",(long)lastMin];
        cell.number3.text = min;
        
//      有效步数
        
        id dd = self.infoArray[indexPath.row][@"stepNumEfct"];
         NSString *stepEffect = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",dd]];
        cell.number4.text = stepEffect;
    }else{
        
        //      时间戳转时间
        NSString *aa = self.infoArray[indexPath.row][@"time"];
        NSInteger time = [aa integerValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time+8*3600];
        NSString *timeString = [NSString stringWithFormat:@"%@",date];
        NSString *subString = [timeString substringWithRange:NSMakeRange(10, 10)];
        NSString *sting = [subString substringToIndex:6];
        //      有效运动点四舍五入
        NSString *sportPoint = self.infoArray[indexPath.row][@"earnings"];
        float point = [sportPoint floatValue];
        int a;
        a = (int)(point+0.5);
        //      比率四舍五入
        NSString *rateString = self.infoArray[indexPath.row][@"rate"];
        float rate = [rateString floatValue];
        int b;
        b = (int)(rate+0.5);
        
        cell.timeLabel.text = sting;
        cell.headImageView.image = ImageNamed(@"icon_nengliang");
        cell.number1.text = [NSString stringWithFormat:@"%d",a];
        cell.number1.textColor = UIColorFromHex(0x2FBEC8);
        cell.pointlabel.textColor = UIColorFromHex(0x2FBEC8);
        cell.label2.text = @"身体机能提升";
        cell.number2.text = [NSString stringWithFormat:@"%d",b];
        cell.number2.textColor = UIColorFromHex(0x2FBEC8);
        cell.precentLabel.textColor = UIColorFromHex(0x2FBEC8);
        //      持续时间
        id cc = self.infoArray[indexPath.row][@"lastMins"];
        NSInteger lastMin = [cc integerValue];
        NSString *min = [NSString stringWithFormat:@"%ld",(long)lastMin];
        cell.number3.text = min;
        
        //      有效步数
        
        id dd = self.infoArray[indexPath.row][@"stepNumEfct"];
        NSString *stepEffect = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",dd]];
        cell.number4.text = stepEffect;
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)explainBtnPress:(id)sender
{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;

    EffectExplainView *effectView = [[EffectExplainView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [effectView show];
    [self.contentView addSubview:effectView];
}

- (void)appear:(NSNotification *)notification
{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)configNullDataView
{
    UIView *nullDataView = [[UIView alloc] initWithFrame:CGRectMake(0, _tableViewY, SCREEN_WIDTH, SCREEN_HEIGHT-_tableViewY)];
    nullDataView.backgroundColor = kColorWhiteColor;
    [self.contentView addSubview:nullDataView];
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"暂无有效运动数据，未产生运动效果";
    label.font = FONT(15);
    label.numberOfLines = 0;
    label.textColor = kColorContentColor;
    
    CGSize titleSize = [label.text sizeWithFont:FONT(15) constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    label.width = titleSize.width;
    label.height = titleSize.height;
    label.centerX = self.view.centerX;
    
    if (IS_IPONE_4_OR_LESS||IS_IPHONE_5) {
        label.top = _tableViewY+40;
    }else{
        label.top = _tableViewY+70;
    }

    
    [self.contentView addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:ImageNamed(@"icon_bulb")];
    imageView.bounds = CGRectMake(0, 0, 20, 20);
    imageView.top = label.top;
    imageView.right = label.left-5;
    [self.contentView addSubview:imageView];
    
}

- (void)configTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _tableViewY, self.contentView.width, 160*5) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 160;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    self.tableView.userInteractionEnabled = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"EffectTableViewCell" bundle:nil] forCellReuseIdentifier:Identifier_EffectTabelViewCell];
    
    [self.contentView addSubview:self.tableView];
    
}

- (void)selectedDateSuccess:(NSNotification *)notification
{
    //  日历上选中的日期
    NSDate *selectedDate = (NSDate *)notification.object;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:selectedDate];
    
    //  目前的时间
    NSDate *nowDate = [NSDate date];
    NSString *nowString = [dateFormatter stringFromDate:nowDate];
    
    //  昨天的时间
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-24*60*60];
    NSString *yesterdayString = [dateFormatter stringFromDate:yesterday];
    
    
    //  根据日历上的选择的日期，向服务端拿数据
    
    NSInteger timesp = [selectedDate timeIntervalSince1970];
    NSString *timespString = [NSString stringWithFormat:@"%ld",(long)timesp];
    
    [APIServiceManager GetOnedaySportEffectWithKey:[StorageManager getSecretKey] userID:[StorageManager getUserId] dateString:timespString completionBlock:^(id responObject) {
        
        if ([responObject[@"flag"] isEqualToString:@"100100"]) {
            self.infoArray = responObject[@"sResultsOfDay"][@"sportsResultDetails"];
            
            NSString *ererary =[NSString stringWithFormat:@"%@",responObject[@"sResultsOfDay"][@"bfc"]];
            
            if ([ererary isEqualToString:@"0"]) {
                self.precentString = @"0";
            }else
            {
                float b = [ererary floatValue];
                if (b>=10) {
                    self.precentString = [ererary substringToIndex:4];
                }else{
                    self.precentString = [ererary substringToIndex:3];
                }
            }
            
            id earning = responObject[@"sResultsOfDay"][@"earning"];
            float earn = [earning floatValue];
            
            id eev = responObject[@"sResultsOfDay"][@"eev"];
            float ee = [eev floatValue];
            
            float cha = earn/ee;
            
            if (cha<1.0) {
                self.angle = (0.75/2)*cha;
            }else{
                self.angle = (0.75/2)+(0.75/10)*cha;
            }
            
            [self.PIView removeFromSuperview];
            self.PIView = nil;
            
            
            self.PIView = [[PICircularProgressView alloc] init];
            self.PIView.precentLb = self.precentString;
            self.PIView.angleFloat = self.angle;
            self.PIView.bounds = CGRectMake(0, 0, _height,_height);
            self.PIView.centerX = self.view.centerX;
            self.PIView.top = 110;
            self.PIView.backgroundColor = kColorClearColor;
            [self.contentView addSubview:self.PIView];
            
            self.explainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.explainBtn.bounds = CGRectMake(0, 0, 20, 20);
            self.explainBtn.left = self.PIView.right+15;
            self.explainBtn.top = self.PIView.top+5;
            [self.explainBtn setBackgroundImage:ImageNamed(@"icon_quenstion") forState:UIControlStateNormal];
            self.explainBtn.layer.cornerRadius = 10;
            self.explainBtn.layer.masksToBounds = YES;
            [self.explainBtn addTarget:self action:@selector(explainBtnPress:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:self.explainBtn];
            
            
            [self.dayLabel removeFromSuperview];
            self.dayLabel = nil;
            
            self.dayLabel = [[UILabel alloc] init];
            self.dayLabel.frame = CGRectMake(0, 0, 100, 14);
            self.dayLabel.centerX = self.view.centerX;
            self.dayLabel.top = 80;
            self.dayLabel.textAlignment = NSTextAlignmentCenter;
            
            if ([nowString isEqualToString:dateString]) {
                self.dayLabel.text = @"今天";
            }else if ([yesterdayString isEqualToString:dateString])
            {
                self.dayLabel.text = @"昨天";
            }else{
                self.dayLabel.text = dateString;
            }
            
            self.dayLabel.textColor = kColorWhiteColor;
            self.dayLabel.font = FONT(16);
            [self.contentView addSubview:self.dayLabel];
            
            
            [self.effectiveView removeFromSuperview];
            self.effectiveView = nil;
            
            self.effectiveView = [[EffectiveView alloc] initWithFrame:CGRectMake(0, _interval, self.view.width, 20)];
            [self.contentView addSubview:self.effectiveView];
            
            if ([self.infoArray class]==[NSNull class]||self.infoArray.count == 0) {
               
                [self configNullDataView];
                
            }else{
               
                self.contentView.contentSize = CGSizeMake(SCREEN_WIDTH, _tableViewY+self.infoArray.count*160);
                
                [self configTableView];
                [self.tableView reloadData];
            }
            
            
            
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

- (void)synchronizeWithServer
{
    
    [APIServiceManager GetServerLastRecordWithKey:[StorageManager getSecretKey] userID:[StorageManager getUserId] completionBlock:^(id responObject) {
        if ([responObject[@"flag"] isEqualToString:@"100100"]) {
            NSString *newstime = [NSString stringWithFormat:@"%@",responObject[@"newestTime"]];
            NSInteger time = [newstime integerValue];
            NSString *jsonString = [TranslationDataArr ChangeArrayToString:time];
            [APIServiceManager SendSportMessageWithKey:[StorageManager getSecretKey] sportString:jsonString completionBlock:^(id responObject) {
                if ([responObject[@"flag"] isEqualToString:@"100100"]) {
                    NSLog(@"数据同步成功");
                }
            } failureBlock:^(NSError *error) {
                NSLog(@"%@",error);
            }];
            
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)configNumber
{
    
    if (IS_IPONE_4_OR_LESS) {
        _interval1 = 15;
        _interval2 = 15;
        _height = 130;
        _interval = 130;
        _tableViewY = 250;
    
    }else if (IS_IPHONE_5){
        _scale = 568.0/667;
        _interval1 = 20;
        _interval2 = 20;
        _height = 150;
        _interval = 130;
        _tableViewY = 320;
        
    }else if (IS_IPHONE_6){
        _scale = 1;
        _interval1 = 30;
        _interval2 = 30;
        _height = 160;
        _interval = 140;
        _tableViewY = 330;
        
    }else if (IS_IPHONE_6P){
        _scale = 736/667;
        _interval1 = 40;
        _interval2 = 40;
        _height = 180;
        _interval = 140;
        _tableViewY = 340;

    }

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
