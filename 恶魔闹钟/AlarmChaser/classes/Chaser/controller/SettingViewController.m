

#import "SettingViewController.h"
#import "UserDefalutManager.h"
#import "TimeManager.h"
#import "AlarmManager.h"
#import "Router.h"


@interface SettingViewController ()

@property (weak, nonatomic) IBOutlet UILabel *alarmTimeLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *alarmDatePicker;
@property (weak, nonatomic) IBOutlet UISwitch *alarmTimeSwitch;

@property (strong,nonatomic) UserDefalutManager *userDef;
@property (strong,nonatomic) TimeManager *timeManager;

- (IBAction)onChangeDatePicker:(UIDatePicker *)sender;
- (IBAction)onAlarmSwitch:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *icoChaser;
@property (weak, nonatomic) IBOutlet UIImageView *icoAlarm;

@end

@implementation SettingViewController

#pragma mark - functional contoroller method
- (void)viewDidLoad {
    [super viewDidLoad];

    self.userDef = [UserDefalutManager sharedManager];
    self.timeManager = [TimeManager sharedManager];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:0 animated:YES];

    [self.navigationController setNavigationBarHidden:NO animated:YES];

    self.alarmTimeSwitch.on = [self.userDef getDefaultAlarm];
    self.title=self.alarmTimeSwitch.on==YES?@"打开闹钟":@"关闭闹钟";
    
    
    [self setStateIcoAlarm];
    
    NSMutableDictionary *alarmTime = [self.userDef getDefaultAlarmTime];
    NSDate *createDate = [self.timeManager createDateFromHM:alarmTime[@"hour"] assginMinute:alarmTime[@"minute"]];
    [self.alarmDatePicker setDate:createDate];
        
    [self displayAlarmTimeToLabel];

}

//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    if (self.alarmTimeSwitch.on==NO) {
//        
//        self.alarmDatePicker.date=[NSDate date];
//        
//    }
//}

- (IBAction)onChangeDatePicker:(UIDatePicker *)sender {
    if(self.alarmTimeSwitch.on){

        [self saveAlarmTime];
        [self displayAlarmTimeToLabel];
        
        [self clearAlarmTimer ];
        [self createAlarmTimer];
    }
    
}

- (IBAction)onAlarmSwitch:(UISwitch *)sender {
    if(sender.on){
        
        [self saveAlarmTime];
        [self displayAlarmTimeToLabel];
        
        [self clearAlarmTimer ];
        [self createAlarmTimer];
        [self.userDef setDefaultAlarm:YES];
        
        [self confirmNotificationAlert];
        
    } else {

        [self clearAlarmTimer];
        [self.userDef setDefaultAlarm:NO];
        [self.userDef setDisplayedAwakeAlarmView:NO];
    }
    
    [self setStateIcoAlarm];
}

-(void)createAlarmTimer{
    
    NSDate *trimDate = [self.timeManager createTrimDateFromNSDate:self.alarmDatePicker.date];
    
    AlarmManager *alarmManager = [AlarmManager sharedManager];
    [alarmManager setLocalNotification:[self.timeManager convertAlarmDate:trimDate]];    
}

-(void)clearAlarmTimer{
    
    AlarmManager *alarmManager = [AlarmManager sharedManager];
    
    [alarmManager clearLocalNotification ];
}


- (void)saveAlarmTime{
    NSMutableDictionary *dict = [self.timeManager getAssignDate:self.alarmDatePicker.date];
    
    [ self.userDef setDefaultAlarmTime:[@{@"hour":dict[@"hour"],@"minute":dict[@"minute"]}mutableCopy] ];
}



#pragma mark - functonal view method

-(void)displayAlarmTimeToLabel{
    NSDictionary *alarmTimeObj = [self.userDef getDefaultAlarmTime];
    NSString *setStr = [NSString stringWithFormat:@"%@:%@",alarmTimeObj[@"hour"],alarmTimeObj[@"minute"]];
    
    self.alarmTimeLabel.text = setStr;
}

-(void)confirmNotificationAlert{
    
    if(NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1){
        return;
    }
    
    UIUserNotificationSettings *currentSettings = [[UIApplication
                                                    sharedApplication] currentUserNotificationSettings];
    
    if(currentSettings.types == UIUserNotificationTypeNone){
        
        UIAlertController * ac = [UIAlertController alertControllerWithTitle:@"提示"
                                                                     message:@"请在设置中打开通知权限"
                                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              
                                                          }];
        [ac addAction:okAction];
        
        [self presentViewController:ac animated:YES completion:nil];
    }
}


-(void)setStateIcoAlarm{
    if([[UserDefalutManager sharedManager] getDefaultAlarm]){
        self.icoChaser.hidden = NO;
        self.icoAlarm.hidden = YES;
        
    } else {
        
        self.icoChaser.hidden = YES;
        self.icoAlarm.hidden = NO;
    }
    self.title=self.alarmTimeSwitch.on==YES?@"打开闹钟":@"关闭闹钟";

}


@end
