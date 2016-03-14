//
//  SettingViewController.m
//  Udong
//
//  Created by wildyao on 15/11/26.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "SettingViewController.h"
#import "PswChangeViewController.h"
#import "LoginViewController.h"
#import "AccountmanagerViewController.h"
#import "AboutUdongViewController.h"
#import "FeedbackViewController.h"
#import "TicklingCell.h"
#import "UpdateCell.h"
#import "EffectiveStarView.h"
#import "DeviceHandleManager.h"
#import "FeedbackMessageModel.h"
#import "ShufflingPageViewController.h"
#import "UMSocialSnsService.h"
#import "UMSocialSnsPlatformManager.h"
#import "TranslationDataArr.h"


#define Identifier_SettingTableViewCell @"SettingTableViewCell"
#define Identifier_TicklingTableViewCell @"TicklingTableViewCell"
#define Identifier_UpdateTableViewCell @"UpdateTableViewCell"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self configView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configNav];
    [self configData];
    
    [self.tableView reloadData];
}

- (void)configData
{
    
    self.accountArray = [[NSMutableArray alloc] init];
    self.aboutArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    [dic1 setObject:[UIImage imageNamed:@"set_icon_management"] forKey:headImageKey];
    [dic1 setObject:@"帐号管理" forKey:titleLabelKey];
    
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    [dic2 setObject:[UIImage imageNamed:@"set_icon_key"] forKey:headImageKey];
    [dic2 setObject:@"密码修改" forKey:titleLabelKey];
    
    [self.accountArray addObject:dic1];
    [self.accountArray addObject:dic2];
    
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] init];
    [dic3 setObject:[UIImage imageNamed:@"set_icon_feedback"] forKey:headImageKey];
    [dic3 setObject:@"意见反馈" forKey:titleLabelKey];
    [dic3 setObject:[UIImage imageNamed:@"dot_inform"] forKey:RedPointkey];
    
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc] init];
    [dic4 setObject:[UIImage imageNamed:@"set_icon_update"] forKey:headImageKey];
    [dic4 setObject:@"版本更新" forKey:titleLabelKey];
    [dic4 setObject:@"更新" forKey:UpdateKey];
    
    NSMutableDictionary *dic5 = [[NSMutableDictionary alloc] init];
    [dic5 setObject:[UIImage imageNamed:@"set_icon_about"] forKey:headImageKey];
    [dic5 setObject:@"关于我们" forKey:titleLabelKey];
    
    
    NSMutableDictionary *dic6 = [[NSMutableDictionary alloc] init];
    [dic6 setObject:[UIImage imageNamed:@"set_icon_recommend"] forKey:headImageKey];
    [dic6 setObject:@"向朋友们推荐优动" forKey:titleLabelKey];
    
    [self.aboutArray addObject:dic3];
    [self.aboutArray addObject:dic4];
    [self.aboutArray addObject:dic5];
    [self.aboutArray addObject:dic6];
    
    self.baseDataDictionary = [[NSDictionary alloc] init];
    self.baseDataDictionary = [DeviceHandleManager configureBaseData];
    self.VersionString = self.baseDataDictionary[DeviceAPPVersionKey];
    
}

- (void)configView
{
    
    self.view.backgroundColor = kColorWhiteColor;
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+100);
    [self.view addSubview:self.scrollView];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = kColorWhiteColor;
    self.tableView.rowHeight = HEIGHT_CELL_DEFAULT;
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier_SettingTableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"TicklingCell" bundle:nil] forCellReuseIdentifier:Identifier_TicklingTableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"UpdateCell" bundle:nil] forCellReuseIdentifier:Identifier_UpdateTableViewCell];
    [self.scrollView addSubview:self.tableView];
    
    
    self.exitbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.exitbtn.frame = CGRectMake(45, 420, SCREEN_WIDTH-45*2, HEIGHT_FLATBUTTON);
    [self.exitbtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.exitbtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    [self.exitbtn addTarget:self action:@selector(onBtnToLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.exitbtn setBackgroundColor:UIColorFromHex(0xd43434)];
    [self.scrollView addSubview:self.exitbtn];
    
    if ([StorageManager getAccountNumber]||[[StorageManager getLoginType] isEqualToString:@"0"]||[[StorageManager getLoginType] isEqualToString:@"1"]||[[StorageManager getLoginType] isEqualToString:@"2"]||[[StorageManager getLoginType] isEqualToString:@"3"]) {
        self.exitbtn.hidden = NO;
    }else
    {
        self.exitbtn.hidden = YES;

    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if ([StorageManager getAccountNumber]) {
            return 2;
        }
        return 1;
    }else
    {
        return 4;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    
    if (section == 0) {
        return @"帐号和隐私";
    }else
    {
        return @"关于";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *baseCell = nil;
    
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_SettingTableViewCell forIndexPath:indexPath];
        cell.imageView.image = self.accountArray[indexPath.row][headImageKey];
        cell.textLabel.text = self.accountArray[indexPath.row][titleLabelKey];
        cell.textLabel.textColor = kColorCellTextColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setSeparatorInset:UIEdgeInsetsZero];

        baseCell = cell;
        
     }else if (indexPath.section == 1)
     {
         if (indexPath.row == 0) {
             TicklingCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_TicklingTableViewCell forIndexPath:indexPath];
             cell.headImage.image = self.aboutArray[indexPath.row][headImageKey];
             cell.titlelabel.text = self.aboutArray[indexPath.row][titleLabelKey];
             
             [APIServiceManager MineMessageWithKey:[StorageManager getSecretKey] idString:[StorageManager getUserId] completionBlock:^(id responObject) {
                 
                 //   获取服务端返给客户端的反馈值，值大于0，设置行显示红点
                 
                 if ([responObject[@"mine"] class]==[NSNull class]) {
                     cell.RedPointImage.hidden = YES;
                 }else{
                     self.feedbackCount = [NSString stringWithFormat:@"%@",responObject[@"mine"][@"countOfFeedback"]];
                     if (![self.feedbackCount isEqualToString:@"0"]) {
                         cell.RedPointImage.image = ImageNamed(@"dot_inform");
                     }else{
                         cell.RedPointImage.hidden = YES;
                     }
                 }
             } failureBlock:^(NSError *error) {
                 NSLog(@"%@",error);
             }];

             
             cell.textLabel.textColor = kColorCellTextColor;
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

             baseCell = cell;
         }
         if (indexPath.row == 1) {
             UpdateCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_UpdateTableViewCell forIndexPath:indexPath];
             cell.headImage.image = self.aboutArray[indexPath.row][headImageKey];
             cell.titileLabel.text = self.aboutArray[indexPath.row][titleLabelKey];
             
            if ([self.flagString isEqualToString:@"100600"])
            {
                     
            //本地版本等于服务端最新版本,隐藏更新按钮
                     
                    cell.updateBtn.hidden = YES;
                    cell.hiddenLabel.hidden = NO;
                     
            }else if ([self.flagString isEqualToString:@"100100"])
                
            {
                    [cell.updateBtn setTitle:self.aboutArray[indexPath.row][UpdateKey] forState:UIControlStateNormal];
                    [cell.updateBtn setTitleColor:kColorBtnColor forState:UIControlStateNormal];
                    [cell.updateBtn addTarget:self action:@selector(UpdateVersion:) forControlEvents:UIControlEventTouchUpInside];
                    cell.textLabel.textColor = kColorCellTextColor;
                    cell.hiddenLabel.hidden = YES;

            }else
            {
                     NSLog(@"服务端无匹配的版本号");
            }
             
             baseCell = cell;
         }
         
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_SettingTableViewCell forIndexPath:indexPath];
         cell.imageView.image = self.aboutArray[indexPath.row][headImageKey];
         cell.textLabel.text = self.aboutArray[indexPath.row][titleLabelKey];
         cell.textLabel.textColor = kColorCellTextColor;
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         [cell setSeparatorInset:UIEdgeInsetsZero];

         baseCell = cell;
     }
    return baseCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if ([StorageManager getAccountNumber]||[[StorageManager getLoginType] isEqualToString:@"0"]||[[StorageManager getLoginType] isEqualToString:@"1"]||[[StorageManager getLoginType] isEqualToString:@"2"]||[[StorageManager getLoginType] isEqualToString:@"3"])
        {
            if (indexPath.row == 0)
            {
                [SVProgressHUD showProgressWithStatus:@"请稍候" duration:-1];
                [APIServiceManager GetAccountMessageWithKey:[StorageManager getSecretKey] idString:[StorageManager getUserId] status:@"1" completionBlock:^(id responObject) {
                    
                    if ([responObject[@"flag"] isEqualToString:@"100100"]) {
                        [SVProgressHUD dismiss];
                        AccountmanagerViewController *accountVC = [[AccountmanagerViewController alloc] init];
                        [self.navigationController pushViewController:accountVC animated:YES];
                    }
                    
                } failureBlock:^(NSError *error) {
                    
                    [SVProgressHUD dismiss];
                    NSString *title = @"帐号管理";
                    
                    NoNetWorkViewController *NoNetWorkVC = [[NoNetWorkViewController alloc] init];
                    NoNetWorkVC.titleLabel = title;
                    
                    [self.navigationController pushViewController:NoNetWorkVC animated:YES];
                    
                    
                    NSLog(@"%@",error);
                }];

                
               
            }
            
            if (indexPath.row == 1)
            {
                PswChangeViewController *pswChangeVC = [[PswChangeViewController alloc] init];
                [self.navigationController pushViewController:pswChangeVC animated:YES];
            }
        }else{
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        
    }else
    {
        if (indexPath.row == 0)
        {
            
            [SVProgressHUD showProgressWithStatus:@"请稍候" duration:-1];
            [APIServiceManager GetFeedbackMessageWithKey:[StorageManager getSecretKey] fromId:@"1" toUserId:[StorageManager getUserId] page:@"1" rows:@"100" completionBlock:^(id responObject) {
                NSLog(@"%@",responObject);
//   如果状态码返回正确，用封装好的model类接收聊天信息，并把聊天信息传到反馈界面
                if ([responObject[@"flag"] isEqualToString:@"100100"]) {
//   如果获取聊天信息成功，点击意见反馈的时候，要告诉服务端已经阅读了，更新反馈状态
                    
                    [SVProgressHUD dismiss];
                    [APIServiceManager UpdateFeedbackStatusWithKey:[StorageManager getSecretKey] fromId:@"1" userId:[StorageManager getUserId] status:@"2" completionBlock:^(id responObject) {
                        
                    } failureBlock:^(NSError *error) {
                        
                        [SVProgressHUD dismiss];
                        NSString *title = @"意见反馈";
                        
                        NoNetWorkViewController *NoNetWorkVC = [[NoNetWorkViewController alloc] init];
                        NoNetWorkVC.titleLabel = title;
                        
                        [self.navigationController pushViewController:NoNetWorkVC animated:YES];
                        NSLog(@"%@",error);
                    }];
                    
                
                    self.chatInfoArray = [[NSMutableArray alloc] init];
                    
                    NSArray *chatArray = responObject[@"rows"];
                    
                    
                    for (NSDictionary *chatDic in chatArray)
                    {
                        FeedbackMessageModel *obj = [FeedbackMessageModel objectWithDictionary:chatDic];
                        [self.chatInfoArray addObject:obj];
                    }
                    
                    FeedbackViewController *FeedbackVC = [[FeedbackViewController alloc] init];
                    FeedbackVC.InfoArray = self.chatInfoArray;
            
                    [self.navigationController pushViewController:FeedbackVC animated:YES];
                }else{
                    NSLog(@"%@",responObject[@"message"]);
                }
                
            } failureBlock:^(NSError *error) {
                
                [SVProgressHUD dismiss];
                NSString *title = @"意见反馈";
                
                NoNetWorkViewController *NoNetWorkVC = [[NoNetWorkViewController alloc] init];
                NoNetWorkVC.titleLabel = title;
                
                [self.navigationController pushViewController:NoNetWorkVC animated:YES];
                
                NSLog(@"%@",error);
            }];
        
        }
        
        if (indexPath.row == 1) {
            
            return;
        }
        
        if (indexPath.row == 2) {
            AboutUdongViewController *aboutVC = [[AboutUdongViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
        
        if (indexPath.row == 3) {
            
            
            [self configShareView];
            [self shareViewShow];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)configNav
{
    self.navigationController.navigationBar.shadowImage = nil;
    
    self.navigationItem.title = @"设置";
    self.navigationController.navigationBar.titleTextAttributes = @{
                                               NSFontAttributeName : FONT(18),
                                               
                                               UITextAttributeTextColor : kColorBlackColor,
                                               UITextAttributeTextShadowColor : kColorClearColor,
                                               };
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 20, 20)];
    [btn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
   
}

- (void)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onBtnToLogin:(id)sender
{
    UIAlertController *AlertVC = [UIAlertController alertControllerWithTitle:@"确定要退出帐号？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [AlertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [AlertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
//  退出登录后，与服务端同步，清除相关用户信息，清除用户本地步数字典
        [self synchronizeWithServer];
        
//  记录退出登录时间
        NSDate *date = [NSDate date];
        NSString *logoutTime = [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
        NSString *substring = [logoutTime substringToIndex:10];
        
        [StorageManager saveLogoutTime:substring];
        
        ShufflingPageViewController *shuffVC = [[ShufflingPageViewController alloc] init];
        [self.navigationController pushViewController:shuffVC animated:YES];
        
    }]];
    
    [self presentViewController:AlertVC animated:true completion:nil];
}

- (void)UpdateVersion:(UIButton *)btn
{

    NSURL *updateUrl = [NSURL URLWithString:@"https://app.hzzkkj.com"];
    [[UIApplication sharedApplication] openURL:updateUrl];
    
}

- (void)cancelbtnClick:(UIButton *)btn
{
    self.contentView.hidden = YES;
    self.shareview.hidden = YES;
    self.cancelBtn.hidden = YES;
}

- (void)shareBtn:(UIButton *)btn
{
    if (btn.tag == 1000) {
        UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:Company_Url];
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"优动，让你看到运动效果的App" image:ImageNamed(@"about_logo") location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                [SVProgressHUD showHUDWithImage:nil status:@"分享成功" duration:1];
            }
        }];
    }
    
    if (btn.tag == 1001) {
        
        UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:Company_Url];
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"优动，让你看到运动效果的App" image:ImageNamed(@"about_logo") location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                [SVProgressHUD showHUDWithImage:nil status:@"分享成功" duration:1];
            }
        }];
        
    }
    
    if (btn.tag == 1002) {
        UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:Company_Url];
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"优动，让你看到运动效果的App" image:ImageNamed(@"about_logo") location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                [SVProgressHUD showHUDWithImage:nil status:@"分享成功" duration:1];
            }
        }];

    }
    
    if (btn.tag == 1003) {
        UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:Company_Url];
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"优动，让你看到运动效果的App" image:ImageNamed(@"about_logo") location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                [SVProgressHUD showHUDWithImage:nil status:@"分享成功" duration:1];
            }
        }];

    }
}

#pragma mark - 与服务端同步
- (void)synchronizeWithServer
{
    [APIServiceManager GetServerLastRecordWithKey:[StorageManager getSecretKey] userID:[StorageManager getUserId] completionBlock:^(id responObject) {
        if ([responObject[@"flag"] isEqualToString:@"100100"]) {
            NSString *newstime = [NSString stringWithFormat:@"%@",responObject[@"newestTime"]];
            NSInteger time = [newstime integerValue];
            NSString *jsonString = [TranslationDataArr ChangeArrayToString:time];
            [APIServiceManager SendSportMessageWithKey:[StorageManager getSecretKey] sportString:jsonString completionBlock:^(id responObject) {
            
                if ([responObject[@"flag"] isEqualToString:@"100100"])
                {
                    NSFileManager *fileMger = [NSFileManager defaultManager];
                    
                    NSString *aa = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"aa.plist"];
                    
                    //如果文件路径存在的话
                    BOOL bRet = [fileMger fileExistsAtPath:aa];
                    
                    if (bRet) {
                        
                       NSMutableDictionary *plistDic = [[NSMutableDictionary alloc] initWithContentsOfFile:aa];
        
////删除当前用户今天之前的所有数据，防止没有网时候主界面显示没数据
//                       
//                       NSMutableDictionary *accountDic = plistDic[[StorageManager getUserId]];
//                        
//                       NSString *today = [self getTodayNsstring];
//                        
//                       NSArray *dayArray = accountDic.allKeys;
//                        
//                        
//                    for (int i=0; i<dayArray.count; i++)
//                        {
//                            NSString *str = dayArray[i];
//                            
//                            if (![str isEqualToString:today])
//                            {
//                            [accountDic removeObjectForKey:str];
//                            }
//                        }
//                        
//                        [plistDic setObject:accountDic forKey:[StorageManager getUserId]];
                        
                        [plistDic removeAllObjects];
                        [plistDic writeToFile:aa atomically:YES];
                    }
                }
            } failureBlock:^(NSError *error) {
                NSLog(@"%@",error);
            }];
            
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

- (NSString *)getTodayNsstring
{
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *todate = [NSDate date];
    NSDateComponents *comps = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:todate];
    [comps setHour:0];
    NSDate *zeroDate = [calender dateFromComponents:comps];
    NSTimeZone *zone1 = [NSTimeZone systemTimeZone];
    NSInteger interval1 = [zone1 secondsFromGMTForDate:zeroDate];
    NSDate *zero = [zeroDate dateByAddingTimeInterval:interval1];
    NSString *zeroString = [NSString stringWithFormat:@"%@",zero];
    NSString *zeroSubString = [zeroString substringWithRange:NSMakeRange(0, 10)];
    return zeroSubString;

}

- (void)configShareView
{
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.contentView.backgroundColor = kColorBlackColor;
    self.contentView.alpha = 0.6;
    [self.view addSubview:self.contentView];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(10, self.view.height+5+50, self.view.width-20, 50);
    
    self.cancelBtn.backgroundColor = kColorWhiteColor;
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitleColor:kColorBtnColor forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 10;
    [self.view addSubview:self.cancelBtn];
    
    
    self.shareview = [[UIView alloc] init];
    self.shareview .frame = CGRectMake(self.cancelBtn.left, self.cancelBtn.top+10+100, self.cancelBtn.width, 100);
    self.shareview .backgroundColor = kColorWhiteColor;
    self.shareview .layer.cornerRadius = 10;
    [self.view addSubview:self.shareview];
    
    UIButton *weichatImageview = [UIButton buttonWithType:UIButtonTypeCustom];
    weichatImageview.tag = 1000;
    [weichatImageview setBackgroundImage:ImageNamed(@"share_icon_wechat") forState:UIControlStateNormal];
    [weichatImageview addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    weichatImageview.frame = CGRectMake(20, 12, (self.shareview.width/4)-40, (self.shareview.width/4)-40);
    [self.shareview addSubview:weichatImageview];
    
    UILabel *weichatLabel = [[UILabel alloc] initWithFrame:CGRectMake(weichatImageview.left, weichatImageview.bottom+5, weichatImageview.width, 20)];
    weichatLabel.text = @"微信";
    weichatLabel.font = FONT(14);
    weichatLabel.textAlignment = NSTextAlignmentCenter;
    weichatLabel.textColor = kColorContentColor;
    [self.shareview addSubview:weichatLabel];
    
    UIButton *friendImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [friendImageView setBackgroundImage:ImageNamed(@"share_icon_moment") forState:UIControlStateNormal];
    friendImageView.tag = 1001;
    [friendImageView addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    friendImageView.frame = CGRectMake(weichatImageview.right+40, weichatImageview.top, weichatImageview.width, weichatImageview.height);
    [self.shareview addSubview:friendImageView];
    
    UILabel *friendLabel = [[UILabel alloc] initWithFrame:CGRectMake(friendImageView.left-5, weichatLabel.top, friendImageView.width+10, weichatLabel.height)];
    friendLabel.text = @"朋友圈";
    friendLabel.font = FONT(14);
    friendLabel.textAlignment = NSTextAlignmentCenter;
    friendLabel.textColor = kColorContentColor;
    [self.shareview addSubview:friendLabel];
    
    
    UIButton *QQImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    QQImageView.tag = 1002;
    [QQImageView addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    [QQImageView setBackgroundImage:ImageNamed(@"share_icon_qq") forState:UIControlStateNormal];
    QQImageView.frame = CGRectMake(friendImageView.right+40, friendImageView.top, friendImageView.width, friendImageView.height);
    [self.shareview addSubview:QQImageView];
    
    UILabel *QQLabel = [[UILabel alloc] initWithFrame:CGRectMake(QQImageView.left, weichatLabel.top, weichatLabel.width, weichatLabel.height)];
    QQLabel.text = @"QQ";
    QQLabel.font = FONT(14);
    QQLabel.textAlignment = NSTextAlignmentCenter;
    QQLabel.textColor = kColorContentColor;
    [self.shareview addSubview:QQLabel];
    
    
    UIButton *WeiboImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    WeiboImageView.tag = 1003;
    [WeiboImageView addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    [WeiboImageView setBackgroundImage:ImageNamed(@"share_icon_weibo") forState:UIControlStateNormal];
    WeiboImageView.frame = CGRectMake(QQImageView.right+40, friendImageView.top, friendImageView.width, friendImageView.height);
    [self.shareview addSubview:WeiboImageView];
    
    UILabel *WeiboLabel = [[UILabel alloc] initWithFrame:CGRectMake(WeiboImageView.left, weichatLabel.top, weichatLabel.width, weichatLabel.height)];
    WeiboLabel.text = @"微博";
    WeiboLabel.font = FONT(14);
    WeiboLabel.textAlignment = NSTextAlignmentCenter;
    WeiboLabel.textColor = kColorContentColor;
    [self.shareview addSubview:WeiboLabel];
    
}

- (void)shareViewShow
{
    [UIView animateWithDuration:1 animations:^{
        self.cancelBtn.frame = CGRectMake(10, self.view.height-5-50, self.view.width-20, 50);
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:1 animations:^{
                self.shareview .frame = CGRectMake(self.cancelBtn.left, self.cancelBtn.top-10-100, self.cancelBtn.width, 100);
            }];
        }
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
