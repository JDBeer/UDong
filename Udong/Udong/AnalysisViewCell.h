//
//  AnalysisViewCell.h
//  Udong
//
//  Created by wildyao on 16/1/25.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnalysisViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UILabel *chooseLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UILabel *effectLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishLabel;
@property (weak, nonatomic) IBOutlet UILabel *unfinishLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishDays;
@property (weak, nonatomic) IBOutlet UILabel *unfinishDays;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
