//
//  MasterTabBarViewController.m
//  Udong
//
//  Created by wildyao on 15/11/24.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "MasterTabBarViewController.h"
#import "AnalysisViewController.h"
#import "SportViewController.h"
#import "MineViewController.h"
#import "GeneralNavgationController.h"
#import "CommonViewController.h"

@interface MasterTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation MasterTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorWhiteColor;

    [self custom];
    
}

- (void)custom
{
    
//  每次进入主界面，录入RegistrationId
    
//    [APIServiceManager registrationIDInputWithKey:[StorageManager getSecretKey] userID:[StorageManager getUserId] registrationID:[StorageManager getRegistrationId] completionBlock:^(id responObject)
//     {
//         if ([responObject[@"flag"] isEqualToString:@"100100"])
//         {
//             NSLog(@"registrationID录入成功");
//         }
//         
//     } failureBlock:^(NSError *error) {
//         NSLog(@"%@",error);
//     }];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")) {
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : kColorWhiteColor}
            forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : kColorBtnColor} forState:UIControlStateSelected];
        
        self.tabBar.barTintColor = kColorTabBarColor;
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(self.tabBar.bounds.origin.x, self.tabBar.bounds.origin.y, self.tabBar.bounds.size.width, self.tabBar.bounds.size.height)];
        bgView.backgroundColor = self.tabBar.barTintColor;
        [self.tabBar insertSubview:bgView atIndex:0];
        self.tabBar.opaque = YES;
    
        [[UITabBar appearance] setShadowImage:[UIImage new]];
        [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
        
    }else{
        [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeTextColor : kColorWhiteColor}
            forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeTextColor : kColorBtnColor}
            forState:UIControlStateSelected];
        
    }
    self.delegate = self;
    
    AnalysisViewController *analysisVC = [[AnalysisViewController alloc] init];
    GeneralNavgationController *analysisNav = [[GeneralNavgationController alloc] initWithRootViewController:analysisVC];
    
    [self setTabBarItem:analysisVC title:@"分析" image:ImageNamed(@"tab_icon_analysis") selectedImage:ImageNamed(@"tab_icon_analysis_chosed")];
    
    SportViewController *SportVC = [[SportViewController alloc] init];
    GeneralNavgationController *SportNav = [[GeneralNavgationController alloc] initWithRootViewController:SportVC];
    [self setTabBarItem:SportVC title:@"" image:ImageNamed(@"tab_icon_run_default") selectedImage:ImageNamed(@"tab_icon_run")];
    
    MineViewController *MineVC = [[MineViewController alloc] init];
    GeneralNavgationController *MineNav = [[GeneralNavgationController alloc] initWithRootViewController:MineVC];
    [self setTabBarItem:MineVC title:@"我的" image:ImageNamed(@"tab_icon_my") selectedImage:ImageNamed(@"tab_icon_my_chosed")];
    self.viewControllers = @[analysisNav,SportNav,MineNav];
    self.selectedIndex = 1;
}

- (void)setTabBarItem:(UIViewController *)viewController title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
    }else{
        viewController.tabBarItem.title = title;
        [viewController.tabBarItem setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:image];
    }
    
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    [self presentViewController:viewControllerToPresent animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
