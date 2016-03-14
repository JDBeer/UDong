//
//  APIConstants.h
//  Udong
//
//  Created by wildyao on 15/11/16.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#define Base_Url @"http://demo.hzzkkj.com/udong-api/"
//张鹏鹏
//#define Base_Url @"http://192.168.1.118:6062/udong-api/"
//徐家园
//#define Base_Url @"http://192.168.1.108:8080/udong/"

//图片访问

#define Picture_Url @"http://demo.hzzkkj.com/udongAPI/upload/"

//下载访问

#define DownLoad_Url @"http://demo.hzzkkj.com/udongAPI/download/"


//注册

#define Register_Url @"com.zzkj.client.user/user!register"

//登录

#define Login_Url @"com.api.user/user_base_user!getUserLoginV_1_0_3"

//获取数据字典基础配置

#define HealthyValue_Url @"com.zzkj.client.healthy/flexvalues!healthyGetflexValues"

//获取服务条款

#define ServiceProvision_Url @"com.zzkj.client.system/system!queryServiceItem"

//健康信息测评录入

#define Healthy_evaluation_Url @"com.zzkj.client.healthy/healthy!addUdsettingsDetail"

//忘记密码

#define ForgetPsw_Url @"com.api.safety/safety_base_user!getSafetyPasswodUpdateV_1_0_3"

//修改密码

#define ModifyPsw_Url @"com.zzkj.client.safety/safety!getPassword"

//手机号码绑定

#define Mobile_binding_Url @"com.zzkj.back.message/message!send"

//查询秘钥

#define GetSecretKey_Url @"com.api.system/system_secretkey!getSystemSecretkeyV_1_0_3"

//错误信息返回

#define Error_Message_Return_Url @"com.zzkj.back.power/exp!exceptionInsertKey"

//获取验证码

#define GetVertifyCode_Url @"com.api.message/message_mobile_message!getMobileMessageV_1_0_3"

//判断手机号是否注册过

#define PhoneIsRegister_Url @"com.zzkj.client.user/user!isMobileExists"

//获取省市信息

#define GetProvinceAndCity_Url @"com.zzkj.client.system/region!systemQueryRegionList"

//用户第一次进入，测评完毕之后，获得一个账户Id接口

#define GetId_Url @"com.zzkj.client.user/user!getUserByid"

//获取测评结果

#define GetEvaluationResult_Url @"com.zzkj.client.healthy/health_info!addUdUserHealthInfo"

//判断有没有测评过

#define JudgeEvalution_Url @"com.zzkj.client.healthy/health_info!getEvaluationResult"

//获取我的界面信息

#define MineMessage_Url @"com.zzkj.client.user/user!mine"

//获取账户管理信息

#define AccountMessage_Url @"com.zzkj.client.safety/safety!getAccountUser"

//修改昵称并上传

#define modifiy_nickName_Url @"com.zzkj.client.safety/safety!updateUserInfo"

//修改账户归属地

#define modifiy_accountLocation_Url @"com.zzkj.client.safety/safety!updateUserInfo"

//修改绑定手机号

#define modtfiy_accountPhoneNumber_Url @"com.zzkj.client.safety/safety!getPassword"

//版本更新

#define Version_Update_Url @"com.api.system/system_version!getSystemVersionV_1_0_3"

//获取意见反馈信息

#define Get_Feedback_Message_Url @"com.zzkj.client.system/feedback!systemQueryfeedbackList"

//发送反馈信息

#define Send_Feedback_Message_Url @"com.zzkj.client.system/feedback!systemAddfeedback"

//更新反馈信息已读状态

#define Update_Feedback_Status_Url @"com.zzkj.client.system/feedback!Updatefeedback"

//上传头像

#define Send_HeadImage_Url @"com.upload.images/images!uploadImages"

//获取服务端最近的运动记录

#define Get_Server_LastSportRecord_Url @"com.zzkj.client.exercise/exercise!getNewestSportsRecordTime"

//上传用户运动信息

#define Send_SportMessage_Url @"com.zzkj.client.exercise/exercise!importSportsInfo"

//获取某日运动详情

#define Get_Oneday_SportDatail_Url @"com.zzkj.client.exercise/exercise!getSportsContentByDate"

//获取某日的运动效果

#define Get_Oneday_SportEffect_Url @"com.zzkj.client.exercise/exercise!getSportsResult"

//获取一个月的运动完成比率

#define Get_OneMonth_SportFinishRates_Url @"com.zzkj.client.exercise/exercise!getFinishRates"

//第三方登录

#define Third_platfrom_Login_Url @"com.zzkj.client.user/user!login"

//分析界面获得点信息

#define Get_Analysis_PointMessage_Url @"com.zzkj.client.analysis/analysis!getAnalysisResult"

#pragma mark - 消息模块

//获取联系人列表

#define Get_Linkman_list_Url @"com.zzkj.client.message/pushMessage!getMessagerList"

//获取用户和某一联系人之间的未读消息

#define Get_UnRead_Message_Url @"com.zzkj.client.message/pushMessage!getUnreadMessages"

//获取用户和某一联系人之间的已读消息

#define Get_AlreadyRead_Message_Url @"com.zzkj.client.message/pushMessage!getReadMessages"

//获取某文章详情

#define Get_Article_Detail_Url @"com.zzkj.client.message/pushMessage!getArticleDetail"

//registrationID录入

#define RegistrationID_Input_Url @"com.zzkj.client.user/user!updateRegistrationid"

