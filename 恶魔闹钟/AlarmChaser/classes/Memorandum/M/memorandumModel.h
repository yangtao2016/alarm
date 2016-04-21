//
//  memorandumModel.h
//  AlarmChaser
//
//  Created by zhixian on 16/4/14.
//  Copyright © 2016年 tongari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface memorandumModel : baseNSObject

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *subTitle;

@property(nonatomic,copy)NSString *reminderTime;//提醒时间

@property(nonatomic,copy)NSString *editTime;//编辑时的时间

@property(nonatomic,copy)NSString *modelId;

//@property(nonatomic,assign)BOOL isOut;//是否过期（已经提示过）

+(NSMutableArray *)getdataArray;//获取


+(NSDate *)bakeDateWithsting:(NSString*)string;
+(NSString *)bakesStringWithdate:(NSDate*)date;

@end
