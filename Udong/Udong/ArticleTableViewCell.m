//
//  ArticleTableViewCell.m
//  Udong
//
//  Created by wildyao on 16/1/19.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "ArticleTableViewCell.h"

@implementation ArticleTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = kColorClearColor;
    
    self.AView.layer.cornerRadius = 10;
    self.AView.layer.masksToBounds = YES;
    self.AView.layer.borderColor = UIColorFromHex(0x999999).CGColor;
    self.AView.layer.borderWidth = 1;
    
    self.titleLabel.textColor = UIColorFromHex(0x333333);
    self.contentLabel.textColor = UIColorFromHex(0x666666);
    
    self.readLabel.textColor = UIColorFromHex(0x333333);
    
    self.timeLabel.layer.cornerRadius = 5;
    self.timeLabel.layer.masksToBounds = YES;
    self.timeLabel.backgroundColor = UIColorFromHex(0xC6C6C6);
    
    self.LineView.backgroundColor = UIColorFromHex(0xCCCCCC);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
