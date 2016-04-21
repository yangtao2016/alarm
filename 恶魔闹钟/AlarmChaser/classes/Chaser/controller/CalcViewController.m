

#import "CalcViewController.h"
#import "AlarmManager.h"
#import "UserDefalutManager.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "JTSlideShadowAnimation.h"
#import "calcModel.h"





#import "TimeManager.h"
@interface CalcViewController ()<UIAlertViewDelegate>

@property (strong, nonatomic) JTSlideShadowAnimation *shadowAnimation;

@property(strong,nonatomic)NSMutableString *anserStr;

@property(strong,nonatomic)calcModel *calcModel;

@property(assign,nonatomic)float updateLimitBarValue;
@property(assign,nonatomic)float stackUpdateLimitBarValue;

@property(strong,nonatomic)NSTimer *limitTimer;
@property(strong,nonatomic)NSTimer *tickerTimer;

@property (weak, nonatomic) IBOutlet UIView *limitBar;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property(assign,nonatomic)NSInteger curCalcKeyTagID;

@property(strong,nonatomic)AVAudioPlayer *errorSE;
@property(strong,nonatomic)AVAudioPlayer *sucessSE;


- (IBAction)onTapCalcKey:(UIButton *)sender;
- (IBAction)deleteBackKey:(UIButton *)sender;
- (IBAction)onTapAnserButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *limitMeterRightMargin;

@end

//制限時間 3sec
const float kLimitTime = 40.0f;

@implementation CalcViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:0 animated:YES];

    
    // Do any additional setup after loading the view.
    NSString *pathErrorSE = [[NSBundle mainBundle] pathForResource:@"error_02" ofType:@"caf"];
    NSURL *urlErrorSE = [NSURL fileURLWithPath:pathErrorSE];
    self.errorSE = [[AVAudioPlayer alloc] initWithContentsOfURL:urlErrorSE error:nil];
    [self.errorSE prepareToPlay];
    
    NSString *pathSucessSE = [[NSBundle mainBundle] pathForResource:@"answer_02" ofType:@"caf"];
    NSURL *urlSucessSE = [NSURL fileURLWithPath:pathSucessSE];
    self.sucessSE = [[AVAudioPlayer alloc] initWithContentsOfURL:urlSucessSE error:nil];
    [self.sucessSE prepareToPlay];
    
    [[UserDefalutManager sharedManager] setDisplayedAwakeAlarmView:YES];
    
    
    
    self.shadowAnimation = [JTSlideShadowAnimation new];
    self.shadowAnimation.animatedView = self.confirmBtn;
    self.shadowAnimation.shadowForegroundColor=[UIColor redColor];
    self.shadowAnimation.shadowWidth =self.confirmBtn.frame.size.width/4;
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.updateLimitBarValue = [[UIScreen mainScreen]bounds].size.width / kLimitTime * 0.01;
    
    [self setQustion];
    [self createLimitbar];
    [self setCustomEventNotification];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self destoryLimitbar];
    [self removeCustomEventNotification];
    
    [[UserDefalutManager sharedManager] setDisplayedAwakeAlarmView:NO];
}


-(void)setCustomEventNotification{
    
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
                                                    name:[AppDelegate CUSTOM_NOTIFICATION_DID_BECOME_ACTIVE] object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[AppDelegate CUSTOM_NOTIFICATION_DID_ENTER_BACKGROUND] object:nil];
}


-(void)onCustomNotificationDidBecomeActive{
    
    [self createLimitbar];
}


-(void)onCustomNotificationDidEnterBackGround{
    
    [self destoryLimitbar];
}


- (IBAction)onTapCalcKey:(UIButton *)sender {
    
    AudioServicesPlaySystemSound(1104);
    
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    sender.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
    
    [UIView animateWithDuration:0.1f delay:0.1f options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         sender.backgroundColor = [UIColor whiteColor];
                     } completion:nil];
    
    
    if(self.anserStr.length > 4){
        return;
    }
    
    NSString *tapStr = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    self.anserStr = [NSMutableString stringWithFormat:@"%@%@",self.anserStr,tapStr];
    
    self.questionLabel.text = [NSString stringWithFormat:@"%@%@",self.calcModel.formula,self.anserStr];
    
}


- (IBAction)deleteBackKey:(UIButton *)sender {
    
    AudioServicesPlaySystemSound(1105);
    
    sender.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
    
    [UIView animateWithDuration:0.1f delay:0.1f options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         sender.backgroundColor = [UIColor whiteColor];
                     } completion:nil];
    
    if(self.anserStr.length > 0){
        NSInteger startIndex = self.anserStr.length-1;
        [self.anserStr deleteCharactersInRange:NSMakeRange(startIndex, 1)];
        
        self.questionLabel.text = [NSString stringWithFormat:@"%@%@",self.calcModel.formula,self.anserStr];
    }
    
}


- (IBAction)onTapAnserButton:(UIButton *)sender {
    
    int anser = [self.anserStr intValue];
    int question =[self.calcModel.result intValue];
    
    if(anser == question){
        
        [self destoryLimitbar];

        
        AlarmManager *alarmManager = [AlarmManager sharedManager];
        [alarmManager clearLocalNotification ];
        [[UserDefalutManager sharedManager] setDefaultAlarm:NO];
        
        
        
        
        
        
        
        
        
        
//        
/////////////////////////////////////////////////////////////////////////////
//        
//        [alarmManager setLocalNotification:[[TimeManager sharedManager] convertAlarmDate:[[UserDefalutManager sharedManager] getAlarmTimerDate]]];
//        
//        [[UserDefalutManager sharedManager] setDefaultAlarm:YES];
//
/////////////////////////////////////////////////////////////////////////////
     
        
        
        
        
        
        
        [self.sucessSE play];
        
        //IOS8
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
            
            UIAlertController * ac = [UIAlertController alertControllerWithTitle:@"早上好"
                                                                         message:@"愿每天叫醒你的不是我，是梦想"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  [self dismissViewControllerAnimated:YES completion:nil];
                                                              }];
            [ac addAction:okAction];
            
            [self presentViewController:ac animated:YES completion:nil];
            
        } else{
            
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"早上好" message:@"愿每天叫醒你的不是我，是梦想" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [av show];
        }
        
    } else {
        
        [self.errorSE play];
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        self.anserStr = [NSMutableString string];
        
        self.questionLabel.text = [NSString stringWithFormat:@"%@%@",self.calcModel.formula,self.anserStr];
    }
};


-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
    }
    
}


-(void)setLimitTimer{
    
    self.limitTimer = [NSTimer scheduledTimerWithTimeInterval:kLimitTime target:self selector:@selector(onCompleteLimitTimer:) userInfo:nil repeats:NO];
}

-(void)onCompleteLimitTimer:(NSTimer *)timer{

    [self destoryLimitbar];
    
    [self setQustion];
    [self createLimitbar];
}


-(void)setTickerTimer{
    self.tickerTimer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(onCompleteTickerTimer:) userInfo:nil repeats:YES];
}

-(void)onCompleteTickerTimer:(NSTimer *)timer{
    [self updateLimitBar];
}



#pragma mark - functional view method
-(void)setQustion{
    
    self.calcModel=[[calcModel alloc]init];
    self.anserStr = [NSMutableString string];
    self.questionLabel.text =[NSString stringWithFormat:@"%@?",self.calcModel.formula];
}


-(void)initLimitBar{
    
    self.limitMeterRightMargin.constant = [[UIScreen mainScreen] bounds].size.width;
    self.stackUpdateLimitBarValue = 0;
}

-(void)updateLimitBar{
    
    CGFloat maxWidth = [[UIScreen mainScreen] bounds].size.width;
    self.stackUpdateLimitBarValue += self.updateLimitBarValue;
    self.limitMeterRightMargin.constant = maxWidth - self.stackUpdateLimitBarValue;    
}

-(void)createLimitbar{
    [self initLimitBar];
    [self setLimitTimer];
    [self setTickerTimer];
}

-(void)destoryLimitbar{
    [self.tickerTimer invalidate];
    [self.limitTimer invalidate];
}



@end
