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

#define Identifier_MainTableViewCell @"MainTableViewCell"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) double scale;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) double inteval1;
@property (nonatomic, assign) double inteval2;
@property (nonatomic, assign) double inteval3;
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
    [self configView];
}

- (void)configView
{
    self.contentView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.contentView];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:ImageNamed(@"background")];
    bgImageView.frame = self.view.frame;
    [self.contentView addSubview:bgImageView];
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.headImageView.top = _inteval1;
    self.headImageView.centerX = self.view.centerX;
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
    
    if (![StorageManager getAccountNumber]) {
       [self.contentView addSubview:self.loginBtn];
    }else{
        self.loginBtn.hidden = YES;
    }
    
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.headImageView.bottom+_inteval2, 70, 20)];
    self.nameLabel.left = self.headImageView.left;
    self.nameLabel.textColor = kColorWhiteColor;
    [self.contentView addSubview:self.nameLabel];
    
    self.sexImage = [[UIImageView alloc] init];
    self.sexImage.frame = CGRectMake(self.nameLabel.right+5, self.nameLabel.top+3, 15, 15);
    [self.contentView addSubview:self.sexImage];
    
    [self configTableView];
    
    
    [APIServiceManager MineMessageWithKey:[StorageManager getSecretKey] idString:[StorageManager getUserId] completionBlock:^(id responObject) {
        NSLog(@"**%@",responObject);
        if ([responObject[@"flag"] isEqualToString:@"100100"]) {
            
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
            self.itemView = [[ItemView alloc] initWithFrame:CGRectMake(0, self.nameLabel.bottom+20, SCREEN_WIDTH, 50) title1:@"年龄" subTitle1:ageAtring title2:@"BMI" subTitle2:BMIString title3:@"有效运动点" subTitle3:sportPointString];
            [self.contentView addSubview:self.itemView];
            
//     判断返回值，如果为空，显示默认空内容，不为空，显示返回内容
            
            id headImg = responObject[@"mine"][@"headImg"];
            NSLog(@"%@",headImg);
            if ([headImg class]==[NSNull class]) {
                self.headImageView.image = ImageNamed(@"avatar_default");
            }else{
                self.headImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Picture_Url,headImg]]]];
                self.headImageView.layer.cornerRadius = self.headImageView.height/2;
                self.headImageView.layer.masksToBounds = YES;
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
            
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_MainTableViewCell forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [self.imageArr objectAtIndex:indexPath.row];
    cell.textLabel.text = [self.titleArr objectAtIndex:indexPath.row];
    cell.textLabel.textColor = kColorCellTextColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MyInformationViewController *MyInfoVC = [[MyInformationViewController alloc] init];
        [self.navigationController pushViewController:MyInfoVC animated:YES];
        
//        InfomationNullViewController *InfomationNullVC = [[InfomationNullViewController alloc] init];
//        [self.navigationController pushViewController:InfomationNullVC animated:YES];
    }
    
    if (indexPath.row == 1) {
        MYHealthSchemeViewController *MyHealthVC = [[MYHealthSchemeViewController alloc] init];
        MyHealthVC.InfoArray = self.userInfoArray;
        [self.navigationController pushViewController:MyHealthVC animated:YES];
    }
    
    if (indexPath.row ==2) {
        SettingViewController *setVC = [[SettingViewController alloc] init];
        [self.navigationController pushViewController:setVC animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)onBtnToLogin:(id)sender
{
    
    [StorageManager deleteRelatedInfo];
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)configTableView
{
    self.MineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _height, SCREEN_WIDTH, SCREEN_HEIGHT-_height) style:UITableViewStylePlain];
    self.MineTableView.delegate = self;
    self.MineTableView.dataSource = self;
    self.MineTableView.rowHeight = 44;
    [self.MineTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier_MainTableViewCell];
    self.MineTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.MineTableView];
    
    UIImage *image1 = [UIImage imageNamed:@"profile_icon_file"];
    UIImage *image2 = [UIImage imageNamed:@"profile_icon_message"];
    UIImage *image3 = [UIImage imageNamed:@"profile_icon_setting"];
    self.imageArr = [[NSMutableArray alloc] init];
    [self.imageArr addObject:image1];
    [self.imageArr addObject:image2];
    [self.imageArr addObject:image3];
    
    self.titleArr = [NSArray arrayWithObjects:@"我的消息",@"我的健康档案",@"设置", nil];
}

- (void)configNav
{
    
    
    self.navigationItem.title = @"我的";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"background"] forBarMetrics:UIBarMetricsCompactPrompt];
    
}

- (void)configNumber
{
    if (IS_IPHONE_6)
    {
        self.height = 341;
        self.inteval1 = 90;
        self.inteval2 = 13;
        self.inteval3 = 40;
    }else if (IS_IPHONE_5)
    {
        self.scale = 568.0/667;
        self.height = 290;
        self.inteval1 = 90*_scale;
        self.inteval2 = 13*_scale;
        self.inteval3 = 40*_scale;
    }else if (IS_IPONE_4_OR_LESS)
    {
        self.scale = 480.0/667;
        self.height = 270;
        self.inteval1 = 90*_scale;
        self.inteval2 = 13*_scale;
        self.inteval3 = 40*_scale;
    }else if (IS_IPHONE_6P)
    {
        self.scale = 736.0/667;
        self.height = 370;
        self.inteval1 = 90*_scale;
        self.inteval2 = 13*_scale;
        self.inteval3 = 40*_scale;
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
