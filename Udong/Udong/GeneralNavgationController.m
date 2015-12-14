//
//  GeneralNavgationController.m
//  Udong
//
//  Created by wildyao on 15/11/24.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "GeneralNavgationController.h"

@interface GeneralNavgationController ()

@end

@implementation GeneralNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self custom];
    
}

- (void)custom
{
    self.navigationBar.titleTextAttributes = @{
                                               NSFontAttributeName : FONT(18),
                                               
                                               UITextAttributeTextColor : kColorBlackColor,
                                           UITextAttributeTextShadowColor : kColorClearColor,
                                                };

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
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
