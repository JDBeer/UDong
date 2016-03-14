//
//  NSTimer+BlockTimer.h
//  PalmMedicine
//
//  Created by wildyao on 15/4/14.
//  Copyright (c) 2015年 Wild Yaoyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (BlockTimer)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                     block:(void(^)())block
                                   repeats:(BOOL)repeats;

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval
                                      block:(void(^)())block
                                    repeats:(BOOL)repeats;

@end
