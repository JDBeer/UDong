//
//  AnalysisViewController.h
//  Udong
//
//  Created by wildyao on 15/11/24.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "CommonViewController.h"
#import "AnalysisChatView.h"
#import "AnalysisView.h"

@interface AnalysisViewController : CommonViewController
@property (nonatomic, strong)UIImageView *bgImageView;
@property (nonatomic, strong)UIButton *monthBtn;
@property (nonatomic, strong)UIButton *weekBtn;
@property (nonatomic, strong)UIButton *threeMonthBtn;
@property (nonatomic, strong)UIView *whiteView;
@property (nonatomic, strong)AnalysisView *analysisView;
@property (nonatomic, strong)AnalysisChatView *chatView;
@property (nonatomic, strong)NSMutableArray *pointArray;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSDictionary *dataDic;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UISwipeGestureRecognizer *leftTap;
@property (nonatomic, strong)UISwipeGestureRecognizer *rightTap;
@property (nonatomic, assign)int tag;
@property (nonatomic, strong)UIView *banner;
@end

