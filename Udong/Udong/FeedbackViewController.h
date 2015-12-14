//
//  FeedbackViewController.h
//  Udong
//
//  Created by wildyao on 15/12/11.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackViewController : UIViewController
@property (nonatomic, strong)UITableView *chatTableView;
@property (nonatomic, strong)UIView *messageView;
@property (nonatomic, strong)UITextField *messageTf;
@property (nonatomic, strong)UIButton *pictureBtn;
@property (nonatomic, strong)UIButton *confirmBtn;
@property (nonatomic, strong)NSMutableArray *InfoArray;

@end
