//
//  DragButton.h
//  DragButtonDemo
//
//  Created by zhang zhiyu on 13-8-23.
//  Copyright (c) 2013年 York. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DragButton : UIButton
{
    BOOL dragEnable;
    
    @private
    CGPoint beginPoint;
    BOOL isMoved;
}

//default value: YES
@property (nonatomic,assign) BOOL dragEnable;


@end
