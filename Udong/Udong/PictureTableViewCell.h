//
//  PictureTableViewCell.h
//  Udong
//
//  Created by wildyao on 16/1/19.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLabelWidth;

@end
