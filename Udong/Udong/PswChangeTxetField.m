//
//  PswChangeTxetField.m
//  Udong
//
//  Created by wildyao on 15/11/27.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "PswChangeTxetField.h"

@implementation PswChangeTxetField
{
    CGFloat _inset;
}

- (id)initWithFrame:(CGRect)frame leftView:(UIView *)leftView inset:(CGFloat)inset;

{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _inset = inset;
    }
    return self;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += _inset;
    return iconRect;

}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, _inset-5, -1, 0))];
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, _inset-5, -1, 0))];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
