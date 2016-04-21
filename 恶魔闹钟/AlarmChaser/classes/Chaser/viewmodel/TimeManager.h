

#import <Foundation/Foundation.h>

@interface TimeManager : NSObject

+(TimeManager *)sharedManager;

-(NSMutableDictionary *)getNowDate;
-(NSMutableDictionary *)getAssignDate:(NSDate *)assginDate;

-(NSDate *)createDateFromHM:(NSString *)hour assginMinute:(NSString *)minute;
-(NSDate *)createTrimDateFromNSDate:(NSDate *)assginDate;


-(NSDate *)convertAlarmDate:(NSDate *)assginDate;

@end
