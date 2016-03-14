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
+(void)getSecretKey:(NSString *)Secretkeytype completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

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
+(void)LoginWithSecretkey:(NSString *)secretKey phoneNumber:(NSString *)phoneNumber password:(NSString *)password Logintype:(NSString *)Logintype completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;


/**
 *验证手机号是否注册过
 */
+(void)PhoneRegisterWithSecretKey:(NSString *)secretKey phoneNumber:(NSString *)phoneNumber completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 *忘记密码
 */
+ (void)ForgetPassWordWithSecretKey:(NSString *)secretKey phoneNumber:(NSString *)phoneNumber vertifyCode:(NSString *)vertifyCode password:(NSString *)password completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

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

+ (void)GetAccountMessageWithKey:(NSString *)secretKey idString:(NSString *)idString status:(NSString *)status completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

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

+ (void)VersionUpdateWithKey:(NSString *)secretKey type:(NSString *)type version:(NSString *)version completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 获取意见反馈信息
 */

+ (void)GetFeedbackMessageWithKey:(NSString *)secretKey fromId:(NSString *)fromId toUserId:(NSString *)toUserId page:(NSString *)page rows:(NSString *)rows completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 发送反馈消息
 */

+ (void)SendFeedbackMessageWithKey:(NSString *)secretKey fromId:(NSString *)fromId useId:(NSString *)useId status:(NSString *)status content:(NSString *)content note:(NSString *)note tofromId:(NSString *)tofromId toUserId:(NSString *)toUserId code:(NSString *)code completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 更新反馈信息
 */

+ (void)UpdateFeedbackStatusWithKey:(NSString *)secretKey fromId:(NSString *)fromId userId:(NSString *)userId status:(NSString *)status completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 上传头像
 */

+ (void)SendHeadImageWithKey:(NSString *)secretKey pictureName:(NSString *)pictureName pictureDescription:(NSString *)pictureDescription pictureLink:(NSString *)pictureLink status:(NSString *)status pictureCreateBy:(NSString *)pictureCreateBy userId:(NSString *)userId pictureUpdateBy:(NSString *)pictureUpdateBy file:(NSString *)file completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 获取服务端最近的运动记录
 */

+ (void)GetServerLastRecordWithKey:(NSString *)secretKey userID:(NSString *)userID completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 上传用户运动信息
 */

+ (void)SendSportMessageWithKey:(NSString *)secretkey sportString:(NSString *)sportString completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 获取某日运动详情
 */

+ (void)GetOnedaySportDetailWithKey:(NSString *)secretKey userID:(NSString *)userID dateString:(NSString *)dateString completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 获取某日的运动效果
 */

+ (void)GetOnedaySportEffectWithKey:(NSString *)secretKey userID:(NSString *)userID dateString:(NSString *)dateString completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 获取一个月的运动完成比率
 */

+ (void)GetOneMonthSportFinishRateWithKey:(NSString *)secretKey userID:(NSString *)userID completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 第三方登录
 */

+ (void)ThridPlatfromLoginWithkey:(NSString *)secretKey loginType:(NSString *)loginType userID:(NSString *)userID thirdOpenID:(NSString *)thirdOpenID deviceisn:(NSString *)deviceisn deviceOS:(NSString *)deviceOS deviceModel:(NSString *)deviceModel deviceresolution:(NSString *)deviceresolution deviceVersion:(NSString *)deviceVersion nickName:(NSString *)nickName headImgUrl:(NSString *)headImgUrl completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 获取分析页点信息
 */

+ (void)GetAnalysisPointMessageWithKey:(NSString *)secretKey userID:(NSString *)userID days:(NSString *)days completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 获取消息界面联系人列表
 */

+ (void)GetLinkManListMessageWithKey:(NSString *)secretKey userID:(NSString *)userID time:(NSString *)time completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 获取用户和某一联系人之间的未读消息
 */

+ (void)GetUnReadMessageWithKey:(NSString *)secretKey userID:(NSString *)userID messageID:(NSString *)messageID completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 获取用户和某一联系人之间的已读消息
 */

+ (void)GetAlreadyReadMessageWithKey:(NSString *)secretKey userID:(NSString *)userID messageID:(NSString *)messageID time:(NSString *)time completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * 获取消息界面某文章详情
 */

+ (void)GetArticleDetailWithKey:(NSString *)secretKey articleId:(NSString *)articleId completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

/**
 * registrationID录入
 */

+ (void)registrationIDInputWithKey:(NSString *)secretKey userID:(NSString *)userID registrationID:(NSString *)registrationID completionBlock:(void (^)(id responObject))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;


@end
