//
//  memorandumModel.m
//  AlarmChaser
//
//  Created by zhixian on 16/4/14.
//  Copyright © 2016年 tongari. All rights reserved.
//

#import "memorandumModel.h"

@implementation memorandumModel


-(NSString *)modelId
{
    _modelId=[NSString stringWithFormat:@"%@%@",self.editTime,self.reminderTime];
    return _modelId;
}

+(NSMutableArray *)getdataArray
 {
    
     
     NSMutableArray* array=[NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:dataFilePath]];
     if(nil == array) {
         
         array = [[NSMutableArray alloc] init];
     }
     
     NSArray*sorte = [array sortedArrayUsingComparator:^NSComparisonResult(memorandumModel *objcA,memorandumModel *objcB) {
         return [objcA.reminderTime compare:objcB.reminderTime options:NSNumericSearch];
     }];
     
     [array removeAllObjects];
     [array addObjectsFromArray:sorte];
     
    return array;
}


+(NSDate *)bakeDateWithsting:(NSString*)string
{
    NSDateFormatter *inputFormatter =[[NSDateFormatter alloc] init];
//    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyy,MM,dd,HH:mm"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
   
    return inputDate;
}

+(NSString *)bakesStringWithdate:(NSDate*)date
{

    NSDateFormatter *inputFormatter =[[NSDateFormatter alloc] init];
    //    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyy,MM,dd,HH:mm"];
    NSString *stingDate=[inputFormatter stringFromDate:date];
    
    return stingDate;
}



@end
