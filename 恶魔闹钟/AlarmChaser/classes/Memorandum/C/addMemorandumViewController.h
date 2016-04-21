//
//  addMemorandumViewController.h
//  AlarmChaser
//
//  Created by zhixian on 16/4/14.
//  Copyright © 2016年 tongari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "memorandumModel.h"
@interface addMemorandumViewController : UITableViewController

@property(nonatomic,strong)memorandumModel *model;

@property(nonatomic,assign)NSInteger index;

@end
