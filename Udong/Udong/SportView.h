//
//  SportView.h
//  Udong
//
//  Created by wildyao on 15/12/21.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportView : UIView

@property (nonatomic, strong)NSMutableArray *coordinateArray;//坐标数组

//传入视图的长度，宽度，点的个数，间距，一个下面的时间数组
- (id)initWithFrame:(CGRect)frame width:(NSInteger)width length:(NSInteger)length count:(NSInteger)count interval:(NSInteger)interval dataArray:(NSMutableArray *)dataArray pointArray:(NSMutableArray *)pointArray type:(NSInteger)type;



@end
