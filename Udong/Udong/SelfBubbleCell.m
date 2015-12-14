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
    self.SelfheadImageView.layer.cornerRadius = 20;
    self.SelfheadImageView.layer.masksToBounds =YES;
    
    self.SelfbackgroundImageView.image = [[UIImage imageNamed:@"speech_bubble_blue"] stretchableImageWithLeftCapWidth:25 topCapHeight:21];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
