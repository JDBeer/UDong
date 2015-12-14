//
//  MYHealthSchemeViewController.h
//  Udong
//
//  Created by wildyao on 15/11/27.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYHealthSchemeViewController : UIViewController
@property (nonatomic, strong)UITableView *healthTableView;
@property (nonatomic, strong)NSMutableArray *schemeArray;
@property (nonatomic, strong)NSArray *contentArray;
@property (nonatomic, strong)UILabel *explainLabel;
@property (nonatomic, strong)NSArray *InfoArray;

@end
