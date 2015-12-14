//
//  MineViewController.h
//  Udong
//
//  Created by wildyao on 15/11/24.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "CommonViewController.h"
#import "ItemView.h"

@interface MineViewController : CommonViewController
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)UIImageView *headImageView;
@property (nonatomic, strong)UIButton *loginBtn;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UIImageView *sexImage;
@property (nonatomic, strong)UITableView *MineTableView;
@property (nonatomic, strong)NSMutableArray *imageArr;
@property (nonatomic, strong)NSArray *titleArr;
@property (nonatomic, strong)ItemView *itemView;
@property (nonatomic, strong)NSArray *userInfoArray;

@end
