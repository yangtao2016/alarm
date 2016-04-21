//
//  AppDelegate.h
//  AlarmChaser
//
//  Created by as on 2015/05/12.
//  Copyright (c) 2015年 tongari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) LeftSlideViewController *sliderVC;

+(NSString *)CUSTOM_NOTIFICATION_DID_ENTER_BACKGROUND;
+(NSString *)CUSTOM_NOTIFICATION_DID_BECOME_ACTIVE;
+(NSString *)CUSTOM_NOTIFICATION_DID_RECEIVE_LOCAL_NOTIFICATION_IN_ACTIVE;
+(NSString *)CUSTOM_NOTIFICATION_DID_RECEIVE_LOCAL_NOTIFICATION_STATE_ACTIVE;
+(NSString *)CUSTOM_NOTIFICATION_DID_FINISH_LAUNCHING_WITH_OPTIONS;



//任务
//
//2.设置每条通知，处理添加和通知后删除
////3.首页添加一个侧滑提示。












@end

