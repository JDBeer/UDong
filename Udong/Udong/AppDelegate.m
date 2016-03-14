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
#import "Reachability.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialQQHandler.h"
#import "JPUSHService.h"


@interface AppDelegate ()
@property (nonatomic, strong) Reachability *internetReachability;
@property (nonatomic, strong) UIView *banner;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
//  获取前后台联系密钥
    
    [self configureSecretKey];
    
//  获取当前的软件版本
    
    [self getCurrentVersion];
    
//  上传当前程序的版本至服务器，判断是否需要更新
    
    [self judgeUpdateVersionOrNot];

//  获取程序入口的UserId，如果有直接获取，没有默认为0
    
    [self configureBaseData];
    
//  设置极光监听
    
    [self configJPush];
    
    [JPUSHService setupWithOption:launchOptions];
    
//  网络监测
    
    [self networkMonitor];
    
//  没有网络时候的顶部提示
    
    [self setupNoNetworkBanner];
    
//  配置友盟
    
    [self configUmeng];
    
//  判断程序的入口页
    
//  [self judgeEntranceRoot];
    
    NSLog(@"%@--%@---%@",[StorageManager getUserId],[StorageManager getAccountNumber],[StorageManager getLoginoutTime]);
    
    return YES;
}

- (void)configureSecretKey
{
     [APIServiceManager getSecretKey:@"1" completionBlock:^(id responObject) {
    
         
     NSDictionary *resultDicc = responObject[@"result"];
            
     //获取密钥，缓存到本地
     NSArray *keyDicc = [resultDicc allValues];
           
      for (NSDictionary *keydic in keyDicc) {
                id type = keydic[@"type"];
                NSInteger typenumber = [type integerValue];
                
                if (typenumber == 10) {
                    
                    //获取更新下载的地址
                    NSString *downLoadUrl = [NSString stringWithFormat:@"%@",keydic[@"secretnote"]];
                    [StorageManager saveDownloadUrl:downLoadUrl];
                }else if (typenumber == 8){
                    //获取移动端请求图片的地址
                    NSString *pictureUrl = [NSString stringWithFormat:@"%@",keydic[@"secretnote"]];
                    [StorageManager saveGetPictureUrl:pictureUrl];
                }else if (typenumber == 7){
                    
                    //获取移动端调用接口地址
                    NSString *url = [NSString stringWithFormat:@"%@",keydic[@"secretnote"]];
                    [StorageManager saveBaseUrl:url];
                }else{
                    //获取前后台联系密钥
                    NSString *secretKey =[NSString stringWithFormat:@"%@",keydic[@"secretnote"]];
                    [StorageManager saveSecretKey:secretKey];
                }
            }
            
        } failureBlock:^(NSError *error) {
            
        }];
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
    if ([StorageManager getUserId]) {
        
        NSString *idString = [NSString stringWithFormat:@"%@",[StorageManager getUserId]];
        if ([idString isEqualToString:@"0"]) {
            ShufflingPageViewController *shupageVC = [[ShufflingPageViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:shupageVC];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
        }else{
//            [APIServiceManager judgeEvaluationWithKey:[StorageManager getSecretKey] idString:[StorageManager getUserId] completionBlock:^(id responObject) {
//                if (responObject[@"eResult"]==[NSNull null]) {
//                    MeasuremenViewController *measureVC = [[MeasuremenViewController alloc] init];
//                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:measureVC];
//                    nav.navigationBarHidden = YES;
//                    self.window.rootViewController = nav;
//                }else{
//            
//                    MasterTabBarViewController *masterVC = [[MasterTabBarViewController alloc] init];
//                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:masterVC];
//                    nav.navigationBarHidden = YES;
//                    self.window.rootViewController = nav;
//                }
//            } failureBlock:^(NSError *error) {
//                NSLog(@"%@",error);
//            }];
            
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            
            
        }
    }
    
    if (![StorageManager getUserId]){
        ShufflingPageViewController *shupageVC = [[ShufflingPageViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:shupageVC];
        nav.navigationBarHidden = YES;
        self.window.rootViewController = nav;
    }

}

#pragma mark - 网络监测

- (void)networkMonitor
{
    /*
     Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the method reachabilityChanged will be called.
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    
    // 通用网络监测，适合不需要针对特定域名进行试网
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
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
        [self configureTextFieldWithReachability:reachability];
    }
}

- (void)configureTextFieldWithReachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    NSString *statusString = @"";
    
    switch (netStatus) {
        case NotReachable:        {         // 无网络
            statusString = NSLocalizedString(@"Access Not Available", @"Text field text for access is not available");
            /*
             Minor interface detail- connectionRequired may return YES even when the host is unreachable. We cover that up here...
             */
            connectionRequired = NO;
            
            [self showBanner];
            break;
        }
            
        case ReachableViaWWAN:        {         // 2G/3G/4G
            statusString = NSLocalizedString(@"Reachable WWAN", @"");
            
            [self hideBanner];
            break;
        }
        case ReachableViaWiFi:        {         // WiFi
            statusString= NSLocalizedString(@"Reachable WiFi", @"");
            
            [self hideBanner];
            break;
        }
    }
    
    if (connectionRequired) {
        NSString *connectionRequiredFormatString = NSLocalizedString(@"%@, Connection Required", @"Concatenation of status string with connection requirement");
        statusString = [NSString stringWithFormat:connectionRequiredFormatString, statusString];
    }
    
    NSLog(@"statusString: %@", statusString);
}

- (void)showBanner
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CurrentNetWorkNotReachable object:nil];
    
    
//    if ([StorageManager getUserId]) {
//        [self setupNoNetworkBanner];
//        [UIView animateWithDuration:0.5 animations:^{
//            self.banner.alpha = 0.9;
//        }];
//    } else {
//        [self setupNoNetworkBanner];
//        [UIView animateWithDuration:0.5 animations:^{
//            self.banner.alpha = 0.9;
//        }];
//    }
}

- (void)hideBanner
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CurrentNetWorkReacherable object:nil];
    
//    [UIView animateWithDuration:0.5 animations:^{
//        self.banner.alpha = 0.0;
//    }];
}

- (void)setupNoNetworkBanner
{
    if ([StorageManager getUserId]) {
        self.banner = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.window.width, 40)];
    } else {
        self.banner = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.window.width, 40)];
    }
    
    self.banner.backgroundColor = [UIColor orangeColor];
    [self.window addSubview:self.banner];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:ImageNamed(@"icon_quenstion")];
    iv.centerY = self.banner.height/2;
    iv.left = 15;
    [self.banner addSubview:iv];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLbl.text = @"当前网络不可用";
    [titleLbl sizeToFit];
    titleLbl.left = iv.right+10;
    titleLbl.centerY = self.banner.height/2;
    [self.banner addSubview:titleLbl];
    
    if ([NetworkMonitor sharedNetworkMonitor].currentNetworkStatus == NotReachable) {
        self.banner.alpha = 0.9;
    } else {
        self.banner.alpha = 0.0;
    }
}

- (void)configUmeng
{
    [UMSocialData setAppKey:UMENG_APPKEY];
    
    [UMSocialWechatHandler setWXAppId:WeiChat_Key appSecret:WeiChat_Secret url:Company_Url];
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    [UMSocialQQHandler setQQWithAppId:QQ_Key appKey:QQ_Secret url:Company_Url];
}

//分享功能的系统回调

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

- (void)configJPush
{
    
    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound |UIUserNotificationTypeAlert) categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:  (UIRemoteNotificationTypeBadge |
             UIRemoteNotificationTypeSound |
            UIRemoteNotificationTypeAlert) categories:nil];
    }
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [JPUSHService registerDeviceToken:deviceToken];
    
    // 获得regisitionID
    NSString *registrationID = [JPUSHService registrationID];
    [StorageManager saveRegistrationId:registrationID];
   
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
   
    [JPUSHService setBadge:0];
   // [application setApplicationIconBadgeNumber:0];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


- (void)getCurrentVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
    
    [StorageManager saveIOSVersion:appVersion];
}


- (void)judgeUpdateVersionOrNot
{
    
    [APIServiceManager VersionUpdateWithKey:[StorageManager getSecretKey] type:@"1" version:[StorageManager getIOSVersion] completionBlock:^(id responObject) {
        
        if ([responObject[@"flag"] isEqualToString:@"100100"])
        {
            id update = responObject[@"update_flag"];
            NSInteger update_flag = [update integerValue];
            
            //flag为0,非强制更新
            if (update_flag == 0)
            {
                UIAlertController *AlertVC = [UIAlertController alertControllerWithTitle:@"检测到新版本" message:@"是否更新" preferredStyle:UIAlertControllerStyleAlert];
                
                [AlertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
                    
                    [self judgeEntranceRoot];
                    
                }]];
                
                [AlertVC addAction:[UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self UpdateVersion];
                    
                }]];
                
                UIViewController *VC = [UIApplication sharedApplication].keyWindow.rootViewController;
                
                [VC presentViewController:AlertVC animated:true completion:nil];
                
            //flag不为0,强制更新
                
            }else{
                
                UIAlertController *AlertVC = [UIAlertController alertControllerWithTitle:@"检测到新版本" message:@"是否更新" preferredStyle:UIAlertControllerStyleAlert];
                
                [AlertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
                    
                    exit(0);
                    
                }]];
                
                [AlertVC addAction:[UIAlertAction actionWithTitle:@"强制更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self UpdateVersion];
                    
                }]];
                
                UIViewController *VC = [UIApplication sharedApplication].keyWindow.rootViewController;
                
                [VC presentViewController:AlertVC animated:true completion:nil];
                
            }
        //返回100600，当前为最新版本，直接进主界面
        }else{
            
            [self judgeEntranceRoot];
            
        }
     }failureBlock:^(NSError *error) {
        NSLog(@"%@",error);;
     }];
}

- (void)UpdateVersion
{
    
    NSURL *updateUrl = [NSURL URLWithString:@"https://app.hzzkkj.com"];
    [[UIApplication sharedApplication] openURL:updateUrl];
    
}

#pragma mark - dealloc

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
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
