//
//  memorandumTableView.m
//  AlarmChaser
//
//  Created by zhixian on 16/4/14.
//  Copyright © 2016年 tongari. All rights reserved.
//

#import "memorandumTableView.h"


@interface memorandumTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation memorandumTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self=[super initWithFrame:frame style:style];
    if (self)
    {
        self.dataSource=self;
        self.delegate=self;
        self.tableFooterView=[[UIView alloc]init];
        self.tag=987654;
        self.dataMemoRandumArr=[NSMutableArray array];
    }
    
    return self;
}

-(void)setDataMemoRandumArr:(NSMutableArray *)dataMemoRandumArr
{
    _dataMemoRandumArr=dataMemoRandumArr;
    [self reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.height;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataMemoRandumArr==nil?0:_dataMemoRandumArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    memorandumTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[memorandumTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.model=_dataMemoRandumArr[indexPath.section];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.memoRandumDelegate respondsToSelector:@selector(memorandumDelegate:withModel:withIndepath:)])
    {
        [self.memoRandumDelegate memorandumDelegate:self withModel:_dataMemoRandumArr[indexPath.section] withIndepath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
 return @"删除\n提醒";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UITableViewCellEditingStyleDelete)
    {
        //从数据源中删除该行
        [self delenot:self.dataMemoRandumArr[indexPath.section]];
        [self.dataMemoRandumArr removeObjectAtIndex:indexPath.section];
        [NSKeyedArchiver archiveRootObject:self.dataMemoRandumArr toFile:dataFilePath];
        
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationRight];
    }
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
