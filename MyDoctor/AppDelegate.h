//
//  AppDelegate.h
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/23.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeTuiSdk.h"

/// 个推开发者网站中申请App时注册的AppId、AppKey、AppSecret
#define kGtAppId           @"HRYig9AOds6l7s1zPaWrf"
#define kGtAppKey          @"kxEFKFTzvd6XiIfNHjjk84"
#define kGtAppSecret       @"npBt85rS5AAp1BHNPUI2W5"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,GeTuiSdkDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UITabBarController *tabBarController;


@end

