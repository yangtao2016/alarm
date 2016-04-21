//
//  calcModel.m
//  AlarmChaser
//
//  Created by zhixian on 16/4/16.
//  Copyright © 2016年 tongari. All rights reserved.
//

#import "calcModel.h"



typedef NS_ENUM(NSUInteger, CALC_TYPE) {
    CALC_TYPE_ADD     =0,
    CALC_TYPE_MINUS,
    CALC_TYPE_TIMES,
    CALC_TYPE_DIVIDED,
};


@interface calcModel ()

@property(nonatomic,assign)CALC_TYPE calcType;

@end

@implementation calcModel
{
    int a,b;



}


-(instancetype)init
{
    self=[super init];
    
    self.calcType=arc4random()%4;
    a=0;
    b=0;
    
    
    switch (self.calcType) {
        case CALC_TYPE_ADD:
            
            a=[self myarcNumber500];
            b=[self myarcNumber500];
            self.formula=[NSString stringWithFormat:@"%d + %d=",a,b];
            self.result=[NSString stringWithFormat:@"%d",a+b];
            break;
            
            case CALC_TYPE_MINUS:
            
            a=[self myarcNumber500];
            b=[self myarcNumber500];
            
            if (a>b)
            {
              self.formula=[NSString stringWithFormat:@"%d - %d=",a,b];
            }else{
              self.formula=[NSString stringWithFormat:@"%d - %d=",b,a];
            }
            self.result=[NSString stringWithFormat:@"%d",a>b?a-b:b-a];
            break;
    
            case CALC_TYPE_TIMES:
            
            a=[self myarcNumber30];
            b=[self myarcNumber30];
            self.formula=[NSString stringWithFormat:@"%d x %d=",a,b];
            self.result=[NSString stringWithFormat:@"%d",a*b];
            
            break;
        default:
            
            a=[self myarcNumber30];
            b=[self myarcNumber30];
            self.formula=[NSString stringWithFormat:@"%d ÷ %d=",a*b,b];
            self.result=[NSString stringWithFormat:@"%d",a];

            break;
    }
    
    
    return self;
}



-(int)myarcNumber500
{
    int number=0;
    number=arc4random()%500;
    if (number==0)
    {
        number=arc4random()%500;
    }
    return number;
}



-(int)myarcNumber30
{
    int number=0;

    number=arc4random()%30;
    if (number==0)
    {
        number=arc4random()%30;
    }
    return number;
}


@end
