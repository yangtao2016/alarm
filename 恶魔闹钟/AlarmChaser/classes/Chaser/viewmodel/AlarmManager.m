


#import <AVFoundation/AVFoundation.h>

#import "AlarmManager.h"
#import "AppDelegate.h"
#import "UserDefalutManager.h"
#import "Router.h"


@interface AlarmManager()

@property (strong,nonatomic) AVAudioPlayer *audio;
@property (strong,nonatomic) AVAudioSession *session;
@property (strong,nonatomic) NSTimer *alarmTimer;

@end


static AlarmManager *sharedManager=nil;
static BOOL _isAdView;

@implementation AlarmManager

+ (AlarmManager *)sharedManager{
    
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


-(BOOL)isAdView{
    
    return _isAdView;
}

-(void)setAdView:(BOOL)isView{
    
    _isAdView = isView;
}


#pragma mark - functional


-(void)setBgm{
    
    self.session             = [AVAudioSession sharedInstance];
    [self.session setCategory:AVAudioSessionCategoryPlayback error:NULL];
    [self.session setActive:YES error:NULL];

    NSString *path           = [[NSBundle mainBundle] pathForResource:@"warning_04-high" ofType:@"mp3"];
    NSURL *url               = [NSURL fileURLWithPath:path];
    self.audio               = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.audio.numberOfLoops = -1;
    [self.audio prepareToPlay];
    
    
    if([UIApplication sharedApplication].applicationIconBadgeNumber >0 ){
        
        [self.audio play];
    }
    
}


-(void)stopBgm{
    
    [self.audio stop];
}


-(void)playBgm{
    
    [self.audio play];
    [[Router sharedManager] gotoAwakeAlarmViewController:YES];
}


-(void)setLocalNotification:(NSDate *)assginDate{
    
    
    UILocalNotification *notification       = [[UILocalNotification alloc] init];
    notification.fireDate                   = assginDate;
    notification.repeatCalendar             = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    notification.repeatInterval             = NSMinuteCalendarUnit;
//    NSMinuteCalendarUnit
    notification.timeZone                   = [NSTimeZone localTimeZone];
    notification.alertBody                  = @"再不疯狂我们就老了,赶紧点击吧";
    notification.soundName                  = @"warning_04-high.mp3";//UILocalNotificationDefaultSoundName;
//    notification.alertAction                = @"再不疯狂我们就老了";
    notification.applicationIconBadgeNumber = 1;
    notification.userInfo=@{@"isAlarm":@"is"};
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    [self setCustomEventNotification];
    
}


-(void)clearLocalNotification{
    
    
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    //取消某一个通知
    NSArray *notificaitons = [[UIApplication sharedApplication] scheduledLocalNotifications];
    //获取当前所有的本地通知
    if (!notificaitons || notificaitons.count <= 0) {
        return;
    }
    
    for (UILocalNotification *notify in notificaitons) {
        NSArray *arr=[notify.userInfo allKeys];
        
        if ([arr containsObject:@"isAlarm"])
        {
            //取消一个特定的通知
            [[UIApplication sharedApplication] cancelLocalNotification:notify];
            break;
        }
    }

    
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [self removeCustomEventNotification];
    
    [self stopBgm];
    
}

-(void)setCustomEventNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onCustomNotificationInActive)
                                                 name:[AppDelegate CUSTOM_NOTIFICATION_DID_RECEIVE_LOCAL_NOTIFICATION_IN_ACTIVE]
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onCustomNotificationStateActive)
                                                 name:[AppDelegate CUSTOM_NOTIFICATION_DID_RECEIVE_LOCAL_NOTIFICATION_STATE_ACTIVE]
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onCustomNotificationDidBecomeActive)
                                                 name:[AppDelegate CUSTOM_NOTIFICATION_DID_BECOME_ACTIVE]
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onCustomNotificationDidEnterBackGround)
                                                 name:[AppDelegate CUSTOM_NOTIFICATION_DID_ENTER_BACKGROUND]
                                               object:nil];
    
}


-(void)removeCustomEventNotification{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[AppDelegate CUSTOM_NOTIFICATION_DID_RECEIVE_LOCAL_NOTIFICATION_IN_ACTIVE] object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[AppDelegate CUSTOM_NOTIFICATION_DID_RECEIVE_LOCAL_NOTIFICATION_STATE_ACTIVE] object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[AppDelegate CUSTOM_NOTIFICATION_DID_BECOME_ACTIVE] object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[AppDelegate CUSTOM_NOTIFICATION_DID_ENTER_BACKGROUND] object:nil];
}

-(void)onCustomNotificationInActive{

    [self playBgm];
}


-(void)onCustomNotificationStateActive{    
    [self playBgm];
}

-(void)onCustomNotificationDidBecomeActive{
    
    if([UIApplication sharedApplication].applicationIconBadgeNumber >0 ){
        [self playBgm];
    }
    
}

-(void)onCustomNotificationDidEnterBackGround{
    [self stopBgm];
}


@end
