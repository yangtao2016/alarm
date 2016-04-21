//
//  Router.h
//  AlarmChaser
//
//  Created by as on 2015/05/15.
//  Copyright (c) 2015年 tongari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Router : NSObject

+(Router *)sharedManager;

-(void)gotoAwakeAlarmViewController:(BOOL)isAnimate;


-(void)displayAwakeAlarmView;

@end
