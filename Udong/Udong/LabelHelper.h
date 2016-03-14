//
//  LabelHelper.h
//  Udong
//
//  Created by wildyao on 16/3/9.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LabelHelper : NSObject


//获取对应文字和字体大小的label宽高
+ (CGSize)getSizeWith:(NSString *)string font:(NSInteger)font;


@end
