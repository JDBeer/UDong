//
//  EffectTableViewCell.m
//  Udong
//
//  Created by wildyao on 16/1/21.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import "EffectTableViewCell.h"

@implementation EffectTableViewCell

- (void)awakeFromNib
{
    
    self.timeLabel.textColor = UIColorFromHex(0x595960);
    self.headImageView.layer.cornerRadius = self.headImageView.width/2;
    self.headImageView.layer.masksToBounds = YES;
    
    self.label1.textColor = UIColorFromHex(0x474747);
    self.pointlabel.text = @"点";
    self.label2.textColor = UIColorFromHex(0x474747);
    self.precentLabel.text = @"%";
    self.continuelabel.textColor = UIColorFromHex(0xA1A1A1);
    self.minuteLabel.textColor = UIColorFromHex(0xA1A1A1);
    self.effectSportLebel.textColor = UIColorFromHex(0xA1A1A1);
    self.stepLabel.textColor = UIColorFromHex(0xA1A1A1);
    
    self.number3.textColor = UIColorFromHex(0x474747);
    self.number4.textColor = UIColorFromHex(0x474747);
    
    self.lineView1.backgroundColor = UIColorFromHex(0xDDDDDD);
    self.lineView2.backgroundColor = UIColorFromHex(0xDDDDDD);
    self.lineView3.backgroundColor = UIColorFromHex(0xDDDDDD);
    self.lineView4.backgroundColor = UIColorFromHex(0xDDDDDD);
    self.lineView5.backgroundColor = UIColorFromHex(0xDDDDDD);
    self.lineView6.backgroundColor = UIColorFromHex(0xDDDDDD);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
