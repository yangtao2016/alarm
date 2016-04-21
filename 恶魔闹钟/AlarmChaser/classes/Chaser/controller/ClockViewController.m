

#import "ClockViewController.h"
#import "TimeManager.h"
#import "UserDefalutManager.h"
#import "Router.h"
#import "memorandumViewController.h"
#import "ZYAnimationLayer.h"
#import "DragButton.h"
#import "CalendarHomeViewController.h"
#import "AppDelegate.h"
#import "HYBBubbleTransition.h"
@interface ClockViewController ()

@property (nonatomic, strong) HYBBubbleTransition *bubbleTransition;


@property (weak, nonatomic) IBOutlet UIButton *alarmTimeButton;
@property (weak, nonatomic) IBOutlet UIView *alarmTimeButtonWrapper;//下半部view

@property (weak, nonatomic) IBOutlet UIImageView *icoChaser;
@property (weak, nonatomic) IBOutlet UIImageView *icoAlarm;


@property (weak, nonatomic) IBOutlet UIImageView *toSettingButtonIco;

- (IBAction)onTapToSettingButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
- (IBAction)calenderBtn:(UIButton *)sender;

@end

@implementation ClockViewController

#pragma mark - functional controller method

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"";
    self.navigationItem.backBarButtonItem = barButton;
    
    self.icoAlarm.image = [self.icoAlarm.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.icoAlarm.tintColor = [UIColor whiteColor];
    
    self.icoChaser.image = [self.icoChaser.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.icoChaser.tintColor = [UIColor whiteColor];
    
    [ZYAnimationLayer createAnimationLayerWithString:@"备忘录  " andRect:CGRectMake(0, 0,kAPPFRAMEWIDTH,self.view.height/2) andView:self.editBtn andFont:[UIFont fontWithName:@"AxisStd-Light" size:46] andStrokeColor:[UIColor blackColor]];
    
    

    
    
    [[Router sharedManager] displayAwakeAlarmView];

    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AppDelegate *app=[UIApplication sharedApplication].delegate;
    [app.sliderVC setPanEnabled:YES];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self displayAlarmTimeToLabel];
    
    self.toSettingButtonIco.alpha = 1;
    self.icoChaser.alpha = 1;
    self.icoAlarm.alpha = 1;
    
    [self setStateIcoAlarm];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

//    AppDelegate *app=[UIApplication sharedApplication].delegate;
//    [app.sliderVC setPanEnabled:NO];
}

#pragma mark -functional view method


-(void)displayAlarmTimeToLabel{
    
    UserDefalutManager *userDef = [UserDefalutManager sharedManager];
    
    NSDictionary *alarmTimeObj = [userDef getDefaultAlarmTime];
    NSString *setStr = [NSString stringWithFormat:@"%@:%@",alarmTimeObj[@"hour"],alarmTimeObj[@"minute"]];
    
    [self.alarmTimeButton setTitle:setStr forState:UIControlStateNormal];
    
    if([userDef getDefaultAlarm]){
        
        self.alarmTimeButtonWrapper.backgroundColor = [UIColor colorWithRed:28.0f/255.0f green:28.0f/255.0f blue:28.0f/255.0f alpha:1.0f];
        
    } else {

        self.alarmTimeButtonWrapper.backgroundColor = [UIColor colorWithRed:170.0f/255.0f green:170.0f/255.0f blue:170.0f/255.0f alpha:1.0f];
    }
}

-(void)setStateIcoAlarm{
    if([[UserDefalutManager sharedManager] getDefaultAlarm]){
        self.icoChaser.hidden = NO;
        self.icoAlarm.hidden = YES;
        [[UIApplication sharedApplication] setStatusBarStyle:1 animated:YES];
    } else {
        
        self.icoChaser.hidden = YES;
        self.icoAlarm.hidden = NO;
        [[UIApplication sharedApplication] setStatusBarStyle:0 animated:YES];
    }
    
}


- (IBAction)onTapToSettingButton:(UIButton *)sender {
    self.toSettingButtonIco.alpha = 0.3;
    self.icoChaser.alpha = 0.3;
    self.icoAlarm.alpha = 0.3;
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    
//    
//}

- (IBAction)calenderBtn:(UIButton *)sender {
    
    
    CalendarHomeViewController *leftVc=[[CalendarHomeViewController alloc]init];
    [leftVc setAirPlaneToDay:365 ToDateforString:[NSString stringWithFormat:@"%@",[NSDate date]]];
    leftVc.calendartitle=@"日历";
    
    leftVc.modalPresentationStyle = UIModalPresentationCustom;
    
    // Remember to own it strongly
    // Because delegate is weak reference, and it will be released after out of the function body.
    self.bubbleTransition = [[HYBBubbleTransition alloc] initWithPresented:^(UIViewController *presented, UIViewController *presenting, UIViewController *source, HYBBaseTransition *transition) {
        // You need to cast type to the real subclass type.
        HYBBubbleTransition *bubble = (HYBBubbleTransition *)transition;
       bubble.duration=0.5;
//       bubble.animatedWithSpring = YES;
        bubble.bubbleColor = presented.view.backgroundColor;
        bubble.bubbleStartPoint =sender.center;
    } dismissed:^(UIViewController *dismissed, HYBBaseTransition *transition) {

        transition.transitionMode = kHYBTransitionDismiss;
    }];
    
    leftVc.transitioningDelegate = self.bubbleTransition;
    [self presentViewController:leftVc animated:YES completion:NULL];
}
@end
