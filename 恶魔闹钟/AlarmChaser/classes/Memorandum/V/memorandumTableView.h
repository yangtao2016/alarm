//
//  memorandumTableView.h
//  AlarmChaser
//
//  Created by zhixian on 16/4/14.
//  Copyright © 2016年 tongari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "memorandumTableViewCell.h"

@class memorandumTableView;
@protocol memorandumDelegate<NSObject>
-(void)memorandumDelegate:(memorandumTableView *)tableview withModel:(memorandumModel *)model withIndepath:(NSIndexPath*)indpath;

@end

@interface memorandumTableView : UITableView


@property(strong,nonatomic)NSMutableArray <memorandumModel*>*dataMemoRandumArr;

@property(nonatomic,assign)id<memorandumDelegate>memoRandumDelegate;

@end
