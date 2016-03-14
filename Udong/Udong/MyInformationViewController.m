//
//  MyInformationViewController.m
//  Udong
//
//  Created by wildyao on 15/12/8.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "MyInformationViewController.h"
#import "InfomationCenterViewController.h"
#import "InfoCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"


#define Identifier_InfoTableViewCell @"InfoTableViewCell"

@interface MyInformationViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MyInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self configView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.timeString = [[NSString alloc] init];
    self.DataArray = [[NSMutableArray alloc] init];
    
//  回到可以刷新的状态
    self.tag = 0;
    
    [APIServiceManager GetLinkManListMessageWithKey:[StorageManager getSecretKey] userID:@"2" time:self.timeString completionBlock:^(id responObject) {
        if ([responObject[@"flag"] isEqualToString:@"100100"]) {
            self.DataArray = responObject[@"messagerList"];
            
            NSDictionary *lastTimedic = [self.DataArray lastObject];
            self.timeString = lastTimedic[@"time"];
            
            [self.tableView reloadData];
        }
        
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)configNav
{
    self.view.backgroundColor = kColorWhiteColor;
    
    self.navigationItem.title = @"消息中心";
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

- (void)configView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = HEIGHT_CELL_DEFAULT;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"InfoCell" bundle:nil] forCellReuseIdentifier:Identifier_InfoTableViewCell];
    self.tableView.rowHeight = 60;
    [self.view addSubview:self.tableView];
    
    [self setupRefresh];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_InfoTableViewCell forIndexPath:indexPath];
    NSString *headImageString = self.DataArray[indexPath.row][@"headImgUrl"];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Picture_Url,headImageString]] placeholderImage:ImageNamed(@"avatar_default")];
    
    NSString *badgeNumber = [NSString stringWithFormat:@"%@",self.DataArray[indexPath.row][@"countOfUnread"]];

    if ([badgeNumber isEqualToString:@"0"]) {
        cell.badgeBtn.hidden = YES;
    }else{
        cell.badgeBtn.hidden = NO;
        cell.badgeBtn.backgroundColor = [UIColor redColor];
        [cell.badgeBtn setTitle:badgeNumber forState:UIControlStateNormal];
        [cell.badgeBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    }

    cell.nameLabel.text = self.DataArray[indexPath.row][@"nickName"];
    cell.nameLabel.textColor = UIColorFromHex(0x333333);
    
    cell.contentLabel.text = self.DataArray[indexPath.row][@"message"];
    cell.contentLabel.textColor = UIColorFromHex(0x999999);
    
    NSString *timeLabel = [NSString stringWithFormat:@"%@",self.DataArray[indexPath.row][@"time"]];
    NSInteger aa = [timeLabel integerValue];
    
//  获取当天0点时刻的时间戳
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *todate = [NSDate date];
    NSDateComponents *comps = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:todate];
    [comps setHour:0];
    NSDate *zeroDate = [calender dateFromComponents:comps];
    NSInteger val1 = [zeroDate timeIntervalSince1970];
    
//  获取前一天0点时刻的时间戳
    
    NSCalendar *calender1 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *todate1 = [NSDate date];
    NSDateComponents *comps1 = [calender1 components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:todate1];
    [comps1 setHour:0];
    NSDate *zeroDate1 = [calender1 dateFromComponents:comps];
    NSDate *zero1 = [zeroDate1  dateByAddingTimeInterval:-86400];
    NSInteger val2 = [zero1 timeIntervalSince1970];
    
    if (aa>val1) {
        NSDate *today = [NSDate dateWithTimeIntervalSince1970:aa];
        NSString *todayString = [NSString stringWithFormat:@"%@",today];
        NSString *substring = [todayString substringWithRange:NSMakeRange(11, 15)];
        cell.timeLabel.text = substring;
        cell.timeLabel.textColor = UIColorFromHex(0x999999);
    
    }else if (val2<aa<val1){
        
        cell.timeLabel.text = @"昨天";
        cell.timeLabel.textColor = UIColorFromHex(0x999999);
    }else{
        
        NSDate *today = [NSDate dateWithTimeIntervalSince1970:aa];
        NSString *todayString = [NSString stringWithFormat:@"%@",today];
        NSString *substring = [todayString substringWithRange:NSMakeRange(5, 9)];
        cell.timeLabel.text = substring;
        cell.timeLabel.textColor = UIColorFromHex(0x999999);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *idString = [NSString stringWithFormat:@"%@",self.DataArray[indexPath.row][@"messagerId"]];
    
    NSString *countOfUnread = [NSString stringWithFormat:@"%@",self.DataArray[indexPath.row][@"countOfUnread"]];
    NSInteger count = [countOfUnread integerValue];
    
    if (count == 0) {
        [APIServiceManager GetAlreadyReadMessageWithKey:[StorageManager getSecretKey] userID:@"2" messageID:idString time:@"" completionBlock:^(id responObject) {
            if ([responObject[@"flag"] isEqualToString:@"100100"]) {
                
                NSString *headImageString = self.DataArray[indexPath.row][@"headImgUrl"];
                NSArray *messageListArray = responObject[@"messageList"];
                InfomationCenterViewController *infoCenterVC = [[InfomationCenterViewController alloc] init];
                infoCenterVC.infoArray = messageListArray;
                infoCenterVC.headImageString = headImageString;
                
                [self.navigationController pushViewController:infoCenterVC animated:YES];
            }

        } failureBlock:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }else{
        
        [APIServiceManager GetUnReadMessageWithKey:[StorageManager getSecretKey] userID:@"2" messageID:idString completionBlock:^(id responObject) {
            if ([responObject[@"flag"] isEqualToString:@"100100"]) {
                
                NSString *headImageString = self.DataArray[indexPath.row][@"headImgUrl"];
                NSArray *messageListArray = responObject[@"messageList"];
                InfomationCenterViewController *infoCenterVC = [[InfomationCenterViewController alloc] init];
                infoCenterVC.infoArray = messageListArray;
                infoCenterVC.headImageString = headImageString;
                
                [self.navigationController pushViewController:infoCenterVC animated:YES];
            }
            
        } failureBlock:^(NSError *error) {
            NSLog(@"%@",error);
        }];

    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableView addHeaderWithTarget:self action:@selector(loadData) dateKey:@"message"];
    
    // 自动刷新(一进入程序就下拉刷新)
    //    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(loadNextPageData)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开刷新";
    self.tableView.headerRefreshingText = @"刷新中，请稍候";
    
    self.tableView.footerPullToRefreshText = @"上拉加载更多";
    self.tableView.footerReleaseToRefreshText = @"松开加载更多";
    self.tableView.footerRefreshingText = @"加载中，请稍候";
    
    //    [self.tableView headerEndRefreshing];
}

- (void)loadNextPageData
{
    if (self.tag == 1) {
        [self.tableView footerEndRefreshing];
        return;
    }
    
    [APIServiceManager GetLinkManListMessageWithKey:[StorageManager getSecretKey] userID:@"2" time:self.timeString completionBlock:^(id responObject) {
       
        if ([responObject[@"flag"] isEqualToString:@"100100"]) {
           NSMutableArray *plusArray = responObject[@"messagerList"];
            
            if (plusArray.count>=20) {
                NSMutableArray *tempArray = [[NSMutableArray alloc]init];
                [tempArray addObjectsFromArray:self.DataArray];
                
                for(NSDictionary *dic in plusArray){
                    [tempArray addObject:dic];
                }
                
                self.DataArray = tempArray;
                NSDictionary *lastTimedic = [self.DataArray lastObject];
                
                self.timeString = lastTimedic[@"time"];
                
                [self.tableView reloadData];

            }else{
                
//              记录刷新状态，如果服务端返回的条数小余20条，则取消刷新
                self.tag = 1;
                
                NSMutableArray *tempArray = [[NSMutableArray alloc]init];
                [tempArray addObjectsFromArray:self.DataArray];
                
                for(NSDictionary *dic in plusArray){
                    [tempArray addObject:dic];
                }
                
                self.DataArray = tempArray;
                
                [self.tableView reloadData];

                [self.tableView footerEndRefreshing];
            }
            
            }

    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

- (void)loadData
{
    self.tag = 0;
    
    [APIServiceManager GetLinkManListMessageWithKey:[StorageManager getSecretKey] userID:@"2" time:@"" completionBlock:^(id responObject) {
        if ([responObject[@"flag"] isEqualToString:@"100100"]) {
            
            self.DataArray = responObject[@"messagerList"];
            NSDictionary *lastTimedic = [self.DataArray lastObject];
            self.timeString = lastTimedic[@"time"];
            
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
        }
        
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
