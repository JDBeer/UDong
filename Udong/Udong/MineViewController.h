//
//  MineViewController.h
//  Udong
//
//  Created by wildyao on 15/11/24.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "CommonViewController.h"
#import "ItemView.h"
#import "AccountmanagerViewController.h"
#import "EditNameView.h"

@interface MineViewController : CommonViewController
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)UIButton *headImageView;
@property (nonatomic, strong)UIButton *loginBtn;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UIImageView *sexImage;
@property (nonatomic, strong)UITableView *MineTableView;
@property (nonatomic, strong)NSMutableArray *imageArr;
@property (nonatomic, strong)NSArray *titleArr;
@property (nonatomic, strong)ItemView *itemView;
@property (nonatomic, strong)NSArray *userInfoArray;
@property (nonatomic, strong)NSString *feedBackCount;
@property (nonatomic, strong)UIView *banner;
@property (nonatomic, strong)UIButton *clearBtn;



@end
