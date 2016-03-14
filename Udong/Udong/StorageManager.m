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

+(void)saveEffectivepoint:(NSString *)Effectivepoint
{
    [[NSUserDefaults standardUserDefaults] setObject:Effectivepoint forKey:EffectivepointKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)saveLoginType:(NSString *)LoginType
{
    [[NSUserDefaults standardUserDefaults] setObject:LoginType forKey:LoginTypeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)saveLogoutTime:(NSString *)time
{
    [[NSUserDefaults standardUserDefaults] setObject:time forKey:LogoutTimeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)saveRegistrationId:(NSString *)RegistrationId
{
    [[NSUserDefaults standardUserDefaults] setObject:RegistrationId forKey:RegistrationIdKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

+ (void)saveIOSVersion:(NSString *)version
{
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:IOSVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)saveBaseUrl:(NSString *)urlString
{
    [[NSUserDefaults standardUserDefaults] setObject:urlString forKey:BaseUrlKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+(void)saveGetPictureUrl:(NSString *)pictureUrl
{
    [[NSUserDefaults standardUserDefaults] setObject:pictureUrl forKey:GetPictureKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+(void)saveDownloadUrl:(NSString *)downloadUrl
{
    [[NSUserDefaults standardUserDefaults] setObject:downloadUrl forKey:GetDownLoadKey];
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

+(NSString *)getEffectivepoint
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:EffectivepointKey];
}

+(NSString *)getLoginType
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:LoginTypeKey];
}

+ (NSString *)getLoginoutTime
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:LogoutTimeKey];
}

+(NSString *)getRegistrationId
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:RegistrationIdKey];
}

+(NSString *)getIOSVersion
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:IOSVersionKey];
}

+(NSString *)getBaseUrl
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:BaseUrlKey];
}
+(NSString *)getPictureUrl
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:GetPictureKey];
}
+(NSString *)getDownLoadUrl
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:GetDownLoadKey];
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
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:EffectivepointKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LoginTypeKey];
    
}

+ (void)deleteAccountNumber
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:AccountNumberKey];
}

+ (void)deletePsw
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:PasswordKey];
}

+ (void)deleteLogoutTime
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LogoutTimeKey];
}

+ (void)deletePlistData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"aa.plist"];
    
    NSMutableDictionary *plistDic = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
    
    [plistDic removeAllObjects];
    [plistDic writeToFile:fileName atomically:YES];
}

+ (void)saveStepCount:(NSInteger)stepCount totalCountUpToNow:(NSInteger)totalCount date:(NSDate *)date dateString:(NSString *)dateString
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *archivingFilePath = [documentsDirectory stringByAppendingPathComponent:@"SportData"];
    NSString *datePath = [archivingFilePath stringByAppendingPathComponent:dateString];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:archivingFilePath]) {
        [self saveStepCount:stepCount totalCountUpToNow:totalCount date:date datePath:datePath];
    } else {
        if ([[NSFileManager defaultManager] createDirectoryAtPath:archivingFilePath withIntermediateDirectories:YES attributes:nil error:nil]) {
            NSLog(@"create targetPath success!");
        }
        [self saveStepCount:stepCount totalCountUpToNow:totalCount date:date datePath:datePath];
    }
}

+ (void)saveStepCount:(NSInteger)stepCount totalCountUpToNow:(NSInteger)totalCount date:(NSDate *)date datePath:(NSString *)datePath
{
    //    NSMutableArray *arr = [[NSKeyedUnarchiver unarchiveObjectWithFile:datePath] mutableCopy];
    //    if (!arr) {
    //        arr = [NSMutableArray array];
    //    }
    //    [arr addObject:@[date, @(stepCount), @(totalCount)]];
    //
    //    if ([NSKeyedArchiver archiveRootObject:arr toFile:datePath]) {
    //        NSLog(@"archive success");
    //    }
    
    NSMutableArray *arr = [[NSArray arrayWithContentsOfFile:datePath] mutableCopy];
    if (!arr) {
        arr = [NSMutableArray array];
    }
    [arr addObject:@[date, @(stepCount), @(totalCount)]];
    
    [arr writeToFile:datePath atomically:YES];
}

+ (void)queryStepInfoStartingWithDateString:(NSString *)dateString withHandler:(void (^)(NSArray *result, NSError *error))handler
{
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *documentsDirectory = [paths objectAtIndex:0];
    //    NSString *archivingFilePath = [documentsDirectory stringByAppendingPathComponent:@"SportData"];
    //    NSString *datePath = [archivingFilePath stringByAppendingPathComponent:dateString];
    //    NSFileManager *fileManager = [NSFileManager defaultManager];
    //
    //    if ([fileManager fileExistsAtPath:datePath]) {
    //        NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:datePath];
    //        dispatch_sync(dispatch_get_main_queue(), ^{
    //            handler(arr, nil);
    //        });
    //
    //    }  else {
    //        dispatch_sync(dispatch_get_main_queue(), ^{
    //            handler(nil, nil);
    //        });
    //    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *archivingFilePath = [documentsDirectory stringByAppendingPathComponent:@"SportData"];
    NSString *datePath = [archivingFilePath stringByAppendingPathComponent:dateString];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:datePath]) {
        NSArray *arr = [NSArray arrayWithContentsOfFile:datePath];
        dispatch_sync(dispatch_get_main_queue(), ^{
            handler(arr, nil);
        });
        
    }  else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            handler(nil, nil);
        });
    }
    
}

+ (void)queryStepCountStartingFrom:(NSDate *)start to:(NSDate *)end dateString:(NSString *)dateString withHandler:(void (^)(NSInteger numberOfSteps, NSError *error))handler
{
    dispatch_async(dispatch_queue_create("com.query.queue", DISPATCH_QUEUE_SERIAL), ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *archivingFilePath = [documentsDirectory stringByAppendingPathComponent:@"SportData"];
        NSString *datePath = [archivingFilePath stringByAppendingPathComponent:dateString];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if ([fileManager fileExistsAtPath:datePath]) {
            NSArray *arr = [NSArray arrayWithContentsOfFile:datePath];
            
            __block NSInteger numOfSteps = 0;
            [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                NSArray *arr = (NSArray *)obj;
                NSDate *recordDate = arr[0];
                
                if ((([recordDate compare:start] == NSOrderedDescending) && ([recordDate compare:end] == NSOrderedAscending)) || ([recordDate compare:end] == NSOrderedSame)) {
                    
                    NSInteger steps = [arr[1] integerValue];
                    
                    numOfSteps += steps;
                }
            }];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                handler(numOfSteps, nil);
            });
            
        }  else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                handler(0, nil);
            });
        }
    });
}



@end
