//
//  InfoCell.h
//  Udong
//
//  Created by wildyao on 16/1/18.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *badgeBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
