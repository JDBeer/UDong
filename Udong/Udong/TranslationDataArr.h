//
//  TranslationDataArr.h
//  Udong
//
//  Created by wildyao on 15/12/28.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TranslationDataArr : NSObject

//把本地的数据封装成服务端需要的json串
+ (NSString *)ChangeArrayToString:(NSInteger)time;

//把服务端的数据转换成本地需要的格式,并存入本地
+ (void)changeServerDataToLocal:(NSDictionary *)serverDic;

@end
