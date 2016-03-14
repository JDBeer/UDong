//
//  ShufflingPageViewController.m
//  Udong
//
//  Created by wildyao on 15/12/2.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "ShufflingPageViewController.h"
#import "MeasuremenViewController.h"
#import "LoginViewController.h"
#import "EvaluationResultViewController.h"

@interface ShufflingPageViewController ()<UIScrollViewDelegate,UIPageViewControllerDelegate>

@end

@implementation ShufflingPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
    
}

- (void)configView
{
    
    self.navigationController.navigationBarHidden = YES;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.contentSize = CGSizeMake(self.view.width*3, self.scrollView.contentSize.height);
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    for (int i=0; i<3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.scrollView.width, 0, self.scrollView.width, self.scrollView.height)];
        
        
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide_%d",i+1]];
        
        [imageView.image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
        
        [self.scrollView addSubview:imageView];
    }

    
    
    CGSize size = [@"用已有帐号登录" sizeWithAttributes:@{NSFontAttributeName:FONT(15)}];
    
    self.view.backgroundColor = kColorWhiteColor;
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.frame = CGRectMake(self.view.centerX-(size.width/2), self.view.bottom-40, size.width, size.height);
    [self.registerBtn setTitle:@"用已有帐号登录" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:kColorBtnColor forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(onbtnToLogin:) forControlEvents:UIControlEventTouchUpInside];
    self.registerBtn.titleLabel.font = FONT(15);
    [self.registerBtn setBackgroundColor:kColorClearColor];
    [self.view addSubview:self.registerBtn];
    
    
    self.useBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.useBtn.frame = CGRectMake(self.view.left+70, self.registerBtn.top-64, self.view.width-2*70, 40);
    [self.useBtn setBackgroundColor:kColorBlackColor];
    [self.useBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    [self.useBtn setTitle:@"开始使用" forState:UIControlStateNormal];
    [self.useBtn addTarget:self action:@selector(onbtnToMeasurement:) forControlEvents:UIControlEventTouchUpInside];
    
    self.useBtn.layer.cornerRadius = self.useBtn.height/2;
    self.useBtn.layer.masksToBounds = YES;
    self.useBtn.titleLabel.font = FONT(16);
    [self.view addSubview:self.useBtn];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.left+120, self.useBtn.top-40, self.view.width-2*120, 20)];
    self.pageControl.numberOfPages = 3;
    self.pageControl.pageIndicatorTintColor = kColorContentColor;
    self.pageControl.currentPageIndicatorTintColor = kColorBlackColor;
    self.pageControl.currentPage = 0;
    [self.view addSubview:self.pageControl];
    
    

    
}

- (void)onbtnToLogin:(id)sender
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)onbtnToMeasurement:(id)sender
{
    [StorageManager deleteRelatedInfo];
    
    [APIServiceManager getIdWithSecretkey:[StorageManager getSecretKey] type:@"1" completionBlock:^(id responObject) {
        
        if ([responObject[@"flag"] isEqualToString:@"100100"]) {
            NSString *idString = responObject[@"baseUserIdKey"];
            
            [StorageManager saveUserId:idString];
            
            MeasuremenViewController *measurementVC = [[MeasuremenViewController alloc] init];
            [self.navigationController pushViewController:measurementVC animated:YES];
        }else
        {
            NSLog(@"%@",responObject[@"message"]);
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
//    EvaluationResultViewController *EvaluationVC = [[EvaluationResultViewController alloc] init];
//    [self.navigationController pushViewController:EvaluationVC animated:YES];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x/scrollView.width;
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
