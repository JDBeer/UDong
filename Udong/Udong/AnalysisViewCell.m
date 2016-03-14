//
//  AnalysisViewCell.m
//  Udong
//
//  Created by wildyao on 16/1/25.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "AnalysisViewCell.h"

@implementation AnalysisViewCell

- (void)awakeFromNib {
    self.blueView.layer.cornerRadius = 3;
    self.blueView.layer.masksToBounds = YES;
    self.blueView.backgroundColor = UIColorFromHex(0x2FBEC8);
    self.chooseLabel.textColor = UIColorFromHex(0x363636);
    self.finishLabel.textColor = UIColorFromHex(0xFFCB2D);
    self.finishLabel.textColor = UIColorFromHex(0x999999);
    self.unfinishLabel.textColor = UIColorFromHex(0x999999);
    self.finishDays.textColor = UIColorFromHex(0x999999);
    self.unfinishDays.textColor = UIColorFromHex(0x999999);
    self.imageView2.image = ImageNamed(@"icon_bulb");
    self.descriptionLabel.textColor = UIColorFromHex(0xA5A5A5);
    self.lineView.backgroundColor = UIColorFromHex(0xEEEEEE);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
