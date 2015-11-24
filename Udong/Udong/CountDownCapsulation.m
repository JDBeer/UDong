//
//  CountDownCapsulation.m
//  Udong
//
//  Created by wildyao on 15/11/15.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "CountDownCapsulation.h"

@implementation CountDownCapsulation

+ (CountDownCapsulation *)sharedCapsulation
{
    static CountDownCapsulation *sharedCapsulation = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred,^{
        sharedCapsulation = [[CountDownCapsulation alloc] init];
    });
    return sharedCapsulation;
}

+ (void)startCountDown:(int)timeout
{
    [[self sharedCapsulation] startCountDown:timeout];
}

+ (void)invalidateTimer
{
    [[self sharedCapsulation] invalidateTimer];
}

+ (BOOL)isTimerValidate
{
   return [[self sharedCapsulation] isTimerValidate];
}

- (void)startCountDown:(int)timeoutTime
{
    __block int timeout = timeoutTime;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        int seconds = timeout%240;
        
        if (timeout <= 0) {
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:DidFinishedCountdownNotification object:@(seconds)];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:OnDoingCountdownNotification object:@(seconds)];
            });
            
            timeout--;
        }
    });

    dispatch_resume(_timer);
}

- (void)invalidateTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

- (BOOL)isTimerValidate
{
    return (_timer != nil);
}

@end
