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
#import "ThirdSharedView.h"
#import "EffectiveStarView.h"
#import "DeviceHandleManager.h"
#import "FeedbackMessageModel.h"

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
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+100);
    [self.view addSubview:self.scrollView];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kColorWhiteColor;
    self.tableView.rowHeight = HEIGHT_CELL_DEFAULT;
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier_SettingTableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"TicklingCell" bundle:nil] forCellReuseIdentifier:Identifier_TicklingTableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"UpdateCell" bundle:nil] forCellReuseIdentifier:Identifier_UpdateTableViewCell];
    [self.scrollView addSubview:self.tableView];
    
    
    self.exitbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.exitbtn.frame = CGRectMake(45, self.tableView.bottom+10, SCREEN_WIDTH-45*2, HEIGHT_FLATBUTTON);
    [self.exitbtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.exitbtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    [self.exitbtn addTarget:self action:@selector(onBtnToLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.exitbtn setBackgroundColor:UIColorFromHex(0xd43434)];
    [self.scrollView addSubview:self.exitbtn];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
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
             [APIServiceManager GetFeedbackMessageWithKey:[StorageManager getSecretKey] fromId:@"1" toUserId:[StorageManager getUserId] completionBlock:^(id responObject)
              {
                 if ([responObject[@"flag"] isEqualToString:@"100100"]){
                     NSArray *chatArray = responObject[@"result"];
                     for (NSDictionary *chatDic in chatArray)
                      {
                          NSString *statusString = [NSString stringWithFormat:@"%@",chatDic[@"status"]];
                          
                         if ([statusString isEqualToString:@"1"]){
                             cell.RedPointImage.image = self.aboutArray[indexPath.row][RedPointkey];
                             }
                         else
                         {
                             cell.RedPointImage.hidden = YES;
                         }
                      }
                   }
             } failureBlock:^(NSError *error) {
                 NSLog(@"error");
             }];
             
             cell.textLabel.textColor = kColorCellTextColor;
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

             baseCell = cell;
         }
         if (indexPath.row == 1) {
             UpdateCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_UpdateTableViewCell forIndexPath:indexPath];
             cell.headImage.image = self.aboutArray[indexPath.row][headImageKey];
             cell.titileLabel.text = self.aboutArray[indexPath.row][titleLabelKey];
             
             [APIServiceManager VersionUpdateWithKey:[StorageManager getSecretKey] type:@"2" completionBlock:^(id responObject) {
                 if ([responObject[@"flag"] isEqualToString:@"100100"]) {
                     NSString *serviceVersion = [NSString stringWithFormat:@"%@",responObject[@"result"][@"version_ids"]];
                     if ([serviceVersion isEqualToString:@"1.0.0"]) {
                         [cell.updateBtn setTitle:self.aboutArray[indexPath.row][UpdateKey] forState:UIControlStateNormal];
                         [cell.updateBtn setTitleColor:kColorBtnColor forState:UIControlStateNormal];
                         [cell.updateBtn addTarget:self action:@selector(UpdateVersion:) forControlEvents:UIControlEventTouchUpInside];
                         cell.textLabel.textColor = kColorCellTextColor;
                         cell.hiddenLabel.hidden = YES;
                     }else
                     {
                         cell.updateBtn.hidden = YES;
                         cell.hiddenLabel.hidden = NO;
                     }
                 }else{
                     NSLog(@"%@",responObject[@"message"]);
                 }
                 
             } failureBlock:^(NSError *error) {
                 NSLog(@"%@",error);
             }];
             
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
        if ([StorageManager getAccountNumber])
        {
            if (indexPath.row == 0)
            {
                AccountmanagerViewController *accountVC = [[AccountmanagerViewController alloc] init];
                [self.navigationController pushViewController:accountVC animated:YES];
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
            
            [APIServiceManager GetFeedbackMessageWithKey:[StorageManager getSecretKey] fromId:@"1" toUserId:[StorageManager getUserId] completionBlock:^(id responObject) {
//   如果状态码返回正确，用封装好的model类接收聊天信息，并把聊天信息传到反馈界面
                if ([responObject[@"flag"] isEqualToString:@"100100"]) {
//   如果获取聊天信息成功，点击意见反馈的时候，要告诉服务端已经阅读了，更新反馈状态
                    
                    [APIServiceManager UpdateFeedbackStatusWithKey:[StorageManager getSecretKey] userId:[StorageManager getUserId] status:@"2" completionBlock:^(id responObject) {
                        NSLog(@"%@",responObject);
                    } failureBlock:^(NSError *error) {
                        NSLog(@"%@",error);
                    }];
                    
                
                    self.chatInfoArray = [[NSMutableArray alloc] init];
                    
                    NSArray *chatArray = responObject[@"result"];
                    
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
                NSLog(@"%@",error);
            }];
        
        }
        
        if (indexPath.row == 2) {
            AboutUdongViewController *aboutVC = [[AboutUdongViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
        
        if (indexPath.row == 3) {
//            EffectiveStarView *view = [[EffectiveStarView alloc] initWithFrame:CGRectMake(20, 0, self.view.width-40, 0) andContainerView:[UIApplication sharedApplication].delegate.window];
//            [view show];
            ThirdSharedView *view = [[ThirdSharedView alloc] initWithFrame:CGRectMake(0, self.view.height-200, self.view.width, 200)];
            [view show];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)configNav
{
    self.navigationItem.title = @"设置";
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = kColorWhiteColor;
    self.view.backgroundColor = kColorWhiteColor;
    
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
        
        [StorageManager deleteRelatedInfo];
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }]];
    
    [self presentViewController:AlertVC animated:true completion:nil];
}

- (void)UpdateVersion:(UIButton *)btn
{


    NSURL *updateUrl = [NSURL URLWithString:@"https://app.hzzkkj.com"];
    [[UIApplication sharedApplication] openURL:updateUrl];
    
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
