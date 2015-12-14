//
//  HeadImageCell.m
//  Udong
//
//  Created by wildyao on 15/11/30.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "HeadImageCell.h"

@implementation HeadImageCell

- (void)awakeFromNib {
    self.headimage.layer.cornerRadius = self.headimage.height/2;
    self.headimage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
