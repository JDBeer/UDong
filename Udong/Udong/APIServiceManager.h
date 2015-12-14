//
//  APIServiceManager.h
//  Udong
//
//  Created by wildyao on 15/11/15.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIServiceManager : NSObject

/**
 *获取密钥
 */
+(void)getSecretKey:(NSString *)OriginSecretkey Secretkeytype:(NSString *)Secretkeytype completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 *获取验证码
 */
+ (void)getVertifyCodeWithSecretKey:(NSString *)secretKey mobileNumber:(NSString *)mobileNumber completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 *获取服务条款
 */
+ (void)getProvisionWithSecretKey:(NSString *)secretKey type:(NSString *)type completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 *注册
 */
+ (void)registerWithSecretKey:(NSString *)secretKey openudid:(NSString *)openudid deviceOS:(NSString *)deviceOS deviceModel:(NSString *)deviceModel deviceResolution:(NSString *)deviceResolution deviceVersion:(NSString *)deviceVersion userId:(NSString *)userId phoneNumber:(NSString *)phoneNumber password:(NSString *)password vertifyCode:(NSString *)vertifyCode completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 *登录
 */
+(void)LoginWithSecretkey:(NSString *)secretKey phoneNumber:(NSString *)phoneNumber password:(NSString *)password Logintype:(NSString *)Logintype openudid:(NSString *)openudid deviceOS:(NSString *)deviceOS deviceModel:(NSString *)deviceModel deviceResolution:(NSString *)deviceResolution deviceVersion:(NSString *)deviceVersion completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 *验证手机号是否注册过
 */
+(void)PhoneRegisterWithSecretKey:(NSString *)secretKey phoneNumber:(NSString *)phoneNumber completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 *忘记密码
 */
+ (void)ForgetPassWordWithSecretKey:(NSString *)secretKey phoneNumber:
(NSString *)phoneNumber status:(NSString *)status code:(NSString *)code vertifyCode:(NSString *)vertifyCode password:(NSString *)password completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 *修改密码
 */
+ (void)ChangePasswordWithSecretKey:(NSString *)secretKey phoneNumber:(NSString *)phoneNumber status:(NSString *)status code:(NSString *)code oldPassWord:(NSString *)oldPassWord newPassword:(NSString *)newPassword completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 *获取省市
 */

+ (void)getProvinceAndCityWithSecretKey:(NSString *)secretKey key:(NSString *)key completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 *用户第一次进入，点击开始使用，获得一个账户Id接口
 */

+ (void)getIdWithSecretkey:(NSString *)secretKey type:(NSString *)type completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 *获取测评结果
 */

+ (void)getEvaluationResultWithKey:(NSString *)secretKey idString:(NSString *)idString sexString:(NSString *)sexString ageString:(NSString *)ageString heightString:(NSString *)heightString weightString:(NSString *)weightString completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 *判断用户是否测评
 */

+ (void)judgeEvaluationWithKey:(NSString *)secretKey idString:(NSString *)idString completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 *我的界面信息
 */

+ (void)MineMessageWithKey:(NSString *)secretKey idString:(NSString *)idString completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 *帐号管理界面信息
 */

+ (void)GetAccountMessageWithKey:(NSString *)secretKey idString:(NSString *)idString phoneNumber:(NSString *)phoneNumber status:(NSString *)status completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 修改账户昵称
 */

+ (void)ModifiyAccountNickNameWithKey:(NSString *)secretKey phoneNumber:(NSString *)phoneNumber status:(NSString *)status nickName:(NSString *)nickName idString:(NSString *)idString ProvinceId:(NSString *)ProvinceId ProvinceName:(NSString *)ProvinceName cityId:(NSString *)cityId cityName:(NSString *)cityName headImageUrl:(NSString *)headImageUrl create:(NSString *)create update:(NSString *)update note:(NSString *)note completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 修改账户归属地
 */

+ (void)ModifiyAccountLocationWithKey:(NSString *)secretKey phoneNumber:(NSString *)phoneNumber status:(NSString *)status nickName:(NSString *)nickName idString:(NSString *)idString ProvinceId:(NSString *)ProvinceId ProvinceName:(NSString *)ProvinceName cityId:(NSString *)cityId cityName:(NSString *)cityName headImageUrl:(NSString *)headImageUrl create:(NSString *)create update:(NSString *)update note:(NSString *)note completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 修改绑定手机号
 */

+ (void)modifiyAccountPhoneNumberWithKey:(NSString *)secretKey code:(NSString *)code phoneNumber:(NSString *)phoneNumber vertifyCode:(NSString *)vertifyCode idString:(NSString *)idString status:(NSString *)status completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 版本更新
 */

+ (void)VersionUpdateWithKey:(NSString *)secretKey type:(NSString *)type completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 获取意见反馈信息
 */

+ (void)GetFeedbackMessageWithKey:(NSString *)secretKey fromId:(NSString *)fromId toUserId:(NSString *)toUserId completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 发送反馈消息
 */

+ (void)SendFeedbackMessageWithKey:(NSString *)secretKey tofromId:(NSString *)tofromId useId:(NSString *)useId status:(NSString *)status content:(NSString *)content note:(NSString *)note fromId:(NSString *)fromId toUserId:(NSString *)toUserId code:(NSString *)code completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 更新反馈信息
 */

+ (void)UpdateFeedbackStatusWithKey:(NSString *)secretKey userId:(NSString *)userId status:(NSString *)status completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 上传头像
 */

+ (void)SendHeadImageWithKey:(NSString *)secretKey pictureName:(NSString *)pictureName pictureDescription:(NSString *)pictureDescription pictureLink:(NSString *)pictureLink status:(NSString *)status pictureCreateBy:(NSString *)pictureCreateBy userId:(NSString *)userId pictureUpdateBy:(NSString *)pictureUpdateBy file:(NSString *)file completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

//+ (void)SendHeadImageWithKey:(NSString *)secretKey file:(NSString *)file completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;


@end
