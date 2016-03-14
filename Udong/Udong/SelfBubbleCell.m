//
//  SelfBubbleCell.m
//  Udong
//
//  Created by wildyao on 15/12/12.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "SelfBubbleCell.h"

@implementation SelfBubbleCell

- (void)awakeFromNib {
    self.SelfheadImageView.layer.cornerRadius = 16.5;
    self.SelfheadImageView.layer.masksToBounds =YES;
    
    self.SelfbackgroundImageView.image = [[UIImage imageNamed:@"message_right_bg_pressed.9"] stretchableImageWithLeftCapWidth:40 topCapHeight:30];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
