//
//  BRSTextField.m
//  BRSClient
//
//  Created by 张昊辰 on 15/3/11.
//  Copyright (c) 2015年 minxing. All rights reserved.
//

#import "BRSTextField.h"

@implementation BRSTextField

-(id)initWithFrame:(CGRect)frame Icon:(UIImageView*)icon
{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftView = icon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

-(CGRect) leftViewRectForBounds:(CGRect)bounds {
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 10;// 右偏10
    return iconRect;
}

@end
