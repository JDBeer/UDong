//
//  MobileBlindViewController.m
//  Udong
//
//  Created by wildyao on 15/11/30.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "MobileBlindViewController.h"
#import "HeadLabelCell.h"
#import "BlindVertifyViewController.h"
#define Identifier_headLabelCell @"headLabelCell"
#define Identifier_MainCell @"MainCell"

@interface MobileBlindViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MobileBlindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self configView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configData];
}

- (void)configNav
{
    self.navigationItem.title = @"手机绑定";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 20, 20)];
    [btn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

}

- (void)configView
{
    self.MobileBlindTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.MobileBlindTableView.delegate = self;
    self.MobileBlindTableView.dataSource = self;
    self.MobileBlindTableView.rowHeight = 44;
    self.MobileBlindTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.MobileBlindTableView registerNib:[UINib nibWithNibName:@"HeadLabelCell" bundle:nil] forCellReuseIdentifier:Identifier_headLabelCell];
    [self.MobileBlindTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier_MainCell];
    [self.view addSubview:self.MobileBlindTableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        HeadLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_headLabelCell forIndexPath:indexPath];
        cell.titleLabel.text = @"手机";
        cell.detailLabel.text = self.phoneString;
        cell.detailLabel.textColor = kColorContentColor;
        cell.titleLabel.textColor = kColorCellTextColor;
        return cell;
    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_MainCell forIndexPath:indexPath];
        cell.textLabel.text = @"更换绑定手机";
        cell.textLabel.textColor = kColorCellTextColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        BlindVertifyViewController *blindVC = [[BlindVertifyViewController alloc] init];
        [self.navigationController pushViewController:blindVC animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)configData
{
    
}

- (void)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
