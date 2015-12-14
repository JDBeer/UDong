//
//  TicklingCell.m
//  Udong
//
//  Created by wildyao on 15/11/26.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "TicklingCell.h"

@implementation TicklingCell

- (void)awakeFromNib {
    self.titlelabel.textColor = kColorCellTextColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
