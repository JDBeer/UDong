//
//  RulerView.h
//  Udong
//
//  Created by wildyao on 15/12/3.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RulerView : UIView

- (id)initWithFrame:(CGRect)frame width:(NSInteger)width length:(NSInteger)length count:(NSInteger)count interval:(NSInteger)interval dataArray:(NSMutableArray *)dataArray;

@end
