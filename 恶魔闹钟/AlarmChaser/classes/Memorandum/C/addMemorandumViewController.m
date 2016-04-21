//
//  addMemorandumViewController.m
//  AlarmChaser
//
//  Created by zhixian on 16/4/14.
//  Copyright © 2016年 tongari. All rights reserved.
//

#import "addMemorandumViewController.h"
#import "YTextView.h"
@interface addMemorandumViewController ()<UITextViewDelegate,UITextFieldDelegate>
{
    
    YTextView  *titleTF;
    YTextView  *subTitleTV;
    UIDatePicker *datePicker;
    
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightItem;

- (IBAction)okItemClik:(id)sender;

@end

@implementation addMemorandumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_model==nil)
    {
        _model=[[memorandumModel alloc]init];
        self.title=@"添加事件";
    }else{
        self.title=@"编辑事件";
    }

    
    self.view.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    if (datePicker==nil)
//    {
//        self.tableView.tableFooterView=[self tableViewFootView];
//    }
}

-(UIView *)tableViewFootView
{
    
    NSDate *now=[NSDate date];
    datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, kAPPFRAMEWIDTH, 200)];
    datePicker.minimumDate=now;
    datePicker.datePickerMode=UIDatePickerModeDateAndTime;
    if ([self.title isEqualToString:@"编辑事件"])
    {
     datePicker.date=[memorandumModel bakeDateWithsting:self.model.reminderTime];
    }
    [datePicker  addTarget:self action:@selector(dateChang:) forControlEvents:UIControlEventValueChanged];
    return datePicker;
}

-(void)dateChang:(UIDatePicker *)picker
{
    _model.reminderTime=[memorandumModel bakesStringWithdate:picker.date];
 }

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *headLab=[[UIButton alloc]init];
    headLab.backgroundColor=[UIColor whiteColor];
    [headLab setTitle:@[@"标题",@"详细内容",@"选择提醒时间"][section] forState:0];
    [headLab setTitleColor:[UIColor grayColor] forState:0];
    headLab.titleLabel.font=[UIFont fontWithName:@"AxisStd-ExtraLight" size:14];
    headLab.layer.borderColor=[UIColor darkGrayColor].CGColor;
    headLab.layer.borderWidth=0.6;
    [headLab addTarget:self action:@selector(headBtnClik) forControlEvents:UIControlEventTouchUpInside];
    headLab.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];
    return headLab;
}

-(void)headBtnClik
{
    [self.view endEditing:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==0)
    {
        return 50;
    }else if(indexPath.section==1){
        return 150;
    }else{
    
    
        return 200;
    }
    

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID=@"cellID";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    YTextView*TV=[cell.contentView viewWithTag:100];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        cell.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];
        CGFloat h=indexPath.section==0?50:240;
        TV=[[YTextView alloc]initWithFrame:CGRectMake(10, 0, kAPPFRAMEWIDTH-15,h)];
        TV.font=[UIFont systemFontOfSize:15];
        TV.tag=100;
        TV.delegate=self;
        TV.textAlignment=NSTextAlignmentLeft;
        [cell.contentView addSubview:TV];
    }
    
    if (indexPath.section==0)
    {
        titleTF=TV;
        TV.placeholder=@"请输入标题";
        titleTF.text=_model.title;
        
        
    }else if (indexPath.section==1)
    {
        
        subTitleTV=TV;
        TV.placeholder=@"请输入内容";
        subTitleTV.text=_model.subTitle;
    }else{
        TV.placeholder=@"";
        TV.text=@"";
        
        [cell.contentView removeFromSuperview];
        NSDate *now=[NSDate date];
        datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, kAPPFRAMEWIDTH, 200)];
        datePicker.minimumDate=now;
        datePicker.datePickerMode=UIDatePickerModeDateAndTime;
        if ([self.title isEqualToString:@"编辑事件"])
        {
            datePicker.date=[memorandumModel bakeDateWithsting:self.model.reminderTime];
        }
        [datePicker  addTarget:self action:@selector(dateChang:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:datePicker];
    
     }
    
    return cell;
}


-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    if ([textView isEqual:titleTF])
    {
        self.model.title=textView.text;
        
    }else{
        self.model.subTitle=textView.text;
    }

}


- (IBAction)okItemClik:(id)sender {
    
    [self.view endEditing:YES];
    
    if (titleTF.text.length==0||titleTF.text==nil)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写标题" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [titleTF becomeFirstResponder];
        return;
    }
    
    if (subTitleTV.text.length==0||subTitleTV.text==nil)
    {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写内容" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [subTitleTV becomeFirstResponder];
        return;
    }
    
    NSDate *earlierDateIs = [[NSDate date] earlierDate:datePicker.date];
    
    if ([datePicker.date isEqualToDate:earlierDateIs])
    {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择提醒的时间大于现在时间" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    
    self.model.editTime=[memorandumModel bakesStringWithdate:[NSDate date]];
    
    [self savaData];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/**
 *  储存数据
 */
-(void)savaData{
    
    //创建存储的数组
    NSMutableArray *dataArray=[memorandumModel getdataArray];
    
    if ([self.title isEqualToString:@"添加事件"])
    {
        [dataArray addObject:self.model];
    }
    else{
        [self delenot:dataArray[self.index]];
        [dataArray removeObjectAtIndex:self.index];
        [dataArray addObject:self.model];
    }
    
    BOOL isOK=[NSKeyedArchiver archiveRootObject:dataArray toFile:dataFilePath];
    if (isOK==YES)
    {
        [self addnsnot];
    }
}


-(void)addnsnot{

    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    //设置本地通知的触发时间（如果要立即触发，无需设置），这里设置为20妙后
    localNotification.fireDate =[memorandumModel bakeDateWithsting:self.model.reminderTime];
    //设置本地通知的时区
    localNotification.timeZone = [NSTimeZone localTimeZone];
    //设置通知的内容
    localNotification.alertBody =self.model.subTitle;
    //设置通知动作按钮的标题
    localNotification.alertTitle =self.model.title;
    //设置提醒的声音，可以自己添加声音文件，这里设置为默认提示声
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    //设置通知的相关信息，这个很重要，可以添加一些标记性内容，方便以后区分和获取通知的信息
//    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:LOCAL_NOTIFY_SCHEDULE_ID,@"id",[NSNumber numberWithInteger:time],@"time",[NSNumber numberWithInt:affair.aid],@"affair.aid", nil];
//    localNotification.userInfo = infoDic;
    localNotification.userInfo=@{@"modelId":self.model.modelId};
    //在规定的日期触发通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}


-(void)delenot:(memorandumModel *)model
{

    //取消某一个通知
    NSArray *notificaitons = [[UIApplication sharedApplication] scheduledLocalNotifications];
    //获取当前所有的本地通知
    if (!notificaitons || notificaitons.count <= 0) {
        return;
    }
    
    for (UILocalNotification *notify in notificaitons) {
        if ([[notify.userInfo objectForKey:@"modelId"] isEqualToString:model.modelId])
        {
            //取消一个特定的通知
            [[UIApplication sharedApplication] cancelLocalNotification:notify];
            break;
        }
    }
}



@end
