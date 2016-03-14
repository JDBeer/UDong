//
//  ArticleTableViewCell.h
//  Udong
//
//  Created by wildyao on 16/1/19.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *ViewView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *readLabel;
@property (weak, nonatomic) IBOutlet UIImageView *footImage;
@property (weak, nonatomic) IBOutlet UIView *AView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLabelWidth;
@property (weak, nonatomic) IBOutlet UIView *LineView;

@end
