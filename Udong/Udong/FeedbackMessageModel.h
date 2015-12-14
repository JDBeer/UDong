//
//  FeedbackMessageModel.h
//  Udong
//
//  Created by wildyao on 15/12/12.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedbackMessageModel : NSObject

@property (nonatomic,retain)NSString *content;
@property (nonatomic,retain)NSString *create_time;
@property (nonatomic,retain)NSString *head_img_url;
@property (nonatomic,retain)NSString *idSting;
@property (nonatomic,retain)NSString *nickname;
@property (nonatomic,retain)NSString *note;
@property (nonatomic,retain)NSString *status;
@property (nonatomic,retain)NSString *user_id;

+ (id)objectWithDictionary:(NSDictionary *)Dictionary;

- (id)initWithDictionary:(NSDictionary *)dictionary;


@end
