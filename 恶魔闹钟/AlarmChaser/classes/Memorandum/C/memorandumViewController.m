//
//  memorandumViewController.m
//  AlarmChaser
//
//  Created by zhixian on 16/4/14.
//  Copyright © 2016年 tongari. All rights reserved.
//

#import "memorandumViewController.h"
#import "memorandumTableView.h"
#import "addMemorandumViewController.h"
@interface memorandumViewController ()<memorandumDelegate>
{
    memorandumTableView *_tableview;
    
    NSMutableArray *dataArr;
//    NSMutableArray *outDataArr;
    
}
- (IBAction)addMemorand:(id)sender;

@end

@implementation memorandumViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:0 animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    dataArr =[memorandumModel getdataArray];

    if (_tableview==nil)
    {
        _tableview=[[memorandumTableView alloc]initWithFrame:self.view.frame style:1];
        _tableview.memoRandumDelegate=self;
        [self.view addSubview:_tableview];
    }
    
    _tableview.dataMemoRandumArr=dataArr;


}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"";
    self.navigationItem.backBarButtonItem = barButton;

    self.title=@"备忘录";
    
}



#pragma mark 备忘录数据点击回调
-(void)memorandumDelegate:(memorandumTableView *)tableview withModel:(memorandumModel *)model withIndepath:(NSIndexPath *)indpath
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    addMemorandumViewController *vc = [story instantiateViewControllerWithIdentifier:@"add"];
    vc.model=model;

    [self.navigationController pushViewController:vc animated:YES];
    

}


- (IBAction)addMemorand:(id)sender {
    

}
@end
