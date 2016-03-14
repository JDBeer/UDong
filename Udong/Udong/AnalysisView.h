//
//  AnalysisView.h
//  Udong
//
//  Created by wildyao on 16/1/12.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnalysisView : UIView
@property (nonatomic, strong)UILabel *titleLabel1;
@property (nonatomic, strong)UILabel *titleLabel2;
@property (nonatomic, strong)UILabel *sportLabel;
@property (nonatomic, strong)UILabel *numbelLabel;
@property (nonatomic, strong)UILabel *precentLabel;

- (id)initWithFrame:(CGRect)frame sportLabel:(NSString *)sportLabel numberLabel:(NSString *)numberLabel;


@end
