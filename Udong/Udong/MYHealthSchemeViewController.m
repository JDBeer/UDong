//
//  MYHealthSchemeViewController.m
//  Udong
//
//  Created by wildyao on 15/11/27.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "MYHealthSchemeViewController.h"
#import "MyhealthSchemeCell.h"
#import "MeasuremenViewController.h"

#define Identifier_healthSchemeCell @"healthSchemeCell"

@interface MYHealthSchemeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MYHealthSchemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self configView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configData];
    [self.healthTableView reloadData];
}

- (void)configNav
{
    self.navigationItem.title = @"我的健康档案";
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setFrame:CGRectMake(0, 0, 20, 20)];
    [leftbtn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, 40, 20)];
    [rightBtn setTitle:@"修改" forState:UIControlStateNormal];
    [rightBtn setTitleColor:kColorBlackColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = FONT(16);
    [rightBtn addTarget:self action:@selector(onbtnToEvaluateVC:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
}

- (void)configView
{
    self.healthTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250) style:UITableViewStylePlain];
    self.healthTableView.dataSource = self;
    self.healthTableView.delegate = self;
    self.healthTableView.rowHeight = 44;
    self.healthTableView.tableFooterView =[[UIView alloc] initWithFrame:CGRectZero];
    [self.healthTableView registerNib:[UINib nibWithNibName:@"MyhealthSchemeCell" bundle:nil] forCellReuseIdentifier:Identifier_healthSchemeCell];
    [self.view addSubview:self.healthTableView];
   

    self.explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, self.healthTableView.bottom+10, self.healthTableView.width, 100)];
    self.explainLabel.text = @"个人资料会影响您的最小运动量标准，进而影响您的运动效果，请谨慎修改";
    [self.explainLabel setTextColor:kColorContentColor];
    self.explainLabel.font = FONT(13);
    self.explainLabel.numberOfLines = 0;
    self.explainLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize size = [self.explainLabel sizeThatFits:CGSizeMake(self.explainLabel.frame.size.width, MAXFLOAT)];
    self.explainLabel.frame = CGRectMake(13, self.healthTableView.bottom+10, self.healthTableView.width, size.height);
    
    [self.view addSubview:self.explainLabel];
    
    
}

- (void)configData
{
    self.schemeArray = [[NSMutableArray alloc] initWithObjects:@"性别",@"出生年份",@"身高",@"体重", nil];
    self.contentArray = self.InfoArray;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyhealthSchemeCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_healthSchemeCell forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.schemeLabel.text = self.schemeArray[indexPath.row];
        cell.contentLabel.textColor = kColorContentColor;
        
        NSString *sexString = [NSString stringWithFormat:@"%@",self.contentArray[indexPath.row]];
        if ([sexString isEqualToString:@"M"]) {
            cell.contentLabel.text = @"男";
        }else{
            cell.contentLabel.text = @"女";
        }
        
        return cell;
    }
    
    if (indexPath.row == 1) {
        cell.schemeLabel.text = self.schemeArray[indexPath.row];
        cell.contentLabel.textColor = kColorContentColor;
        NSInteger year = 2015-[self.contentArray[indexPath.row] integerValue];
        NSString *yearString = [NSString stringWithFormat:@"%ld",(long)year];
        cell.contentLabel.text = yearString;
        return cell;
    }
    
        cell.schemeLabel.text = self.schemeArray[indexPath.row];
        cell.contentLabel.text = self.contentArray[indexPath.row];
        cell.contentLabel.textColor = kColorContentColor;
  
       return cell;
}

- (void)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onbtnToEvaluateVC:(id)sender
{
    MeasuremenViewController *MeasurementVC = [[MeasuremenViewController alloc] init];
    [self.navigationController pushViewController:MeasurementVC animated:YES];
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
