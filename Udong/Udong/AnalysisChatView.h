//
//  AnalysisChatView.h
//  Udong
//
//  Created by wildyao on 16/1/13.
//  Copyright © 2016年 WuYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnalysisChatView : UIView

@property (nonatomic, strong)UIImageView *blueView;
@property (nonatomic, strong)UILabel *descriptionLabel;
@property (nonatomic, strong)NSMutableArray *coordinateArray;

@property (nonatomic, strong) CAShapeLayer *backgroundLayer;

- (id)initWithFrame:(CGRect)frame pointArray:(NSMutableArray *)pointArray type:(NSString *)type;

- (void)setupTheGrad;


@end
