//
//  SettingViewController.h
//  Udong
//
//  Created by wildyao on 15/11/26.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *accountArray;
@property (nonatomic, strong)NSMutableArray *aboutArray;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIButton *exitbtn;
@property (nonatomic, strong)NSDictionary *baseDataDictionary;
@property (nonatomic, strong)NSString *VersionString;
@property (nonatomic, strong)NSMutableArray *chatInfoArray;


@end
