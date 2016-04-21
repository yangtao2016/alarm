

#import <Foundation/Foundation.h>

@interface AlarmManager : NSObject

+(AlarmManager *)sharedManager;


-(void)setLocalNotification:(NSDate *)assginDate;
-(void)clearLocalNotification;

-(void)setBgm;
-(void)stopBgm;

-(BOOL)isAdView;
-(void)setAdView:(BOOL)isView;

@end
