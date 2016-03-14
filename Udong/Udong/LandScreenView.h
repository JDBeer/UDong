//
//  LandScreenView.h
//  Udong
//
//  Created by wildyao on 16/1/9.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LandScreenView : UIView

@property (nonatomic, strong)NSMutableArray *coordinateArray;//坐标数组

- (id)initWithFrame:(CGRect)frame width:(NSInteger)width length:(NSInteger)length count:(NSInteger)count interval:(NSInteger)interval dataArray:(NSMutableArray *)dataArray pointArray:(NSMutableArray *)pointArray type:(NSInteger)type;

@end
