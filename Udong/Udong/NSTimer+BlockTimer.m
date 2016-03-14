//
//  NSTimer+BlockTimer.m
//  PalmMedicine
//
//  Created by wildyao on 15/4/14.
//  Copyright (c) 2015年 Wild Yaoyao. All rights reserved.
//

#import "NSTimer+BlockTimer.h"

@implementation NSTimer (BlockTimer)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                     block:(void(^)())block
                                   repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval
                             block:(void(^)())block
                           repeats:(BOOL)repeats
{
    return [self timerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (void)blockInvoke:(NSTimer *)timer {
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}

@end
