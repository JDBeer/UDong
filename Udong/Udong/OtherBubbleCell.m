//
//  OtherBubbleCell.m
//  Udong
//
//  Created by wildyao on 15/12/12.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "OtherBubbleCell.h"

@implementation OtherBubbleCell

- (void)awakeFromNib {
    self.OtherHeadImageView.layer.cornerRadius = 17;
    self.OtherHeadImageView.layer.masksToBounds = YES;
    
    self.OtherBacngroundImageView.image = [[UIImage imageNamed:@"message_left_bg_pressed.9"] stretchableImageWithLeftCapWidth:40 topCapHeight:30];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
