//
//  NetworkMonitor.h
//  Udong
//
//  Created by wildyao on 15/11/15.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface NetworkMonitor : NSObject

+ (NetworkMonitor *)sharedNetworkMonitor;

- (NetworkStatus)currentNetworkStatus;

@property (nonatomic, strong) Reachability *internetReachability;

@end
