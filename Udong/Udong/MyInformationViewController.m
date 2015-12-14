//
//  MyInformationViewController.m
//  Udong
//
//  Created by wildyao on 15/12/8.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "MyInformationViewController.h"
#define Identifier_mainTableViewCell @"mainTableViewCell"

@interface MyInformationViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MyInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self configView];
    
}
- (void)configNav
{
    self.navigationItem.title = @"消息";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 20, 20)];
    [btn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)configView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = HEIGHT_CELL_DEFAULT;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier_mainTableViewCell];
    [self.view addSubview:self.tableView];
    
    UIImage *image1 = [UIImage imageNamed:@"message_icon_assistant"];
    UIImage *image2 = [UIImage imageNamed:@"message_icon_remind"];
    self.imageArray = [[NSMutableArray alloc] init];
    [self.imageArray addObject:image1];
    [self.imageArray addObject:image2];
    self.titleArray = [[NSArray alloc] initWithObjects:@"优优小助手",@"运动提醒", nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_mainTableViewCell forIndexPath:indexPath];
    NSLog(@"%@---%@",self.imageArray,self.titleArray);
    if (indexPath.row == 0) {
        cell.imageView.image = self.imageArray[0];
        cell.textLabel.text = self.titleArray[0];
        NSLog(@"%@",cell.textLabel.text);
    }
    if (indexPath.row == 1) {
        cell.imageView.image = self.imageArray[1];
        cell.textLabel.text = self.titleArray[1];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setSeparatorInset:UIEdgeInsetsZero];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
