//
//  CountDownCapsulation.h
//  Udong
//
//  Created by wildyao on 15/11/15.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DidFinishedCountdownNotification @"DidFinishedCountdownNotification"
#define OnDoingCountdownNotification @"OnDoingCountdownNotification"

@interface CountDownCapsulation : NSObject
@property (nonatomic, strong) dispatch_source_t timer;

+ (CountDownCapsulation *)sharedCapsulation;
+ (void)startCountDown:(int)timeout;
+ (void)invalidateTimer;
+ (BOOL)isTimerValidate;

@end
