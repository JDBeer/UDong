//
//  AccountmanagerViewController.h
//  Udong
//
//  Created by wildyao on 15/11/30.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountmanagerViewController : UIViewController
@property (nonatomic, strong)UITableView *AccountTableView;
@property (nonatomic, strong)NSMutableArray *labelArray;
@property (nonatomic, strong)NSMutableArray *detailArray;
@property (nonatomic, strong)UIPickerView *pickView;
@property (nonatomic, strong)NSMutableArray *leftArray;
@property (nonatomic, strong)NSMutableArray *rightArray;
@property (nonatomic, strong)NSArray *provinceArray;
@property (nonatomic, strong)NSDictionary *cityDictionary;
@property (nonatomic, strong)NSArray *selectedCityArray;
@property (nonatomic, strong)NSString *nickNameString;
@property (nonatomic, strong)UIView *pickViewView;
@property (nonatomic, strong)UIView *contentView;

@end
