//
//  EditNameView.m
//  Udong
//
//  Created by wildyao on 15/11/30.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "EditNameView.h"

@implementation EditNameView

- (id)initWithFrame:(CGRect)frame andContainerView:(UIView *)containerView
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect rect= [UIApplication sharedApplication].delegate.window.frame;
        containerView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height+64);
        containerView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        self.containerView = containerView;
        [self addSubview:containerView];
        
        self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectZero];
        self.scrollview.backgroundColor = [ColorManager getColor:@"f8f8f8" WithAlpha:1];
        self.scrollview.layer.cornerRadius = 8;
        self.scrollview.layer.masksToBounds = YES;
        [self.containerView addSubview:self.scrollview];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label.text = @"编辑昵称";
        self.label.textColor = [ColorManager getColor:@"999999" WithAlpha:1];
        self.label.font = FONT(17);
        [self.label sizeToFit];
        [self addSubview:self.label];
        
        self.field = [[UITextField alloc] initWithFrame:CGRectZero];
        self.field.placeholder = @"2~8个字符";
        self.field.delegate = self;
        self.field.layer.cornerRadius = 8;
        self.field.layer.masksToBounds = YES;
        [self.field setValue:UIColorFromHexWithAlpha(0xe6e6e6, 1) forKeyPath:@"_placeholderLabel.textColor"];
        self.field.backgroundColor =  UIColorFromHex(0xffffff);
        [self addSubview:self.field];
        
        self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.leftBtn addTarget:self action:@selector(onBtnGiveup:) forControlEvents:UIControlEventTouchUpInside];
        [self.leftBtn setBackgroundColor:kColorWhiteColor];
        [self.leftBtn setTitleColor:kColorBlackColor forState:UIControlStateNormal];
        self.leftBtn.layer.cornerRadius = 8;
        self.leftBtn.layer.masksToBounds = YES;
        [self addSubview:self.leftBtn];
        
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.rightBtn setTitle:@"确认" forState:UIControlStateNormal];
        [self.rightBtn addTarget:self action:@selector(onBtnConfirm:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn setBackgroundColor:kColorWhiteColor];
        [self.rightBtn setTitleColor:UIColorFromHex(0x2fbec8) forState:UIControlStateNormal];
        self.rightBtn.layer.cornerRadius = 8;
        self.rightBtn.layer.masksToBounds = YES;
        [self addSubview:self.rightBtn];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.field];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyBoard1:)];
            [self addGestureRecognizer:tap];
        
    }
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollview.width = self.width-40*2;
    if (IS_IPHONE_6P||IS_IPHONE_6) {
        self.scrollview.height = 200;
    }else{
        self.scrollview.height = 170;
    }
    
    self.scrollview.centerX = self.width/2;
    self.scrollview.centerY = self.height/3;
   
    
    self.label.top = self.scrollview.top+15;;
    self.label.centerX = self.width/2;
    
    self.field.width = self.scrollview.width-40;
    self.field.height = 40;
    self.field.top = self.label.bottom+22;
    self.field.centerX = self.width/2;
    
    
    self.leftBtn.top = self.field.bottom+20;
    self.leftBtn.left = self.field.left;
    if (IS_IPONE_4_OR_LESS) {
        self.leftBtn.width = 60;
    }else{
        self.leftBtn.width = 80;
    }
    self.leftBtn.height = 40;
    
    
    self.rightBtn.width = self.leftBtn.width;
    self.rightBtn.height = 40;
    self.rightBtn.top = self.leftBtn.top;
    self.rightBtn.left = self.scrollview.right-20-self.rightBtn.width;
    
    
}

- (void)show
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
        self.alpha = 1.0;
        self.containerView.alpha = 1.0;
        
    }];
}

- (void)hiden
{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
        
        self.alpha = 0.0;
        self.containerView.alpha = 0.0;
        
        
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
        [self removeFromSuperview];
    }];
}

- (void)onBtnGiveup:(id)sender
{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
        
        self.alpha = 0.0;
        self.containerView.alpha = 0.0;
        
        
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
        [self removeFromSuperview];
    }];

}

- (void)onBtnConfirm:(id)sender
{
    
    if (self.field.text.length==0) {
    
    [SVProgressHUD showHUDWithImage:nil status:@"输入的昵称不能为空" duration:2];
        
        return;
    }
        
    if (self.field.text.length == 1) {
        
        
     [SVProgressHUD showHUDWithImage:nil status:@"昵称长度为2~8个字节" duration:2];
        return;
                        
    }
    
    NSString *nickNameString = self.field.text;
    
    [APIServiceManager ModifiyAccountNickNameWithKey:[StorageManager getSecretKey] phoneNumber:[StorageManager getAccountNumber] status:@"1" nickName:nickNameString idString:[StorageManager getUserId] ProvinceId:@"0" ProvinceName:@"0" cityId:@"0" cityName:@"0" headImageUrl:@"0" create:@"0" update:@"0" note:@"0" completionBlock:^(id responObject) {
        
        if ([responObject[@"flag"] isEqualToString:@"100100"])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:DidFinishedChangeNickNameNotification object:nickNameString];
            [self hiden];
            
        }else if ([responObject[@"flag"] isEqualToString:@"100600"])
        {
            [SVProgressHUD showHUDWithImage:nil status:@"昵称中含有敏感词汇" duration:2];
        }else
        {
            [SVProgressHUD showHUDWithImage:nil status:@"昵称修改失败" duration:2];
        }
        
    } failureBlock:^(NSError *error) {
        
            NSLog(@"%@",error);
    }];
}

#pragma mark - TextFiledDelegate

- (void)alertTextFieldDidChange:(NSNotification *)notification
{
    
    self.field = notification.object;
    if (self.field.text.length > 8) {
        self.field.text = [self.field.text substringToIndex:8];
    }
}



- (void)dissmissKeyBoard1:(UITapGestureRecognizer *)tap
{
    [self endEditing:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
