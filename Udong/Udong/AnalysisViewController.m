//
//  AnalysisViewController.m
//  Udong
//
//  Created by wildyao on 15/11/24.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "AnalysisViewController.h"
#import "AnalysisView.h"
#import "AnalysisChatView.h"
#import "AnalysisViewCell.h"
#import "AppDelegate.h"
#define Identifier_AnalysisTableViewCell @"AnalysisTableViewCell"

@interface AnalysisViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation AnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self configView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkReachable:) name:CurrentNetWorkReacherable object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkNotReachable:) name:CurrentNetWorkNotReachable object:nil];
    
}

- (void)configView
{
    
    self.tag = 1;
    
    self.pointArray = [[NSMutableArray alloc] init];
    
    self.bgImageView = [[UIImageView alloc] initWithImage:ImageNamed(@"background")];
    self.bgImageView.frame = self.view.frame;
    [self.view addSubview:self.bgImageView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 730+300);
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    
    [SVProgressHUD showProgressWithStatus:@"请稍候" duration:-1];
    [APIServiceManager GetAnalysisPointMessageWithKey:[StorageManager getSecretKey] userID:[StorageManager getUserId] days:@"7" completionBlock:^(id responObject) {
    
        if ([responObject[@"flag"] isEqualToString:@"100100"]) {
            NSArray *DateListArray = responObject[@"aResult"][@"bfcOfDateList"];
            self.dataDic = responObject[@"aResult"];
            
            if ([DateListArray class]==[NSNull class]||DateListArray.count==0) {
                self.pointArray = nil;
                
            }else{
                for (NSDictionary *dic in DateListArray) {
                    NSString *bfcString = [NSString stringWithFormat:@"%@",dic[@"bfc"]];
                    NSString *dateString = [NSString stringWithFormat:@"%@",dic[@"date"]];
                    NSMutableArray *Array = [[NSMutableArray alloc] initWithObjects:bfcString,dateString, nil];
                    [self.pointArray addObject:Array];
                }
            }
            
            
            NSString *sportText = [NSString stringWithFormat:@"%@",responObject[@"aResult"][@"attainedResult"]];
            NSString *numberText = [NSString stringWithFormat:@"%@",responObject[@"aResult"][@"bfcTotal"]];
            
            self.analysisView = [[AnalysisView alloc] initWithFrame:CGRectMake(0, 55, self.view.width, 100) sportLabel:sportText numberLabel:numberText];
            [self.scrollView addSubview:self.analysisView];
            
            self.chatView= [[AnalysisChatView alloc] initWithFrame:CGRectMake(0, self.analysisView.bottom+30, self.view.width, 210) pointArray:self.pointArray type:@"1"];
            [self.scrollView addSubview:self.chatView];
            
            [self configTableView];
            [SVProgressHUD dismiss];
        }
    } failureBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSString *title = @"分析";
        
        NoNetWorkViewController *NoNetWorkVC = [[NoNetWorkViewController alloc] init];
        NoNetWorkVC.titleLabel = title;
        
        [self addChildViewController:NoNetWorkVC];
        self.navigationController.navigationBarHidden = YES;
        [self.view addSubview:NoNetWorkVC.view];
        
        
        NSLog(@"%@",error);
    }];
    
    
    self.leftTap = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightTap = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.leftTap.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightTap.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.leftTap];
    [self.view addGestureRecognizer:self.rightTap];
    
    
    self.banner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
    self.banner.backgroundColor = UIColorFromHexWithAlpha(0x000000, 0.5);
    self.banner.hidden = YES;
    [self.view addSubview:self.banner];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:ImageNamed(@"icon_quenstion")];
    iv.centerY = self.banner.height/2;
    iv.left = 15;
    [self.banner addSubview:iv];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLbl.text = @"当前网络不稳定,请检查网络设置";
    titleLbl.textColor = UIColorFromHex(0xDDDDDD);
    titleLbl.font = FONT(13);
    [titleLbl sizeToFit];
    titleLbl.left = iv.right+10;
    titleLbl.centerY = self.banner.height/2;
    [self.banner addSubview:titleLbl];
    
}

#pragma mark - swipe手势的滑动

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        if (_tag == 1) {
            [self btnPress:self.monthBtn];
            _tag++;
        }else{
            [self btnPress:self.threeMonthBtn];
        }
        
    }else{
        if (_tag == 2) {
            [self btnPress:self.monthBtn];
            _tag--;
        }else{
            [self btnPress:self.weekBtn];
        }
    }
}

#pragma mark - 表视图的配置

- (void)configTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.chatView.bottom-20, self.view.width, 600) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate  = self;
    self.tableView.rowHeight = 300;
    self.tableView.scrollEnabled = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"AnalysisViewCell" bundle:nil] forCellReuseIdentifier:Identifier_AnalysisTableViewCell];
    [self.scrollView addSubview:self.tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        AnalysisViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_AnalysisTableViewCell forIndexPath:indexPath];
        cell.chooseLabel.text = @"运动执行力";
        cell.imageView1.image = ImageNamed(@"icon_trophy");
        cell.effectLabel.text = self.dataDic[@"attainedResult"];
        cell.finishLabel.text = @"完成运动目标";
        cell.unfinishLabel.text = @"未完成运动目标";
        cell.finishDays.text =[NSString stringWithFormat:@"%@ 天",self.dataDic[@"daysAttained"]];
        cell.unfinishDays.text = [NSString stringWithFormat:@"%@ 天",self.dataDic[@"daysNotAttained"]];
        cell.descriptionLabel.text = self.dataDic[@"attainedDesc"];
        cell.userInteractionEnabled = NO;
        return cell;
    }else{
        
        AnalysisViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_AnalysisTableViewCell forIndexPath:indexPath];
        cell.chooseLabel.text = @"运动持续性";
        cell.imageView1.image = ImageNamed(@"icon_hourglass");
        cell.effectLabel.text = self.dataDic[@"continueResult"];
        cell.finishLabel.text = @"最大中段天数";
        cell.unfinishLabel.text = @"中段天数大于3天";
        cell.finishDays.text = [NSString stringWithFormat:@"%@ 天",self.dataDic[@"interruptsMax"]];
        cell.unfinishDays.text = [NSString stringWithFormat:@"%@ 次",self.dataDic[@"interruptsOver3"]];
        cell.descriptionLabel.text = self.dataDic[@"continueDesc"];
        cell.userInteractionEnabled = NO;
        return cell;
    }
}

#pragma mark - 配置导航栏

- (void)configNav
{
    [self.navigationController.navigationBar setBarTintColor:[ColorManager getColor:@"051F2D" WithAlpha:0.5]];
//  设置导航栏的月周日uiview
    UIView *BarBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 400, 44)];
    BarBgView.centerX = self.view.centerX;
//   添加三个按钮
    
    _monthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _monthBtn.bounds = CGRectMake(0, 0, 85, 32);
    _monthBtn.centerY = 22;
    _monthBtn.centerX = BarBgView.centerX-10;
    [_monthBtn setTitle:@"月" forState:UIControlStateNormal];
    [_monthBtn setTitleColor:kColorWhiteColor forState:UIControlStateSelected];
    _monthBtn.tag = 22;
    _monthBtn.selected = NO;
    [_monthBtn setTitleColor:[ColorManager getColor:@"6c7277" WithAlpha:1] forState:UIControlStateNormal];
    [_monthBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [BarBgView addSubview:_monthBtn];
    
    _weekBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _weekBtn.bounds = CGRectMake(0, 0, 85, 32);
    _weekBtn.centerY = 22;
    _weekBtn.right = _monthBtn.left-12;
    [_weekBtn setTitle:@"周" forState:UIControlStateNormal];
    [_weekBtn setTitleColor:kColorWhiteColor forState:UIControlStateSelected];
    _weekBtn.selected = YES;
    _weekBtn.tag = 21;
    [_weekBtn setTitleColor:[ColorManager getColor:@"6c7277" WithAlpha:1] forState:UIControlStateNormal];
    [_weekBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [BarBgView addSubview:_weekBtn];

    
    _threeMonthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _threeMonthBtn.bounds = CGRectMake(0, 0, 85, 32);
    _threeMonthBtn.centerY = 22;
    _threeMonthBtn.left = _monthBtn.right+12;
    [_threeMonthBtn setTitle:@"三个月" forState:UIControlStateNormal];
    [_threeMonthBtn setTitleColor:kColorWhiteColor forState:UIControlStateSelected];
    _threeMonthBtn.tag = 23;
    _threeMonthBtn.selected = NO;
    [_threeMonthBtn setTitleColor:[ColorManager getColor:@"6c7277" WithAlpha:1] forState:UIControlStateNormal];
    [_threeMonthBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [BarBgView addSubview:_threeMonthBtn];
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = kColorWhiteColor;
    _whiteView.frame = CGRectMake(_weekBtn.left, self.weekBtn.bottom+2, _monthBtn.width, 2);
    [BarBgView addSubview:_whiteView];
    
    self.navigationItem.titleView = BarBgView;
    
}

#pragma mark - 导航栏按钮的点击

- (void)btnPress:(UIButton *)btn
{
    
    [self.pointArray removeAllObjects];
    
    if (btn.tag == 21) {
        if (btn.selected == YES) {
            return;
        }
        
        [self GetAnalysisPointWithDays:@"7" type:@"1"];
        
        btn.selected = !btn.selected;
        self.monthBtn.selected = !btn.selected;
        self.threeMonthBtn.selected = !btn.selected;
        [UIView animateWithDuration:0.2 animations:^{
            self.whiteView.frame = CGRectMake(_weekBtn.left, self.weekBtn.bottom+2, _monthBtn.width, 2);
        } completion:^(BOOL finished) {
        }];
        
    }else if (btn.tag == 22)
    {
        if (btn.selected == YES) {
            return;
        }
        
        [self GetAnalysisPointWithDays:@"30" type:@"2"];
        
        btn.selected = !btn.selected;
        self.weekBtn.selected = !btn.selected;
        self.threeMonthBtn.selected = !btn.selected;
        [UIView animateWithDuration:0.2 animations:^{
            self.whiteView.frame = CGRectMake(_monthBtn.left, self.weekBtn.bottom+2, _monthBtn.width, 2);
        } completion:^(BOOL finished) {
        }];
        
    }else{
        if (btn.selected == YES) {
            return;
        }
        
        [self GetAnalysisPointWithDays:@"90" type:@"3"];
        
        btn.selected = !btn.selected;
        self.weekBtn.selected = !btn.selected;
        self.monthBtn.selected = !btn.selected;
        [UIView animateWithDuration:0.2 animations:^{
            self.whiteView.frame = CGRectMake(_threeMonthBtn.left, self.weekBtn.bottom+2, _monthBtn.width, 2);
        } completion:^(BOOL finished) {
        }];

    }
}


#pragma mark - 网络监控通知
- (void)networkReachable:(NSNotification *)notification
{
    
    self.banner.hidden = YES;
    self.scrollView.top-=50;
    self.navigationController.navigationBar.top-=50;

}

- (void)networkNotReachable:(NSNotification *)notification
{
    self.banner.hidden = NO;
    
    self.scrollView.top+=50;
    self.navigationController.navigationBar.top+=50;
    
}

- (void)GetAnalysisPointWithDays:(NSString *)day type:(NSString *)type
{
    [self.chatView removeFromSuperview];
    self.chatView = nil;
    [self.analysisView removeFromSuperview];
    self.analysisView = nil;
    
    [self.chatView.coordinateArray removeAllObjects];
    [self.pointArray removeAllObjects];
    
    [SVProgressHUD showProgressWithStatus:@"请稍候" duration:-1];
    
    [APIServiceManager GetAnalysisPointMessageWithKey:[StorageManager getSecretKey] userID:[StorageManager getUserId] days:day completionBlock:^(id responObject) {
        
        if ([responObject[@"flag"] isEqualToString:@"100100"]) {
            [SVProgressHUD dismiss];
            
            NSArray *DateListArray = responObject[@"aResult"][@"bfcOfDateList"];
            self.dataDic = responObject[@"aResult"];
            
            if ([DateListArray class]==[NSNull class]||DateListArray.count==0) {
                self.pointArray = nil;
                
            }else{
                for (NSDictionary *dic in DateListArray) {
                    NSString *bfcString = [NSString stringWithFormat:@"%@",dic[@"bfc"]];
                    NSString *dateString = [NSString stringWithFormat:@"%@",dic[@"date"]];
                    NSMutableArray *Array = [[NSMutableArray alloc] initWithObjects:bfcString,dateString, nil];
                    [self.pointArray addObject:Array];
                }
            }

            NSString *sportText = [NSString stringWithFormat:@"%@",responObject[@"aResult"][@"attainedResult"]];
            NSString *numberText = [NSString stringWithFormat:@"%@",responObject[@"aResult"][@"bfcTotal"]];
            
            self.analysisView = [[AnalysisView alloc] initWithFrame:CGRectMake(0, 55, self.view.width, 100) sportLabel:sportText numberLabel:numberText];
            [self.scrollView addSubview:self.analysisView];
            
            self.chatView= [[AnalysisChatView alloc] initWithFrame:CGRectMake(0, self.analysisView.bottom+30, self.view.width, 210) pointArray:self.pointArray type:type];
//            [self.chatView setupTheGrad];
            
            [self.scrollView addSubview:self.chatView];
            
            [self.tableView reloadData];
            
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];

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
