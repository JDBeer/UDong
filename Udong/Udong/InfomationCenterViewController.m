//
//  InfomationCenterViewController.m
//  Udong
//
//  Created by wildyao on 16/1/19.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "InfomationCenterViewController.h"
#import "ArticleViewController.h"
#import "WordTableViewCell.h"
#import "PictureTableViewCell.h"
#import "ArticleTableViewCell.h"
#import "UIImageView+WebCache.h"
#define Identifier_WordTableViewCell @"WordTableViewCell"
#define Identifier_PictureTableViewCell @"PictureTableViewCell"
#define Identifier_ArticleTableViewCell @"ArticleTableViewCell"


@interface InfomationCenterViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation InfomationCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self configView];
    
}

- (void)configView
{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = UIColorFromHexWithAlpha(0xCCCCCC, 0.5);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"WordTableViewCell" bundle:nil] forCellReuseIdentifier:Identifier_WordTableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"PictureTableViewCell" bundle:nil] forCellReuseIdentifier:Identifier_PictureTableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"ArticleTableViewCell" bundle:nil] forCellReuseIdentifier:Identifier_ArticleTableViewCell];
    
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *typeString = self.infoArray[indexPath.row][@"type"];
    NSInteger type = [typeString integerValue];
    
    if (type == 0) {
        WordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_WordTableViewCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//     设置时间
        NSString *time = self.infoArray[indexPath.row][@"sendTime"];
        NSInteger aa = [time integerValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:aa-8*3600];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy年MM月dd日 hh:mm"];
        
        NSString *dateString = [formatter stringFromDate:date];
        
        cell.timeLabel.text = dateString;
//     根据时间的长度设置背景的宽度
        CGSize size = [dateString sizeWithAttributes:@{NSFontAttributeName:FONT(11)}];
        cell.timelabelWidth.constant = size.width+6;
        
        
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Picture_Url,self.headImageString]] placeholderImage:ImageNamed(@"avatar_default")];
        
        cell.contentLabel.text = self.infoArray[indexPath.row][@"messageInfo"];
        
        return cell;
    }else if (type == 1){
        
        PictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_PictureTableViewCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        NSString *time = self.infoArray[indexPath.row][@"sendTime"];
        NSInteger aa = [time integerValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:aa-8*3600];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy年MM月dd日 hh:mm"];
        
        NSString *dateString = [formatter stringFromDate:date];
        
        cell.timeLabel.text = dateString;
        
        CGSize size = [dateString sizeWithAttributes:@{NSFontAttributeName:FONT(11)}];
        cell.timeLabelWidth.constant = size.width+6;
    
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Picture_Url,self.headImageString]] placeholderImage:ImageNamed(@"avatar_default")];
        NSString *urlString = self.infoArray[indexPath.row][@"messageInfo"];
        
        [cell.contentImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Picture_Url,urlString]] placeholderImage:ImageNamed(@"progress-bar_1")];
        
        return cell;
    }else{
        ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_ArticleTableViewCell forIndexPath:indexPath];
        
        
        NSString *time = self.infoArray[indexPath.row][@"sendTime"];
        NSInteger aa = [time integerValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:aa-8*3600];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy年MM月dd日 hh:mm"];
        
        NSString *dateString = [formatter stringFromDate:date];
        
        cell.timeLabel.text = dateString;
        
        CGSize size = [dateString sizeWithAttributes:@{NSFontAttributeName:FONT(11)}];
        cell.timeLabelWidth.constant = size.width+6;
        
        cell.titleLabel.text = self.infoArray[indexPath.row][@"article"][@"title"];
        NSString *urlString = self.infoArray[indexPath.row][@"article"][@"picUrl"];
        [cell.pictureImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Picture_Url,urlString]] placeholderImage:ImageNamed(@"progress-bar_1")];
        cell.contentLabel.text = self.infoArray[indexPath.row][@"messageInfo"];
        cell.readLabel.text = @"阅读原文";
        cell.footImage.image = ImageNamed(@"icon_more");
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *typeString = self.infoArray[indexPath.row][@"type"];
    NSInteger type = [typeString integerValue];
    
    if (type == 0) {
        NSString *content =  self.infoArray[indexPath.row][@"messageInfo"];
//      根据文字动态设置行高，根据约束适配气泡和文字行数
        float height = [content boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]} context:nil].size.height;
        return height+70;
    }else if (type == 1){
       
        return 170;
    }else{
        return 330;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *typeString = self.infoArray[indexPath.row][@"type"];
    NSInteger type = [typeString integerValue];
    
    if (type == 2) {
        NSString *ArticleID =[NSString stringWithFormat:@"%@",self.infoArray[indexPath.row][@"article"][@"id"]];
        
//     获取文章id，并获取详情
        [APIServiceManager GetArticleDetailWithKey:[StorageManager getSecretKey] articleId:ArticleID completionBlock:^(id responObject) {
            if ([responObject[@"flag"] isEqualToString:@"100100"]) {
                NSDictionary *articleDic = responObject[@"articleDetail"];
                
                ArticleViewController *articleVC = [[ArticleViewController alloc] init];
                articleVC.infoDictionary = articleDic;
                
                [self.navigationController pushViewController:articleVC animated:YES];
            }
        } failureBlock:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)configNav
{
    self.view.backgroundColor = kColorWhiteColor;
    
    self.navigationItem.title = @"消息中心";
    self.navigationController.navigationBar.shadowImage = nil;
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
