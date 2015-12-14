//
//  APIServiceManager.m
//  Udong
//
//  Created by wildyao on 15/11/15.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "APIServiceManager.h"
#import "AFNetworking.h"

@implementation APIServiceManager


+(void)getSecretKey:(NSString *)OriginSecretkey Secretkeytype:(NSString *)Secretkeytype completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
     NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:OriginSecretkey forKey:@"originSecretKey"];
    [parameters setObject:Secretkeytype forKey:@"SecretkeytypeKey"];
    
    NetworkActivityIndicatorVisible;
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?secretkey=%@&erpSecretkey.type=%@",Base_Url,GetSecretKey_Url,OriginSecretkey,Secretkeytype];
    NSString * encodedString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlString, NULL, NULL,  kCFStringEncodingUTF8 );
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:encodedString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        completionBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        failureBlock(error);
    }];

    
}

+ (void)getVertifyCodeWithSecretKey:(NSString *)secretKey mobileNumber:(NSString *)mobileNumber completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:secretKey forKey:@"SecretKey"];
    [parameters setObject:mobileNumber forKey:@"mobileNumber"];
    
    NetworkActivityIndicatorVisible;
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?secretKey=%@&message.mobile=%@",Base_Url,GetVertifyCode_Url,secretKey,mobileNumber];
    NSString * encodedString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlString, NULL, NULL,  kCFStringEncodingUTF8 );
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:encodedString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        completionBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failureBlock(error);
    }];
    
}

+ (void)getProvisionWithSecretKey:(NSString *)secretKey type:(NSString *)type completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    [parameters setObject:secretKey forKey:@"SecretKey"];
    [parameters setObject:type forKey:@"type"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?secretKey=%@&udServiceItem. z_status=%@",Base_Url,ServiceProvision_Url,secretKey,type];
    NSString * encodedString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlString, NULL, NULL,  kCFStringEncodingUTF8 );
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:encodedString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}


+ (void)registerWithSecretKey:(NSString *)secretKey openudid:(NSString *)openudid deviceOS:(NSString *)deviceOS deviceModel:(NSString *)deviceModel deviceResolution:(NSString *)deviceResolution deviceVersion:(NSString *)deviceVersion userId:(NSString *)userId phoneNumber:(NSString *)phoneNumber password:(NSString *)password vertifyCode:(NSString *)vertifyCode completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:openudid forKey:@"device.isn"];
    [parameters setObject:deviceOS forKey:@"device.os"];
    [parameters setObject:deviceModel forKey:@"device.model"];
    [parameters setObject:deviceResolution forKey:@"device.resolution"];
    [parameters setObject:deviceVersion forKey:@"device.osVersion"];
    [parameters setObject:userId forKey:@"baseUser.id"];
    [parameters setObject:phoneNumber forKey:@"baseUser.mobile"];
    [parameters setObject:password forKey:@"baseUser.pass"];
    [parameters setObject:vertifyCode forKey:@"baseUser.verify"];
  
    NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,Register_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];

    
}


+(void)LoginWithSecretkey:(NSString *)secretKey phoneNumber:(NSString *)phoneNumber password:(NSString *)password Logintype:(NSString *)Logintype openudid:(NSString *)openudid deviceOS:(NSString *)deviceOS deviceModel:(NSString *)deviceModel deviceResolution:(NSString *)deviceResolution deviceVersion:(NSString *)deviceVersion completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:phoneNumber forKey:@"baseUser.username"];
    [parameters setObject:password forKey:@"baseUser.pass"];
    [parameters setObject:Logintype forKey:@"baseUser.loginType"];
    [parameters setObject:openudid forKey:@"device.isn"];
    [parameters setObject:deviceOS forKey:@"device.os"];
    [parameters setObject:deviceModel forKey:@"device.model"];
    [parameters setObject:deviceResolution forKey:@"device.resolution"];
    [parameters setObject:deviceVersion forKey:@"device.osVersion"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,Login_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];

    
}

+(void)PhoneRegisterWithSecretKey:(NSString *)secretKey phoneNumber:(NSString *)phoneNumber completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:phoneNumber forKey:@"baseUser.mobile"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,PhoneIsRegister_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];
    
}

+ (void)ForgetPassWordWithSecretKey:(NSString *)secretKey phoneNumber:
(NSString *)phoneNumber status:(NSString *)status code:(NSString *)code vertifyCode:(NSString *)vertifyCode password:(NSString *)password completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:phoneNumber forKey:@"udBaseUser.mobile"];
    [parameters setObject:status forKey:@"udBaseUser.z_status"];
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:code forKey:@"udong_code"];
    [parameters setObject:vertifyCode forKey:@"udBaseUserVo.message_info"];
    [parameters setObject:password forKey:@"udBaseUser.pass"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,ForgetPsw_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];

    
}

+ (void)ChangePasswordWithSecretKey:(NSString *)secretKey phoneNumber:(NSString *)phoneNumber status:(NSString *)status code:(NSString *)code oldPassWord:(NSString *)oldPassWord newPassword:(NSString *)newPassword completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:phoneNumber forKey:@"udBaseUser.mobile"];
    [parameters setObject:status forKey:@"udBaseUser.z_status"];
    [parameters setObject:code forKey:@"udong_code"];
    [parameters setObject:oldPassWord forKey:@"udBaseUserVo.orPwd"];
    [parameters setObject:newPassword forKey:@"udBaseUser.pass"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,ModifyPsw_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];
    
}

+ (void)getProvinceAndCityWithSecretKey:(NSString *)secretKey key:(NSString *)key completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:key forKey:@"udRegion.parent_id"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,GetProvinceAndCity_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];

    
}

+ (void)getIdWithSecretkey:(NSString *)secretKey type:(NSString *)type completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;
{
     NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:type forKey:@"baseUser.note"];
    
     NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,GetId_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];

}

+ (void)getEvaluationResultWithKey:(NSString *)secretKey idString:(NSString *)idString sexString:(NSString *)sexString ageString:(NSString *)ageString heightString:(NSString *)heightString weightString:(NSString *)weightString completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:idString forKey:@"udUserHealthInfo.user_id"];
    [parameters setObject:sexString forKey:@"udUserHealthInfo.gender"];
    [parameters setObject:ageString forKey:@"udUserHealthInfo.birth"];
    [parameters setObject:heightString forKey:@"udUserHealthInfo.height"];
    [parameters setObject:weightString forKey:@"udUserHealthInfo.weight"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,GetEvaluationResult_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];

    
}

+ (void)judgeEvaluationWithKey:(NSString *)secretKey idString:(NSString *)idString completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    ;
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:idString forKey:@"udUserHealthInfo.user_id"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,JudgeEvalution_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];

}

+ (void)MineMessageWithKey:(NSString *)secretKey idString:(NSString *)idString completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    ;
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:idString forKey:@"userInfo.userId"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,MineMessage_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];
    
    
}

+ (void)GetAccountMessageWithKey:(NSString *)secretKey idString:(NSString *)idString phoneNumber:(NSString *)phoneNumber status:(NSString *)status completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:idString forKey:@"aUser.user_id"];
    [parameters setObject:phoneNumber forKey:@"aUser.mobile"];
    [parameters setObject:status forKey:@"aUser.z_status"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,AccountMessage_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];

}

+ (void)ModifiyAccountNickNameWithKey:(NSString *)secretKey phoneNumber:(NSString *)phoneNumber status:(NSString *)status nickName:(NSString *)nickName idString:(NSString *)idString ProvinceId:(NSString *)ProvinceId ProvinceName:(NSString *)ProvinceName cityId:(NSString *)cityId cityName:(NSString *)cityName headImageUrl:(NSString *)headImageUrl create:(NSString *)create update:(NSString *)update note:(NSString *)note completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock

{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:phoneNumber forKey:@"udBaseUser.mobile"];
    [parameters setObject:status forKey:@"udBaseUser.z_status"];
    [parameters setObject:nickName forKey:@"udUserInfo.nick_name"];
    [parameters setObject:idString forKey:@"udUserInfo.user_id"];
    [parameters setObject:ProvinceId forKey:@"udUserInfo.province_id"];
    [parameters setObject:ProvinceName forKey:@"udUserInfo.province_name"];
    [parameters setObject:cityId forKey:@"udUserInfo.city_id"];
    [parameters setObject:cityName forKey:@"udUserInfo.city_name"];
    [parameters setObject:headImageUrl forKey:@"udUserInfo.head_img_url"];
    [parameters setObject:create forKey:@"udUserInfo.create_by"];
    [parameters setObject:update forKey:@"udUserInfo.update_by"];
    [parameters setObject:note forKey:@"udUserInfo.note"];

     NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,modifiy_nickName_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

+ (void)ModifiyAccountLocationWithKey:(NSString *)secretKey phoneNumber:(NSString *)phoneNumber status:(NSString *)status nickName:(NSString *)nickName idString:(NSString *)idString ProvinceId:(NSString *)ProvinceId ProvinceName:(NSString *)ProvinceName cityId:(NSString *)cityId cityName:(NSString *)cityName headImageUrl:(NSString *)headImageUrl create:(NSString *)create update:(NSString *)update note:(NSString *)note completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:phoneNumber forKey:@"udBaseUser.mobile"];
    [parameters setObject:status forKey:@"udBaseUser.z_status"];
    [parameters setObject:nickName forKey:@"udUserInfo.nick_name"];
    [parameters setObject:idString forKey:@"udUserInfo.user_id"];
    [parameters setObject:ProvinceId forKey:@"udUserInfo.province_id"];
    [parameters setObject:ProvinceName forKey:@"udUserInfo.province_name"];
    [parameters setObject:cityId forKey:@"udUserInfo.city_id"];
    [parameters setObject:cityName forKey:@"udUserInfo.city_name"];
    [parameters setObject:headImageUrl forKey:@"udUserInfo.head_img_url"];
    [parameters setObject:create forKey:@"udUserInfo.create_by"];
    [parameters setObject:update forKey:@"udUserInfo.update_by"];
    [parameters setObject:note forKey:@"udUserInfo.note"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,modifiy_accountLocation_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

+ (void)modifiyAccountPhoneNumberWithKey:(NSString *)secretKey code:(NSString *)code phoneNumber:(NSString *)phoneNumber vertifyCode:(NSString *)vertifyCode idString:(NSString *)idString status:(NSString *)status completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:code forKey:@"udong_code"];
    [parameters setObject:phoneNumber forKey:@"message.mobile"];
    [parameters setObject:vertifyCode forKey:@"udBaseUserVo.message_info"];
    [parameters setObject:idString forKey:@"udBaseUser.id"];
    [parameters setObject:status forKey:@"udBaseUser.z_status=1"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,modtfiy_accountPhoneNumber_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];
    
}

+ (void)VersionUpdateWithKey:(NSString *)secretKey type:(NSString *)type completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:type forKey:@"udVersionInfo.os_type"];
    
     NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,Version_Update_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];

}

+ (void)GetFeedbackMessageWithKey:(NSString *)secretKey fromId:(NSString *)fromId toUserId:(NSString *)toUserId completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:fromId forKey:@"udFeedbackVo.from_user_id"];
    [parameters setObject:toUserId forKey:@"udFeedbackVo.to_user_id"];
    
     NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,Get_Feedback_Message_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];

}

+ (void)SendFeedbackMessageWithKey:(NSString *)secretKey tofromId:(NSString *)tofromId useId:(NSString *)useId status:(NSString *)status content:(NSString *)content note:(NSString *)note fromId:(NSString *)fromId toUserId:(NSString *)toUserId code:(NSString *)code completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
     NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:tofromId forKey:@"udFeedbackVo.to_user_id"];
    [parameters setObject:useId forKey:@"udFeedback.from_user_id"];
    [parameters setObject:status forKey:@"udFeedback.status"];
    [parameters setObject:content forKey:@"udFeedback.content"];
    [parameters setObject:note forKey:@"udFeedback.note"];
    [parameters setObject:fromId forKey:@"udFeedbackVo.from_user_id"];
    [parameters setObject:toUserId forKey:@"udFeedbackVo.to_user_id"];
    [parameters setObject:code forKey:@"udong_code"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,Send_Feedback_Message_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];

}

+ (void)UpdateFeedbackStatusWithKey:(NSString *)secretKey userId:(NSString *)userId status:(NSString *)status completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:userId forKey:@"udFeedback.user_id"];
    [parameters setObject:status forKey:@"udFeedback.status"];
    
     NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,Update_Feedback_Status_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];
    
}

+ (void)SendHeadImageWithKey:(NSString *)secretKey pictureName:(NSString *)pictureName pictureDescription:(NSString *)pictureDescription pictureLink:(NSString *)pictureLink status:(NSString *)status pictureCreateBy:(NSString *)pictureCreateBy userId:(NSString *)userId pictureUpdateBy:(NSString *)pictureUpdateBy file:(NSString *)file completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:secretKey forKey:@"secretKey"];
    [parameters setObject:pictureName forKey:@"udPicture.u_name"];
    [parameters setObject:pictureDescription forKey:@"udPicture. description"];
    [parameters setObject:pictureLink forKey:@"udPicture.link"];
    [parameters setObject:status forKey:@"udPicture.z_status"];
    [parameters setObject:pictureCreateBy forKey:@"udPicture. create_by"];
    [parameters setObject:userId forKey:@"udUserInfo.user_id"];
    [parameters setObject:pictureUpdateBy forKey:@"udPicture. update_by"];
    [parameters setObject:file forKey:@"file"];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,Send_HeadImage_Url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];

    
    }

//+ (void)SendHeadImageWithKey:(NSString *)secretKey file:(NSData *)file completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock
//{
//     NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    
//    [parameters setObject:secretKey forKey:@"secretKey"];
//    [parameters setObject:file forKey:@"file"];
//    
//    NSString *urlString = [NSString stringWithFormat:@"%@%@",Base_Url,Send_HeadImage_Url];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
//        [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//            completionBlock(responseObject);
//    
//        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//            failureBlock(error);
//        }];
//
//}

@end
