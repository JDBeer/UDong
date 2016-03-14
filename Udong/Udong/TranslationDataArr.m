//
//  TranslationDataArr.m
//  Udong
//
//  Created by wildyao on 15/12/28.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "TranslationDataArr.h"

@implementation TranslationDataArr

+ (NSString *)ChangeArrayToString:(NSInteger)time
{
    NSMutableArray *pointListArr = [[NSMutableArray alloc] init];
    NSMutableArray *allInfoArray = [[NSMutableArray alloc] init];
    
    NSDate *everyDate = [[NSDate alloc] init];
    
    NSDate *timeZeroDate = [[NSDate alloc] init];
    if (time == 0) {
        timeZeroDate = [NSDate date];
    }else{
        timeZeroDate = [NSDate dateWithTimeIntervalSince1970:time];
    }
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:timeZeroDate];
    [comps setHour:0];
    NSDate *zeroDate = [calender dateFromComponents:comps];
    NSInteger zeroInteger = [zeroDate timeIntervalSince1970];
    
    NSInteger nowDate = [[NSDate date] timeIntervalSince1970];
    NSInteger aa = nowDate-zeroInteger;
    NSInteger days = aa/86400;
    
    
    for (int i=0; i<days+1; i++) {
        NSInteger sportTime = 28800+zeroInteger+86400*i;
        NSDate *sportdate = [NSDate dateWithTimeIntervalSince1970:sportTime];
        NSString *sportdateString = [NSString stringWithFormat:@"%@",sportdate];
        NSString *substring = [sportdateString substringWithRange:NSMakeRange(0, 10)];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *plistPath1= [paths objectAtIndex:0];
        NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"aa.plist"];
        
        NSMutableDictionary *plistDic = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
        NSLog(@"--%@",plistDic);
        
        NSMutableDictionary *stepDic =plistDic[[StorageManager getUserId]];
        
        if ([stepDic.allKeys containsObject:substring]) {
            
            NSArray *sportDataArray = stepDic[substring];
            
            if ([sportDataArray[0] count] == 0) {
                
                NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
                
                [dataDictionary setObject:@"0" forKey:@"id"];
                [dataDictionary setObject:[StorageManager getUserId] forKey:@"userId"];
                [dataDictionary setObject:[NSString stringWithFormat:@"%ld",(long)sportTime-28800] forKey:@"sportsDate"];
                
                [dataDictionary setObject:@"0" forKey:@"earning"];
                [dataDictionary setObject:[StorageManager getEffectivepoint] forKey:@"eev"];
                [dataDictionary setObject:@"0" forKey:@"stepTotal"];
                [dataDictionary setObject:@"0" forKey:@"stepEffctv"];
                [dataDictionary setObject:@"0" forKey:@"timeTotal"];
                [dataDictionary setObject:@"0" forKey:@"timeEffctv"];
                [dataDictionary setObject:@"0" forKey:@"dayContinued"];
                [dataDictionary setObject:@"0" forKey:@"a"];
                [dataDictionary setObject:@"0" forKey:@"b"];
                [dataDictionary setObject:@"0" forKey:@"bfc"];
                [dataDictionary setObject:@"0" forKey:@"bfcTotal"];
                [dataDictionary setObject:@"0" forKey:@"createTime"];
                [dataDictionary setObject:@"0" forKey:@"createBy"];
                [dataDictionary setObject:@"0" forKey:@"updateTime"];
                [dataDictionary setObject:@"0" forKey:@"updateBy"];
                [dataDictionary setObject:@"0" forKey:@"note"];
                [dataDictionary setObject:[NSNull null] forKey:@"sportsDetails"];
                [allInfoArray addObject:dataDictionary];
                
            }else{
               
                
                for (int i=0; i<[sportDataArray[0] count]; i++) {
                    NSMutableDictionary *pointlistDic =[[NSMutableDictionary alloc] init];
                    [pointlistDic setObject:@"0" forKey:@"id"];
                    [pointlistDic setObject:[StorageManager getUserId] forKey:@"userId"];
                    [pointlistDic setObject:sportDataArray[0][i][3] forKey:@"stepNum"];
                    [pointlistDic setObject:@"0" forKey:@"isEffctv"];
                    [pointlistDic setObject:sportDataArray[0][i][2] forKey:@"mets"];
                    [pointlistDic setObject:sportDataArray[0][i][4] forKey:@"achieved"];
                    
                    NSString *string = [NSString stringWithFormat:@"%@",sportDataArray[0][i][1]];
                    NSString *oneString = [string substringToIndex:[string length]-5];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    everyDate = [formatter dateFromString:oneString];
//                    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//                    NSInteger interval = [zone secondsFromGMTForDate:finDate];
//                    NSDate *localeDate = [finDate dateByAddingTimeInterval: interval];
                    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[everyDate timeIntervalSince1970]];
        
                    [pointlistDic setObject:timeSp forKey:@"sportsTime"];
                    
                    [pointlistDic setObject:@"0" forKey:@"createTime"];
                    [pointlistDic setObject:@"0" forKey:@"createBy"];
                    [pointlistDic setObject:@"0" forKey:@"updateTime"];
                    [pointlistDic setObject:@"0" forKey:@"updateBy"];
                    [pointlistDic setObject:@"0" forKey:@"note"];
                    
                    [pointListArr addObject:pointlistDic];

                }

                
                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:everyDate];
                components.hour = 0;
                components.minute = 0;
                components.second = 0;
                NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
                NSString *anotherString = [NSString stringWithFormat:@"%f",ts];
                NSString *twoString = [anotherString substringToIndex:[anotherString length]-7];
                
                NSMutableDictionary *stepDictionary = [[NSMutableDictionary alloc] init];
                
                [stepDictionary setObject:twoString forKey:@"sportsDate"];
                
                [stepDictionary setObject:sportDataArray[5] forKey:@"earning"];
                [stepDictionary setObject:[StorageManager getUserId] forKey:@"userId"];
                [stepDictionary setObject:[StorageManager getEffectivepoint] forKey:@"eev"];
                [stepDictionary setObject:sportDataArray[1] forKey:@"stepTotal"];
                [stepDictionary setObject:sportDataArray[2] forKey:@"stepEffctv"];
                [stepDictionary setObject:sportDataArray[3] forKey:@"timeTotal"];
                [stepDictionary setObject:sportDataArray[4] forKey:@"timeEffctv"];
                [stepDictionary setObject:@"0" forKey:@"dayContinued"];
                [stepDictionary setObject:@"0" forKey:@"a"];
                [stepDictionary setObject:@"0" forKey:@"b"];
                [stepDictionary setObject:@"0" forKey:@"bfc"];
                [stepDictionary setObject:@"0" forKey:@"bfcTotal"];
                [stepDictionary setObject:@"0" forKey:@"createTime"];
                [stepDictionary setObject:@"0" forKey:@"createBy"];
                [stepDictionary setObject:@"0" forKey:@"updateTime"];
                [stepDictionary setObject:@"0" forKey:@"updateBy"];
                [stepDictionary setObject:@"0" forKey:@"note"];
                [stepDictionary setObject:pointListArr forKey:@"sportsDetails"];
                [allInfoArray addObject:stepDictionary];
            }
            
        }else{
            
            NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
            
                [dataDictionary setObject:@"0" forKey:@"id"];
            
                [dataDictionary setObject:[StorageManager getUserId] forKey:@"userId"];
                [dataDictionary setObject:[NSString stringWithFormat:@"%ld",(long)sportTime-28800]forKey:@"sportsDate"];
            
                [dataDictionary setObject:@"0" forKey:@"earning"];
                [dataDictionary setObject:[StorageManager getEffectivepoint] forKey:@"eev"];
                [dataDictionary setObject:@"0" forKey:@"stepTotal"];
                [dataDictionary setObject:@"0" forKey:@"stepEffctv"];
                [dataDictionary setObject:@"0" forKey:@"timeTotal"];
                [dataDictionary setObject:@"0" forKey:@"timeEffctv"];
                [dataDictionary setObject:@"0" forKey:@"dayContinued"];
                [dataDictionary setObject:@"0" forKey:@"a"];
                [dataDictionary setObject:@"0" forKey:@"b"];
                [dataDictionary setObject:@"0" forKey:@"bfc"];
                [dataDictionary setObject:@"0" forKey:@"bfcTotal"];
                [dataDictionary setObject:@"0" forKey:@"createTime"];
                [dataDictionary setObject:@"0" forKey:@"createBy"];
                [dataDictionary setObject:@"0" forKey:@"updateTime"];
                [dataDictionary setObject:@"0" forKey:@"updateBy"];
                [dataDictionary setObject:@"0" forKey:@"note"];
                [dataDictionary setObject:[NSNull null] forKey:@"sportsDetails"];
            
                [allInfoArray addObject:dataDictionary];
        }
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:allInfoArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    return jsonString;
}


+ (void)changeServerDataToLocal:(NSDictionary *)serverDic
{
    
    if ([serverDic class]==[NSNull class]) {
        NSDictionary *dic = [[NSDictionary alloc] init];
        
        //  获取路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *plistPath1= [paths objectAtIndex:0];
        NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"aa.plist"];
        [dic writeToFile:fileName atomically:YES];

    }else{
        
        NSArray *detailArray = serverDic[@"sportsDetails"];
        
        if (detailArray.count == 0||detailArray == nil||[detailArray class] == [NSNull class]) {
            NSDictionary *dic = [[NSDictionary alloc] init];
            
            //  获取路径
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *plistPath1= [paths objectAtIndex:0];
            NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"aa.plist"];
            [dic writeToFile:fileName atomically:YES];
            
        }else{
            
            NSArray *serverArray = serverDic[@"sportsDetails"];//数据字典
            
            NSMutableArray *daysStepInfoArr = [[NSMutableArray alloc] init];
            NSMutableArray *stepInfoArr = [NSMutableArray array];
            
            //四项内容
            NSInteger totalNumOfSteps = [serverDic[@"stepTotal"] integerValue];
            NSInteger vaildNumofSteps = [serverDic[@"stepEffctv"] integerValue];
            NSInteger totalSportTime = [serverDic[@"timeTotal"] integerValue];
            NSInteger validSportTime = [serverDic[@"timeEffctv"] integerValue];
            NSInteger effectiveSportPoint = [serverDic[@"earning"] integerValue];
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            NSMutableDictionary *dicc2 = [[NSMutableDictionary alloc] init];
            
            for (NSDictionary *dicc in serverArray) {
                
                id fromdate = dicc[@"sportsTime"];
                NSInteger aa = [fromdate integerValue]+8*3600;
                NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:aa];
                
                NSString *mets = dicc[@"mets"];
                float strength = [mets floatValue];
                
                id stepNum = dicc[@"stepNum"];
                NSInteger step = [stepNum integerValue];
                
                id achieve = dicc[@"achieved"];
                NSInteger achieved = [achieve integerValue];
                
                [stepInfoArr addObject:@[@(0), dateFrom, @(strength),@(step),@(achieved)]];
            }
            
            [daysStepInfoArr addObject:stepInfoArr];
            [daysStepInfoArr addObject:@(totalNumOfSteps)];
            [daysStepInfoArr addObject:@(vaildNumofSteps)];
            [daysStepInfoArr addObject:@(totalSportTime)];
            [daysStepInfoArr addObject:@(validSportTime)];
            [daysStepInfoArr addObject:@(effectiveSportPoint)];
            [daysStepInfoArr addObject:@(0)];
            
            NSString *todayKey = [DaysHelper getKeyDateString];
            
            [dic setObject:daysStepInfoArr forKey:todayKey];
            
            [dicc2 setObject:dic forKey:[StorageManager getUserId]];
            
            //组装成本地格式的数据后，存入本地
            
            //  获取路径
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *plistPath1= [paths objectAtIndex:0];
            NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"aa.plist"];
            
            NSLog(@"kkk%@",dicc2);
            [dicc2 writeToFile:fileName atomically:YES];
            
        }

    }

}


@end
