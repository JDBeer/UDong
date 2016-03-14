//
//  MyInformationViewController.h
//  Udong
//
//  Created by wildyao on 15/12/8.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInformationViewController : UIViewController
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *DataArray;
@property (nonatomic, strong)NSString *timeString;
@property (nonatomic, assign)NSInteger tag;


@end
