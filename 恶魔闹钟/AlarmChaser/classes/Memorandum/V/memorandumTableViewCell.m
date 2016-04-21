//
//  memorandumTableViewCell.m
//  AlarmChaser
//
//  Created by zhixian on 16/4/14.
//  Copyright © 2016年 tongari. All rights reserved.
//

#import "memorandumTableViewCell.h"

@implementation memorandumTableViewCell
{
    UILabel *timeLab;
    
    UILabel *titleLab;
    UILabel *subTitleLab;

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        timeLab=[[UILabel alloc]initWithFrame:CGRectMake(6,5, kAPPFRAMEWIDTH*0.26, 30)];
        timeLab.numberOfLines=0;
        timeLab.font=[UIFont fontWithName:@"AxisStd-ExtraLight" size:14];
        [self.contentView addSubview:timeLab];
        timeLab.userInteractionEnabled=NO;
        
        titleLab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeLab.frame)+10, 10, kAPPFRAMEWIDTH-CGRectGetMaxX(timeLab.frame)-20, 30)];
        titleLab.numberOfLines=0;
        titleLab.font=[UIFont fontWithName:@"AxisStd-ExtraLight" size:16];
        [self.contentView addSubview:titleLab];
        titleLab.userInteractionEnabled=NO;

        
        subTitleLab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeLab.frame)+10,CGRectGetMaxY(titleLab.frame)+5, kAPPFRAMEWIDTH-CGRectGetMaxX(timeLab.frame)-20, 30)];
        subTitleLab.numberOfLines=0;
        subTitleLab.font=[UIFont systemFontOfSize:14];
        subTitleLab.contentMode=UIViewContentModeTop;
        subTitleLab.textColor=[UIColor darkGrayColor];
        [self.contentView addSubview:subTitleLab];
        subTitleLab.userInteractionEnabled=NO;

        
    }

    return self;
}

-(void)setModel:(memorandumModel *)model
{
    _model=model;
    if (_model==nil)return;
    NSArray  * array= [_model.reminderTime componentsSeparatedByString:@","];
    timeLab.text=[NSString stringWithFormat:@"%@,%@,%@\n\n%@",array[0],array[1],array[2],array[3]];
    timeLab.frame=CGRectMake(6,5, kAPPFRAMEWIDTH*0.26,[self sizeWithLab:timeLab]);

    titleLab.text=_model.title;
    titleLab.frame=CGRectMake(CGRectGetMaxX(timeLab.frame)+10,10, kAPPFRAMEWIDTH-CGRectGetMaxX(timeLab.frame)-20,[self sizeWithLab:titleLab]);
    
    subTitleLab.text=_model.subTitle;
    subTitleLab.frame=CGRectMake(CGRectGetMaxX(timeLab.frame)+10,CGRectGetMaxY(titleLab.frame)+5, kAPPFRAMEWIDTH-CGRectGetMaxX(timeLab.frame)-20, [self sizeWithLab:subTitleLab]);
  
    self.height=CGRectGetMaxY(subTitleLab.frame)+10;
}


// 定义成方法方便多个label调用 增加代码的复用性
-(CGFloat)sizeWithLab:(UILabel *)lab
{
    CGRect rect = [lab.text boundingRectWithSize:CGSizeMake(lab.width, 1000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: lab.font}//传人的字体字典
                                       context:nil];
    
    return rect.size.height+2;
}



@end
