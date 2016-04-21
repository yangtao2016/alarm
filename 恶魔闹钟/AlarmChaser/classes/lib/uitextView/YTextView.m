//
//  YTextView.m
//  TaoYang
//
//  Created by zhixian on 16/3/3.
//  Copyright © 2016年 zhixian. All rights reserved.
//

#import "YTextView.h"

@interface YTextView ()

@property (strong, nonatomic)UILabel * label;


@end




@implementation YTextView

//初始化

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self otherFrom];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self otherFrom];
    }
    return self;
}



//初始化sb

- (void)awakeFromNib
{
    [self otherFrom];
    
}


-(void)otherFrom
{
//    self.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];

    self.label = [[UILabel alloc]init];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.numberOfLines = 0;
    [self addSubview:self.label];
    
    
    self.placeholderColor = [UIColor lightGrayColor]; //设置 颜色
    self.placeholderFont = [UIFont systemFontOfSize:14]; //设置字体大小
    self.font=self.placeholderFont;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    
    
}

#pragma mark 文字改变
- (void)textChange
{
    _label.hidden = self.hasText;
}

#pragma mark 设置占位字符
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _label.text = placeholder;
    
    // 计算子控件
    [self setNeedsLayout];
}

#pragma mark 颜色
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    _label.textColor = placeholderColor;
}

#pragma mark  字体
- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
    _placeholderFont = placeholderFont;
    _label.font = placeholderFont;
    [self setNeedsLayout];
}

#pragma mark 重写自身方法
- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textChange]; //调用通知的回调
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textChange]; //调用通知的回调
}

#pragma 布局加载时设置Label的frame
- (void)layoutSubviews
{
    // 设置坐标
    CGFloat labelX = 5;
    CGFloat labelY = 8;
    CGFloat labelW = self.frame.size.width - labelX*2;
    // 根据文字计算高度
    CGSize maxSize = CGSizeMake(labelW, MAXFLOAT);
    
    CGSize textSize = [_placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_placeholderFont} context:nil].size;
    CGFloat labelH = textSize.height;
    
    // 设置Frame
    _label.frame = CGRectMake(labelX, labelY, labelW, labelH);
}

#pragma mark 移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
