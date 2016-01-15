//
//  MDMyViewItem.h
//  MyDoctor
//
//  Created by 巫筠 on 15/11/25.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

//对界面图标文字进行管理的模型
#import <Foundation/Foundation.h>

@interface MDMyViewItem : NSObject

@property (nonatomic,copy) NSString * icon;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * rightImg;

+(instancetype)itemsWithIcon:(NSString *)icon andTitle:(NSString *)title andRightImage:(NSString *)rightImg;

@end
