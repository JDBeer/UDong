//
//  FeedbackMessageModel.m
//  Udong
//
//  Created by wildyao on 15/12/12.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "FeedbackMessageModel.h"

@implementation FeedbackMessageModel

+ (id)objectWithDictionary:(NSDictionary *)Dictionary
{
    return [[self alloc] initWithDictionary:Dictionary];
}

- (id)initWithDictionary:(NSDictionary *)Dictionary;
{
    self = [super init];
    if (self) {
        self.content = [Dictionary objectForKey:@"content"];
        self.create_time = [Dictionary objectForKey:@"create_time"];
        self.head_img_url = [Dictionary objectForKey:@"head_img_url"];
        self.idSting = [Dictionary objectForKey:@"id"];
        self.nickname = [Dictionary objectForKey:@"nick_name"];
        self.note = [Dictionary objectForKey:@"note"];
        self.status = [Dictionary objectForKey:@"status"];
        self.user_id = [Dictionary objectForKey:@"user_id"];
    }
    return self;
}

@end
