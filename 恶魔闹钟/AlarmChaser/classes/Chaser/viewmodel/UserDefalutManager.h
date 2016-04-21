






#import <Foundation/Foundation.h>


@interface UserDefalutManager : NSObject

+(UserDefalutManager *)sharedManager;

#define kAlarmTimeKey @"AlarmChaserUserDefalutAlarmTime"
#define kIsAlarmKey @"AlarmChaserUserDefalutAlarm"
#define kIsBgmPlayKey @"AlarmChaserUserDefalutBgmPlay"
#define kIsDisplayedAwakeAlarmViewKey @"AlarmChaserUserDefalutDisplayedAwakeAlarmView"
#define kAlarmTimerDateKey @"AlarmChaserUserDefalutAlarmTimerDate"

//extern const NSString *kAlarmTimeKey;

-(NSMutableDictionary *)getDefaultAlarmTime;
-(void)setDefaultAlarmTime:(NSMutableDictionary *)element;

-(BOOL)getDefaultAlarm;
-(void)setDefaultAlarm:(BOOL)isAlarm;


-(BOOL)getDisplayedAwakeAlarmView;
-(void)setDisplayedAwakeAlarmView:(BOOL)isView;

-(NSDate *)getAlarmTimerDate;
-(void)setAlarmTimerDate:(NSDate *)alarmTimerDate;

@end
