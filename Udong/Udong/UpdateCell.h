//
//  UpdateCell.h
//  Udong
//
//  Created by wildyao on 15/11/26.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *titileLabel;

@property (weak, nonatomic) IBOutlet UILabel *hiddenLabel;
@property (weak, nonatomic) IBOutlet UIButton *updateBtn;

@end
