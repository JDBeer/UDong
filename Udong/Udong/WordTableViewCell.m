//
//  WordTableViewCell.m
//  Udong
//
//  Created by wildyao on 16/1/19.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "WordTableViewCell.h"

@implementation WordTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = kColorClearColor;
    
    self.headImage.layer.cornerRadius = 5;
    self.headImage.layer.masksToBounds = YES;
    
    self.bgImage.image = [[UIImage imageNamed:@"speech_bubble_blue_gray"] stretchableImageWithLeftCapWidth:25 topCapHeight:21];
    self.timeLabel.layer.cornerRadius = 5;
    self.timeLabel.layer.masksToBounds = YES;
    self.timeLabel.backgroundColor = UIColorFromHex(0xC6C6C6);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
