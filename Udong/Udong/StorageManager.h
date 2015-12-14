//
//  StorageManager.h
//  Udong
//
//  Created by wildyao on 15/11/15.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageManager : NSObject

//+ (void)saveAccountNumber:(NSString *)number password:(NSString *)pwd  userId:(NSString *)userId;


//+ (void)savedeviceisn:(NSString *)deviceisn deviceOS:(NSString *)deviceOS deviceModel:(NSString *)deviceModel deviceResolution:(NSString *)deviceResolution deviceVersion:(NSString *)deviceVersion;


+(void)saveNewPassword:(NSString *)newPwd;
+(void)saveSecretKey:(NSString *)SecretKey;
+(void)saveAccountNumber:(NSString *)AccountNumber;
+(void)savepsw:(NSString *)psw;
+(void)saveUserId:(NSString *)UserId;
+(void)saveSex:(NSString *)Sex;
+(void)saveAge:(NSString *)Age;
+(void)saveHeight:(NSString *)Height;
+(void)saveWeight:(NSString *)Weight;


+(NSString *)getSecretKey;
+(NSString *)getAccountNumber;
+(NSString *)getpsw;
+(NSString *)getUserId;
+(NSString *)getSex;
+(NSString *)getAge;
+(NSString *)getHeight;
+(NSString *)getWeight;


+(void)deleteRelatedInfo;

@end
