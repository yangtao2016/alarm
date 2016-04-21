

#import "UserDefalutManager.h"

static UserDefalutManager *sharedManager;
static NSUserDefaults *ud;


@implementation UserDefalutManager

+ (UserDefalutManager *)sharedManager{
    
    static dispatch_once_t once;
    dispatch_once( &once, ^{
        sharedManager=[[self alloc] init];
        
        [sharedManager initDefaultData];
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

-(void)initDefaultData{
    
    ud = [NSUserDefaults standardUserDefaults];  // 取得
    NSMutableDictionary *element = [@{
                                      @"hour":@"07",@"minute":@"00"
                                    }mutableCopy];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[kAlarmTimeKey] = element;
    
    [ud registerDefaults:dict];
}


-(NSMutableDictionary *)getDefaultAlarmTime{
    
    NSMutableDictionary *result = [[ud objectForKey:kAlarmTimeKey]mutableCopy];
    return result;
}


-(void)setDefaultAlarmTime:(NSMutableDictionary *)element{
    [ud setObject:element forKey:kAlarmTimeKey];
    
    [ud synchronize];
}


-(BOOL)getDefaultAlarm{
    return [ud boolForKey:kIsAlarmKey];
}


-(void)setDefaultAlarm:(BOOL)isAlarm{

    [ud setBool:isAlarm forKey:kIsAlarmKey];
    
    [ud synchronize];
}


-(BOOL)getDisplayedAwakeAlarmView{
    
    return [ud boolForKey:kIsDisplayedAwakeAlarmViewKey];
}

-(void)setDisplayedAwakeAlarmView:(BOOL)isView{
    
    [ud setBool:isView forKey:kIsDisplayedAwakeAlarmViewKey];
    
    [ud synchronize];
}

-(NSDate *)getAlarmTimerDate{
    
    return [ud objectForKey:kAlarmTimerDateKey];
}


-(void)setAlarmTimerDate:(NSDate *)alarmTimerDate{
    [ud setObject:alarmTimerDate forKey:kAlarmTimerDateKey];
    [ud synchronize];
}

@end
