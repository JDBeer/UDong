//
//  StorageManager.m
//  Udong
//
//  Created by wildyao on 15/11/15.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "StorageManager.h"

@implementation StorageManager

//+ (void)saveAccountNumber:(NSString *)number password:(NSString *)pwd  userId:(NSString *)userId
//{
//    [[NSUserDefaults standardUserDefaults] setObject:number forKey:AccountNumberKey];
//    [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:PasswordKey];
//    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:UserIdKey];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}

+ (void)saveNewPassword:(NSString *)newPwd
{
    [[NSUserDefaults standardUserDefaults] setObject:newPwd forKey:PasswordKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (void)saveSecretKey:(NSString *)SecretKey
{
    [[NSUserDefaults standardUserDefaults] setObject:SecretKey forKey:SecretKKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)saveAccountNumber:(NSString *)AccountNumber
{
    [[NSUserDefaults standardUserDefaults] setObject:AccountNumber forKey:AccountNumberKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)savepsw:(NSString *)psw
{
    [[NSUserDefaults standardUserDefaults] setObject:psw forKey:PasswordKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)saveUserId:(NSString *)UserId
{
    [[NSUserDefaults standardUserDefaults] setObject:UserId forKey:UserIdKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

+(void)saveSex:(NSString *)Sex
{
    [[NSUserDefaults standardUserDefaults] setObject:Sex forKey:SexKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)saveAge:(NSString *)Age
{
    [[NSUserDefaults standardUserDefaults] setObject:Age forKey:AgeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)saveHeight:(NSString *)Height
{
    [[NSUserDefaults standardUserDefaults] setObject:Height forKey:HeightKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)saveWeight:(NSString *)Weight
{
    [[NSUserDefaults standardUserDefaults] setObject:Weight forKey:WeightKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//************************************************


+(NSString *)getSecretKey
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:SecretKKey];
}

+(NSString *)getAccountNumber
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:AccountNumberKey];
}

+(NSString *)getpsw
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:PasswordKey];
}

+(NSString *)getUserId
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:UserIdKey];
}

+(NSString *)getSex
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:SexKey];
}

+(NSString *)getAge
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:AgeKey];
}

+(NSString *)getHeight
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:HeightKey];
}

+(NSString *)getWeight
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:WeightKey];
}

//****************************************************

+(void)deleteRelatedInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserIdKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:AccountNumberKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:PasswordKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SexKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:AgeKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:HeightKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:WeightKey];
    
}


@end
