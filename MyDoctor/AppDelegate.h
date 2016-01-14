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
#define kGtAppId           @"lZTx6vCP65A6Mb7Jo5asC"
#define kGtAppKey          @"W8mSnrTZFW7EU9T98O2SU6"
#define kGtAppSecret       @"IThSX5nTYI8hIHrBXHAaz9"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,GeTuiSdkDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UITabBarController *tabBarController;


@end

