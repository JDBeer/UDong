//
//  InfoCell.m
//  Udong
//
//  Created by wildyao on 16/1/18.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "InfoCell.h"

@implementation InfoCell

- (void)awakeFromNib {
    self.headImage.layer.cornerRadius = 5;
    self.headImage.layer.masksToBounds = YES;
    self.badgeBtn.layer.cornerRadius = self.badgeBtn.width/2;
    self.badgeBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
