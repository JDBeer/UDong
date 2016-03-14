//
//  MineViewController.m
//  Udong
//
//  Created by wildyao on 15/11/24.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "MineViewController.h"
#import "SettingViewController.h"
#import "LoginViewController.h"
#import "MYHealthSchemeViewController.h"
#import "InfomationNullViewController.h"
#import "MyInformationViewController.h"
#import "AccountmanagerViewController.h"
#import "MeasuremenViewController.h"
#import "TicklingCell.h"
#import "Tool.h"
#import "AppDelegate.h"

#define Identifier_MainTableViewCell @"MainTableViewCell"
#define Identifier_SetTableViewCell @"SetTableViewCell"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) double scale;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) double inteval1;
@property (nonatomic, assign) double inteval2;
@property (nonatomic, assign) double inteval3;
@property (nonatomic, assign) double interval4;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self configNumber];
    [self configView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self configNav];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkReachable:) name:CurrentNetWorkReacherable object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkNotReachable:) name:CurrentNetWorkNotReachable object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHeadImage:) name:didChangeHeadImageSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNickName:) name:DidFinishedChangeNickNameNotification object:nil];
    
}

- (void)changeHeadImage:(NSNotification *)notification
{
    NSString *urlString = notification.object;
    [self.headImageView setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Picture_Url,urlString]]]] forState:UIControlStateNormal];
    
}

- (void)changeNickName:(NSNotification *)notification
{
    id name = notification.object;
    self.nameLabel.text = [NSString stringWithFormat:@"%@",name];
    
}

- (void)configView
{
    
    
    self.view.backgroundColor = kColorWhiteColor;
    
    
    self.contentView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.contentView];
    
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
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:ImageNamed(@"background")];
    bgImageView.frame = self.view.frame;
    [self.contentView addSubview:bgImageView];
    
    
    
    
    
    self.headImageView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.headImageView.top = _inteval1+10;
    self.headImageView.centerX = self.view.centerX;
    [self.headImageView addTarget:self action:@selector(pushToAccountVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.headImageView];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.centerX = self.headImageView.centerX;
    self.loginBtn.centerY = self.headImageView.centerY;
    self.loginBtn.bounds = CGRectMake(0, 0, 65, 20);
    [self.loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    [self.loginBtn.titleLabel setFont:FONT(14)];
    [self.loginBtn addTarget:self action:@selector(onBtnToLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.loginBtn];
    
    
    if ([StorageManager getAccountNumber]||[[StorageManager getLoginType] isEqualToString:@"0"]||[[StorageManager getLoginType] isEqualToString:@"1"]||[[StorageManager getLoginType] isEqualToString:@"2"]||[[StorageManager getLoginType] isEqualToString:@"3"]) {
        
        self.loginBtn.hidden = YES;
    }else{
        self.loginBtn.hidden = NO;
        self.headImageView.userInteractionEnabled = NO;
    }
    
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.headImageView.bottom+_inteval2, 70, 20)];
    self.nameLabel.left = self.headImageView.left;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = kColorWhiteColor;
    [self.contentView addSubview:self.nameLabel];
    
    self.sexImage = [[UIImageView alloc] init];
    self.sexImage.frame = CGRectMake(self.nameLabel.right+5, self.nameLabel.top+2, 15, 16);
    [self.contentView addSubview:self.sexImage];

    
    [SVProgressHUD showProgressWithStatus:@"请稍候" duration:-1];
   
    [APIServiceManager MineMessageWithKey:[StorageManager getSecretKey] idString:[StorageManager getUserId] completionBlock:^(id responObject) {
        
        if ([responObject[@"flag"] isEqualToString:@"100100"]) {
            
            [SVProgressHUD dismiss];
            
            if ([responObject[@"mine"] class]==[NSNull class]) {
                self.userInfoArray = [NSArray arrayWithObjects:@"null",@"null",@"null",@"null", nil];
                self.itemView = [[ItemView alloc] initWithFrame:CGRectMake(0, self.nameLabel.bottom+_interval4, SCREEN_WIDTH, 40) title1:@"年龄" subTitle1:@"null" title2:@"BMI" subTitle2:@"null" title3:@"有效运动点" subTitle3:@"null"];
                [self.contentView addSubview:self.itemView];
                
                self.clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                self.clearBtn.frame = self.itemView.frame;
                self.clearBtn.backgroundColor = kColorClearColor;
                [self.clearBtn addTarget:self action:@selector(presentToMeasureVC:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:self.clearBtn];
                
                [self.headImageView setBackgroundImage:ImageNamed(@"avatar_default") forState:UIControlStateNormal];
                self.nameLabel.text = @"null";
                
                [self configTableView];
                
            }else{
                
                //   获得我的健康档案信息，然后传值
                NSString * genderstring = [NSString stringWithFormat:@"%@",responObject[@"mine"][@"gender"]];
                NSString *ageString = [NSString stringWithFormat:@"%@",responObject[@"mine"][@"age"]];
                NSString *heightString = [NSString stringWithFormat:@"%@cm",responObject[@"mine"][@"height"]];
                NSString *weightString = [NSString stringWithFormat:@"%@kg",responObject[@"mine"][@"weight"]];
                
                self.userInfoArray = [NSArray arrayWithObjects:genderstring,ageString,heightString,weightString, nil];
                
                //     获得我的页面上部信息
                
                NSString *ageAtring = [NSString stringWithFormat:@"%@",responObject[@"mine"][@"age"]];
                NSString *BMIString = [NSString stringWithFormat:@"%@",responObject[@"mine"][@"bmiInfo"]];
                NSString *sportPointString = [NSString stringWithFormat:@"%@",responObject[@"mine"][@"eevMin"]];
                self.itemView = [[ItemView alloc] initWithFrame:CGRectMake(0, self.nameLabel.bottom+_interval4, SCREEN_WIDTH, 40) title1:@"年龄" subTitle1:ageAtring title2:@"BMI" subTitle2:BMIString title3:@"有效运动点" subTitle3:sportPointString];
                [self.contentView addSubview:self.itemView];
                
                self.clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                self.clearBtn.frame = self.itemView.frame;
                self.clearBtn.backgroundColor = kColorClearColor;
                [self.clearBtn addTarget:self action:@selector(presentToMeasureVC:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:self.clearBtn];
                
                //     判断返回值，如果为空，显示默认空内容，不为空，显示返回内容
                
                id headImg = responObject[@"mine"][@"headImg"];
                if ([headImg class]==[NSNull class]) {
                    [self.headImageView setBackgroundImage:ImageNamed(@"avatar_default") forState:UIControlStateNormal];
                }else{
                    UIImage *Image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Picture_Url,headImg]]]];
                    if (Image == nil) {
                        [self.headImageView setBackgroundImage:ImageNamed(@"avatar_default") forState:UIControlStateNormal];
                        self.headImageView.layer.cornerRadius = self.headImageView.height/2;
                        self.headImageView.layer.masksToBounds = YES;
                    }else{
                        [self.headImageView setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Picture_Url,headImg]]]] forState:UIControlStateNormal];
                        self.headImageView.layer.cornerRadius = self.headImageView.height/2;
                        self.headImageView.layer.masksToBounds = YES;
                    }
                  
                }
                
                id nickName = responObject[@"mine"][@"nickName"];
                if ([nickName class]==[NSNull class]) {
                    self.nameLabel.text = @"游客";
                }else{
                    self.nameLabel.text = [NSString stringWithFormat:@"%@",nickName];
                }
                
                
                id gender = responObject[@"mine"][@"gender"];
                NSString *genderString = [NSString stringWithFormat:@"%@",gender];
                if ([genderString isEqualToString:@"M"]) {
                    self.sexImage.image = ImageNamed(@"gender_boy");
                }else{
                    self.sexImage.image = ImageNamed(@"gneder_woman");
                }
                
                [self configTableView];
                
            }

            }

    } failureBlock:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        NSString *title = @"我的";
        
        NoNetWorkViewController *NoNetWorkVC = [[NoNetWorkViewController alloc] init];
        NoNetWorkVC.titleLabel = title;
        
        [self addChildViewController:NoNetWorkVC];
        self.navigationController.navigationBarHidden = YES;
        [self.view addSubview:NoNetWorkVC.view];
        
        NSLog(@"%@",error);
    }];
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        
        TicklingCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_SetTableViewCell forIndexPath:indexPath];
        cell.headImage.image = self.imageArr[indexPath.row];
        cell.titlelabel.text = self.titleArr[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
        [APIServiceManager MineMessageWithKey:[StorageManager getSecretKey] idString:[StorageManager getUserId] completionBlock:^(id responObject) {

//   获取服务端返给客户端的反馈值，值大于0，设置行显示红点
            
            if ([responObject[@"mine"] class]==[NSNull class]) {
                cell.RedPointImage.image = nil;
            }else{
                self.feedBackCount = [NSString stringWithFormat:@"%@",responObject[@"mine"][@"countOfFeedback"]];
                if (![self.feedBackCount isEqualToString:@"0"]) {
                    cell.RedPointImage.image = ImageNamed(@"dot_inform");
                }else{
                    cell.RedPointImage.image = nil;
                }
            }

        } failureBlock:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        return cell;
        
    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_MainTableViewCell forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = [self.imageArr objectAtIndex:indexPath.row];
        cell.textLabel.text = [self.titleArr objectAtIndex:indexPath.row];
        cell.textLabel.textColor = kColorCellTextColor;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
    
        [SVProgressHUD showProgressWithStatus:@"请稍候" duration:-1];
        [APIServiceManager MineMessageWithKey:[StorageManager getSecretKey] idString:[StorageManager getUserId] completionBlock:^(id responObject) {
            
            if ([responObject[@"flag"] isEqualToString:@"100100"]) {
                
                [SVProgressHUD dismiss];
                
                id message = responObject[@"mine"][@"countOfMessage"];
                int aa = [message intValue];
                
                if (aa == 0) {
                    
                InfomationNullViewController *InfomationNullVC = [[InfomationNullViewController alloc] init];
                [self.navigationController pushViewController:InfomationNullVC animated:YES];
                    
                }else{
                    
                MyInformationViewController *MyInfoVC =[[MyInformationViewController alloc] init];
                [self.navigationController pushViewController:MyInfoVC animated:YES];
                }
            }
        } failureBlock:^(NSError *error) {
            
            [SVProgressHUD dismiss];
            NSString *title = @"消息中心";
          
            NoNetWorkViewController *NoNetWorkVC = [[NoNetWorkViewController alloc] init];
            NoNetWorkVC.titleLabel = title;

            [self.navigationController pushViewController:NoNetWorkVC animated:YES];

            NSLog(@"%@",error);
        }];

    }
    
    if (indexPath.row == 1) {
        MYHealthSchemeViewController *MyHealthVC = [[MYHealthSchemeViewController alloc] init];
        MyHealthVC.InfoArray = self.userInfoArray;
        [self.navigationController pushViewController:MyHealthVC animated:YES];
    }
    
    if (indexPath.row ==2) {
        
        [APIServiceManager VersionUpdateWithKey:[StorageManager getSecretKey] type:@"2" version:[StorageManager getIOSVersion] completionBlock:^(id responObject) {
            NSString *flagString = responObject[@"flag"];
            
            SettingViewController *setVC = [[SettingViewController alloc] init];
            setVC.flagString = flagString;
            [self.navigationController pushViewController:setVC animated:YES];
        } failureBlock:^(NSError *error) {
            NSLog(@"%@",error);
        }];
            
        
         
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)onBtnToLogin:(id)sender
{
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    
    loginVC.backBtn.hidden = NO;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)configTableView
{
    self.MineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _height, SCREEN_WIDTH, SCREEN_HEIGHT-_height) style:UITableViewStylePlain];
    self.MineTableView.delegate = self;
    self.MineTableView.backgroundColor = kColorWhiteColor;
    self.MineTableView.dataSource = self;
    self.MineTableView.rowHeight = 44;
    self.MineTableView.scrollEnabled = NO;
    [self.MineTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier_MainTableViewCell];
    [self.MineTableView registerNib:[UINib nibWithNibName:@"TicklingCell" bundle:nil] forCellReuseIdentifier:Identifier_SetTableViewCell];
    
    self.MineTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.MineTableView];
    
    UIImage *image1 = [UIImage imageNamed:@"profile_icon_file"];
    UIImage *image2 = [UIImage imageNamed:@"profile_icon_message"];
    UIImage *image3 = [UIImage imageNamed:@"profile_icon_setting"];
    self.imageArr = [[NSMutableArray alloc] init];
    [self.imageArr addObject:image1];
    [self.imageArr addObject:image2];
    [self.imageArr addObject:image3];
    
    self.titleArr = [NSArray arrayWithObjects:@"我的消息",@"我的健康档案",@"设置", nil];
}

- (void)pushToAccountVC:(id)sender
{
    
    [SVProgressHUD showProgressWithStatus:@"请稍候" duration:-1];
    [APIServiceManager MineMessageWithKey:[StorageManager getSecretKey] idString:[StorageManager getUserId] completionBlock:^(id responObject) {
        
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
        
    }];

    
    
    
}

- (void)presentToMeasureVC:(id)sender
{
    MeasuremenViewController *measureVC = [[MeasuremenViewController alloc] init];
    UINavigationController *navController =[[UINavigationController alloc] initWithRootViewController:measureVC];
    
    measureVC.sign = 111;
    [self presentViewController:navController animated:YES completion:nil];
}


#pragma mark - 网络监控通知
- (void)networkReachable:(NSNotification *)notification
{
    
    self.banner.hidden = YES;
//    self.view.top-=50;
    self.navigationController.navigationBar.top-=25;
    
}

- (void)networkNotReachable:(NSNotification *)notification
{
    
    self.banner.hidden = NO;
    
//    self.view.top+=50;
    self.navigationController.navigationBar.top+=25;
    
}

- (void)configNav
{
    self.navigationController.navigationBar.shadowImage = nil;
    
    self.navigationItem.title = @"我的";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:kColorWhiteColor}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundColor:kColorClearColor];
    
     self.navigationController.navigationBarHidden = NO;

}

- (void)configNumber
{
    if (IS_IPHONE_6)
    {
        self.height = 341;
        self.inteval1 = 70;
        self.inteval2 = 13;
        self.inteval3 = 40;
        self.interval4 = 25;
    }else if (IS_IPHONE_5)
    {
        self.scale = 568.0/667;
        self.height = 290;
        self.inteval1 = 70*_scale;
        self.inteval2 = 13*_scale;
        self.inteval3 = 40*_scale;
        self.interval4 = 15;
    }else if (IS_IPONE_4_OR_LESS)
    {
        self.scale = 480.0/667;
        self.height = 270;
        self.inteval1 = 70*_scale;
        self.inteval2 = 13*_scale;
        self.inteval3 = 40*_scale;
        self.interval4 = 12;
    }else if (IS_IPHONE_6P)
    {
        self.scale = 736.0/667;
        self.height = 370;
        self.inteval1 = 70*_scale;
        self.inteval2 = 13*_scale;
        self.inteval3 = 40*_scale;
        self.interval4 = 30;
        
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
