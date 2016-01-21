//
//  BRSChangePasswordView.h
//  BRSClient
//
//  Created by 张昊辰 on 15/3/17.
//  Copyright (c) 2015年 minxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>


@class BRSChangePasswordViewController;
@interface BRSChangePasswordView : UIView


@property (nonatomic, assign) BRSChangePasswordViewController *controller;

-(void)cleanTF;

-(void)changeFinishButtonEnabled:(BOOL)enabled;

@end
