//
//  MDMyViewItem.m
//  MyDoctor
//
//  Created by 巫筠 on 15/11/25.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDMyViewItem.h"

@implementation MDMyViewItem

+(instancetype)itemsWithIcon:(NSString *)icon andTitle:(NSString *)title andRightImage:(NSString *)rightImg
{
    MDMyViewItem * item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    item.rightImg = rightImg;
    return item;
}

@end
