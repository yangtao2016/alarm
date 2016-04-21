//
//  helpViewController.m
//  AlarmChaser
//
//  Created by zhixian on 16/4/20.
//  Copyright © 2016年 tongari. All rights reserved.
//

#import "helpViewController.h"

@interface helpViewController ()

@end

@implementation helpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.separatorColor=[UIColor clearColor];

    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bake=[[UIView alloc]init];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, kAPPFRAMEWIDTH-20,100)];
    lab.font=[UIFont fontWithName:@"AxisStd-ExtraLight" size:16];
    lab.numberOfLines=0;
    lab.text=@[@"当你设置的闹钟到达指定的时间，会出现如下通知，为了你好，请尽快滑动，进入程序内取消，不要以为解锁后就没声音了，这仅仅是开始哦，如果你不尽快取消掉，我会每隔几分钟就给你提醒一下的，别怪我哦,祝你好运",@"每当闹钟响起，由通知进入程序，或者从前台进入程序，会进入到如下页面",@"当你完成题目，闹钟停止，祝你每天都有一个好心情，谢谢使用"][section];
    [bake addSubview:lab];
    return bake;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kAPPFRAMEHEIGHT-60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    UIImageView *icon=[cell.contentView viewWithTag:100];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        icon=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, kAPPFRAMEWIDTH-20, kAPPFRAMEHEIGHT-60)];
        icon.tag=100;
        [cell.contentView addSubview:icon];
        
        cell.backgroundColor=[UIColor clearColor];
    }
    
    icon.image=[UIImage imageNamed:@[@"help",@"help1",@"help2"][indexPath.section]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}










@end
