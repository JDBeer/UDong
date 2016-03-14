//
//  NetworkMonitor.m
//  Udong
//
//  Created by wildyao on 15/11/15.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "NetworkMonitor.h"

@implementation NetworkMonitor

+ (NetworkMonitor *)sharedNetworkMonitor
{
    static NetworkMonitor *sharedMonitor = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedMonitor = [[NetworkMonitor alloc] init];
    });
    return sharedMonitor;
}

- (id)init {
    self = [super init];
    if (self) {
        [self setupNetworkMonitor];
    }
    return self;
}

- (void)setupNetworkMonitor
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
}

- (NetworkStatus)currentNetworkStatus
{
    return self.internetReachability.currentReachabilityStatus;
}

- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    if (reachability == self.internetReachability) {
        [self configureWithReachability:reachability];
    }
}


- (void)configureWithReachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    NSString *statusString = @"";
    
    switch (netStatus) {
        case NotReachable:        {
            statusString = NSLocalizedString(@"Access Not Available", @"Text field text for access is not available");
            /*
             Minor interface detail- connectionRequired may return YES even when the host is unreachable. We cover that up here...
             */
            connectionRequired = NO;
            
            break;
        }
        case ReachableViaWWAN: {
            statusString = NSLocalizedString(@"Reachable WWAN", @"");
            NSLog(@"2G/3G/4G");
            break;
        }
        case ReachableViaWiFi: {
            statusString= NSLocalizedString(@"Reachable WiFi", @"");
            NSLog(@"WiFi");
            break;
        }
    }
    
    // ...
    if (connectionRequired) {
        NSString *connectionRequiredFormatString = NSLocalizedString(@"%@, Connection Required", @"Concatenation of status string with connection requirement");
        statusString= [NSString stringWithFormat:connectionRequiredFormatString, statusString];
        NSLog(@"statusString: %@", statusString);
    }
}


@end
