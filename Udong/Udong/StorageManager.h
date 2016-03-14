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
+(void)saveEffectivepoint:(NSString *)Effectivepoint;
+(void)saveLoginType:(NSString *)LoginType;
+(void)saveLogoutTime:(NSString *)time;
+(void)saveRegistrationId:(NSString *)RegistrationId;
+(void)saveIOSVersion:(NSString *)version;

+(void)saveBaseUrl:(NSString *)urlString;
+(void)saveGetPictureUrl:(NSString *)pictureUrl;
+(void)saveDownloadUrl:(NSString *)downloadUrl;



+(NSString *)getSecretKey;
+(NSString *)getAccountNumber;
+(NSString *)getpsw;
+(NSString *)getUserId;
+(NSString *)getSex;
+(NSString *)getAge;
+(NSString *)getHeight;
+(NSString *)getWeight;
+(NSString *)getEffectivepoint;
+(NSString *)getLoginType;
+(NSString *)getLoginoutTime;
+(NSString *)getRegistrationId;
+(NSString *)getIOSVersion;


+(NSString *)getBaseUrl;
+(NSString *)getPictureUrl;
+(NSString *)getDownLoadUrl;


+(void)deleteRelatedInfo;

+ (void)deleteAccountNumber;

+ (void)deleteLogoutTime;

+ (void)deletePsw;

+ (void)deletePlistData;

// 存储脚步数（5S以下）
+ (void)saveStepCount:(NSInteger)stepCount totalCountUpToNow:(NSInteger)totalCount date:(NSDate *)date dateString:(NSString *)dateString;
// 查询脚步数（5S以下）
+ (void)queryStepCountStartingFrom:(NSDate *)start to:(NSDate *)end dateString:(NSString *)dateString withHandler:(void (^)(NSInteger numberOfSteps, NSError *error))handler;
// 查询全部脚步信息（5S以下）
+ (void)queryStepInfoStartingWithDateString:(NSString *)dateString withHandler:(void (^)(NSArray *result, NSError *error))handler;

@end
