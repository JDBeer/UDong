//
//  LandScreenViewController.h
//  Udong
//
//  Created by wildyao on 16/1/9.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LandScreenView.h"

@interface LandScreenViewController : UIViewController
@property (nonatomic, strong)NSMutableArray *pointArray;
@property (nonatomic, strong)LandScreenView *landScreenView;
@property (nonatomic, strong)NSMutableArray *timeArray;
@property (nonatomic, strong)NSString *titleString;

@property (nonatomic, strong)NSString *nullString;

@end
