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
    self.OtherHeadImageView.layer.cornerRadius = 20;
    self.OtherHeadImageView.layer.masksToBounds = YES;
    
    self.OtherBacngroundImageView.image = [[UIImage imageNamed:@"speech_bubble_blue_gray"] stretchableImageWithLeftCapWidth:25 topCapHeight:21];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
