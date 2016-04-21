//
//  Router.m
//  AlarmChaser
//
//  Created by as on 2015/05/15.
//  Copyright (c) 2015年 tongari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Router.h"
#import "UserDefalutManager.h"
#import "AlarmManager.h"


static Router *sharedManager=nil;

@implementation Router

+ (Router *)sharedManager{
    
    static dispatch_once_t once;
    dispatch_once( &once, ^{
        sharedManager=[[self alloc] init];
    });
    
    return sharedManager;
    
}

+ (id)allocWithZone:(NSZone *)zone {
    
    __block id ret = nil;
    
    static dispatch_once_t once;
    dispatch_once( &once, ^{
        sharedManager = [super allocWithZone:zone];
        ret           = sharedManager;
    });
    
    return  ret;
    
}

- (id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

#pragma mark - functional

-(void)gotoAwakeAlarmViewController:(BOOL)isAnimate{
    
    if( [UIApplication sharedApplication].applicationIconBadgeNumber > 0 ){
        
        if(![[UserDefalutManager sharedManager] getDisplayedAwakeAlarmView] && ![[AlarmManager sharedManager] isAdView]){
            
            UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;

//            UIViewController *nextVC =[self transportationListEnterpoint];
            UIViewController *nextVC = [topController.storyboard instantiateViewControllerWithIdentifier:@"CalcViewController"];
            
            [topController presentViewController:nextVC animated:isAnimate completion:nil];
        }
    }
}



//-(UIViewController *)transportationListEnterpoint{
//    UIStoryboard *transportationList = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    return [transportationList instantiateViewControllerWithIdentifier:@"CalcViewController"];
//}


-(void)displayAwakeAlarmView{
    [sharedManager gotoAwakeAlarmViewController:YES];    
}


@end
