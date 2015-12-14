//
//  AppDelegate.m
//  Udong
//
//  Created by wildyao on 15/11/16.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "AppDelegate.h"
#import "OpenUDID.h"
#import "sys/utsname.h"
#import "LoginViewController.h"
#import "ShufflingPageViewController.h"
#import "MeasuremenViewController.h"
#import "MasterTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureSecretKey];
    [self configureBaseData];
    [self judgeEntranceRoot];
    NSLog(@"%@--%@",[StorageManager getUserId],[StorageManager getAccountNumber]);
    
    return YES;
}

- (void)configureSecretKey
{
    if (![StorageManager getSecretKey]) {
        [APIServiceManager getSecretKey:OriginSecretKey Secretkeytype:@"0" completionBlock:^(id responObject) {
            
            NSArray *arrry = responObject[@"rows"];
            for (NSDictionary *dic in arrry) {
                self.secretString = dic[@"sekey"];
                [StorageManager saveSecretKey:dic[@"sekey"]];
                
            }
        } failureBlock:^(NSError *error) {
            
        }];
    }
}

- (void)configureBaseData
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:UserIdKey]) {
        self.userid = @"0";
        [StorageManager saveUserId:self.userid];
    }
}

- (void)judgeEntranceRoot
{
//    if ([StorageManager getAccountNumber]) {
//        [APIServiceManager judgeEvaluationWithKey:[StorageManager getSecretKey] idString:[StorageManager getUserId] completionBlock:^(id responObject) {
//            if (responObject[@"eResult"]==[NSNull null]) {
//                MeasuremenViewController *measureVC = [[MeasuremenViewController alloc] init];
//                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:measureVC];
//                nav.navigationBarHidden = YES;
//                self.window.rootViewController = nav;
//            }else{
//                MasterTabBarViewController *masterVC = [[MasterTabBarViewController alloc] init];
//                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:masterVC];
//                nav.navigationBarHidden = YES;
//                self.window.rootViewController = nav;
//            }
//        } failureBlock:^(NSError *error) {
//            NSLog(@"%@",error);
//        }];
//    }
    
    if ([StorageManager getUserId]) {
        
        NSString *idString = [NSString stringWithFormat:@"%@",[StorageManager getUserId]];
        if ([idString isEqualToString:@"0"]) {
            ShufflingPageViewController *shupageVC = [[ShufflingPageViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:shupageVC];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
        }else{
            [APIServiceManager judgeEvaluationWithKey:[StorageManager getSecretKey] idString:[StorageManager getUserId] completionBlock:^(id responObject) {
                
                if (responObject[@"eResult"]==[NSNull null]) {
                    MeasuremenViewController *measureVC = [[MeasuremenViewController alloc] init];
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:measureVC];
                    nav.navigationBarHidden = YES;
                    self.window.rootViewController = nav;
                }else{
                    MasterTabBarViewController *masterVC = [[MasterTabBarViewController alloc] init];
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:masterVC];
                    nav.navigationBarHidden = YES;
                    self.window.rootViewController = nav;
                }
            } failureBlock:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        }
    }
    
    if (![StorageManager getUserId]){
        ShufflingPageViewController *shupageVC = [[ShufflingPageViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:shupageVC];
        nav.navigationBarHidden = YES;
        self.window.rootViewController = nav;
    }

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
