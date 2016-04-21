//
//  YTextView.h
//  TaoYang
//
//  Created by zhixian on 16/3/3.
//  Copyright © 2016年 zhixian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTextView : UITextView
/**
 *  textView 中的提示语
 */
@property (strong, nonatomic) NSString * placeholder;

/**
 *  textView 中提示语的颜色
 */
@property (strong, nonatomic)UIColor * placeholderColor;

/**
 *  textView 中提示语的字号
 */
@property (strong, nonatomic)UIFont * placeholderFont;
@end
