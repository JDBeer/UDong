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
    if (IS_IPHONE_6P) {
        self.left.constant = 20;
    }else if (IS_IPHONE_6){
        self.left.constant = 17;
    }else if (IS_IPHONE_5){
        self.left.constant = 15;
    }else{
        self.left.constant = 15;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
