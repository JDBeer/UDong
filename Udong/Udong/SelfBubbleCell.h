//
//  SelfBubbleCell.h
//  Udong
//
//  Created by wildyao on 15/12/12.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfBubbleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *SelfheadImageView;
@property (weak, nonatomic) IBOutlet UIImageView *SelfbackgroundImageView;

@property (weak, nonatomic) IBOutlet UILabel *SelfChatLabel;
@property (weak, nonatomic) IBOutlet UILabel *SelfNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backImageViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidth;

@end
