

#import "TimeManager.h"

static TimeManager *sharedManager=nil;

@implementation TimeManager

+ (TimeManager *)sharedManager{
    
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
-(NSMutableDictionary *)getNowDate{
    
    NSMutableDictionary *resultDate = [[NSMutableDictionary alloc]init];

    NSDate *nowDate                 = [NSDate date];
    
    NSCalendar *calendar            = [NSCalendar currentCalendar];
    
    NSUInteger flags                = NSYearCalendarUnit
                                        | NSMonthCalendarUnit
                                        | NSDayCalendarUnit
                                        | NSHourCalendarUnit
                                        | NSMinuteCalendarUnit
                                        | NSSecondCalendarUnit;

    NSDateComponents *comps         = [calendar components:flags fromDate:nowDate];

    NSDateFormatter* dataformat     = [[NSDateFormatter alloc] init];
    dataformat.locale               = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
//    [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
    
    NSString* monthStr              = dataformat.shortMonthSymbols[comps.month-1];
    
    resultDate[@"year"]             = [NSString stringWithFormat:@"%ld",(long)comps.year];
    resultDate[@"month"]            = [NSString stringWithFormat:@"%02ld",(long)comps.month];
    resultDate[@"day"]              = [NSString stringWithFormat:@"%02ld",(long)comps.day];
    resultDate[@"hour"]             = [NSString stringWithFormat:@"%02ld",(long)comps.hour];
    resultDate[@"minute"]           = [NSString stringWithFormat:@"%02ld",(long)comps.minute];
    resultDate[@"second"]           = [NSString stringWithFormat:@"%02ld",(long)comps.second];
    resultDate[@"monthStr"]         = monthStr;
    
    return resultDate;
}


-(NSMutableDictionary *)getAssignDate:(NSDate *)assginDate{
    NSMutableDictionary *resultDate = [[NSMutableDictionary alloc]init];
    
    NSCalendar *calendar            = [NSCalendar currentCalendar];
    
    NSUInteger flags                = NSHourCalendarUnit | NSMinuteCalendarUnit;
    
    NSDateComponents *comps         = [calendar components:flags fromDate:assginDate];
    
    resultDate[@"hour"]             = [NSString stringWithFormat:@"%02ld",(long)comps.hour];
    resultDate[@"minute"]           = [NSString stringWithFormat:@"%02ld",(long)comps.minute];
    
    return resultDate;
}

-(NSDate *)createDateFromHM:(NSString *)hour assginMinute:(NSString *)minute{
    
    NSCalendar *calendar         = [NSCalendar currentCalendar];
    NSUInteger flags;
    NSDateComponents *comps;

    flags                        = NSYearCalendarUnit
                                    | NSMonthCalendarUnit
                                    | NSDayCalendarUnit
                                    | NSHourCalendarUnit
                                    | NSMinuteCalendarUnit;
    
    comps                        = [calendar components:flags fromDate:[NSDate new]];

    NSDateComponents* components = [[NSDateComponents alloc] init];

    components.year              = comps.year;
    components.month             = comps.month;
    components.day               = comps.day;
    components.hour              = [hour intValue];
    components.minute            = [minute intValue];
    components.second            = 0;

    NSDate *resultDate           = [calendar dateFromComponents:components];
   

    return resultDate;
}


-(NSDate *)createTrimDateFromNSDate:(NSDate *)assginDate{
    
    NSCalendar *calendar         = [NSCalendar currentCalendar];
    NSUInteger flags;
    NSDateComponents *comps;

    flags                        = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
    comps                        = [calendar components:flags fromDate:assginDate];

    NSDateComponents* components = [[NSDateComponents alloc] init];

    components.year              = comps.year;
    components.month             = comps.month;
    components.day               = comps.day;
    components.hour              = comps.hour;
    components.minute            = comps.minute;
    components.second            = 0;

    NSDate *adjustDate           = [calendar dateFromComponents:components];
    
    return adjustDate;
}


-(NSDate *)convertAlarmDate:(NSDate *)assginDate{
    
    NSTimeInterval nowDate = [[NSDate new] timeIntervalSince1970];
    NSTimeInterval checkDate = [assginDate timeIntervalSince1970];
    
    
    if(checkDate <= nowDate){
        
        NSCalendar *calendar         = [NSCalendar currentCalendar];
        NSUInteger flags;
        NSDateComponents *comps;
        
        flags                        = NSYearCalendarUnit
        | NSMonthCalendarUnit
        | NSDayCalendarUnit
        | NSHourCalendarUnit
        | NSMinuteCalendarUnit;
        
        comps                        = [calendar components:flags fromDate:assginDate];
        
        NSDateComponents* components = [[NSDateComponents alloc] init];
        
        components.year              = comps.year;
        components.month             = comps.month;
        components.day               = comps.day + 1;
        components.hour              = comps.hour;
        components.minute            = comps.minute;
        components.second            = 0;
        
        NSDate *resultDate           = [calendar dateFromComponents:components];
        
        return resultDate;
        
        
    }else{
        
        return assginDate;
    }
    
    
}


@end
