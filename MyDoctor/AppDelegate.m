//
//  AppDelegate.m
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/23.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import "AppDelegate.h"
#import "MDMyViewController.h"
#import "BRSlogInViewController.h"

#import "DocHomeViewController.h"
#import "MainViewController.h"
//#import "DocMyViewController.h"
#import "EaseMob.h"



@interface AppDelegate ()

@end

@implementation AppDelegate
{
    UINavigationController *homeNav;
    UINavigationController *serviceNav;
    UINavigationController *myNav;
    MDMyViewController * my;

    DocHomeViewController * docHome;
    MainViewController * docPatient;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"crossgk#ehealth" apnsCertName:@"MyDoctor_Doc_Dev"];//环信
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    // 通过个推平台分配的appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    
    // 注册APNS
    [self registerUserNotification];
    
    // 处理远程通知启动APP
    [self receiveNotificationByLaunchingOptions:launchOptions];
    
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }


    NSString *homeDirectory = NSHomeDirectory();
    NSLog(@"path:%@", homeDirectory);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showBRSMainView"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDocView) name:@"showBRSMainView" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"endLoginCount"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logIn) name:@"endLoginCount" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"backselected1"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backselected1) name:@"backselected1" object:nil];
    
//    UIImage*draw = [UIImage imageNamed:@"topImg"];
//    UIImageView *drawView = [[UIImageView alloc]initWithImage:draw];
//    [drawView setFrame:appFrame];
//    [self.window addSubview:drawView];
    
    NSUserDefaults * stdDefault = [NSUserDefaults standardUserDefaults];
    NSString * str=[stdDefault objectForKey:@"user_name"];
    if ([str length]>0) {
        [self showDocView];
    }else{
        [self logIn];
    }
    
    //医生端
//
//    [self showMainView];
    [[UINavigationBar appearance] setBackgroundColor:RGBACOLOR(239, 239, 239, 1)];
//    [[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
   
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUnreadCount:) name:@"setUnReadCount" object:nil];
    
    
    return YES;
}


-(void)setUnreadCount:(NSNotification *)notif
{
    NSString * count = [notif object];
    if ([count isEqualToString:@"0"]) {
        serviceNav.tabBarItem.badgeValue = nil;
    }
    else
    {
        serviceNav.tabBarItem.badgeValue = count;
    }
//    serviceNav.tabBarItem.badgeValue = [notif.userInfo objectForKey:@"unReadCount"];
//    serviceNav.tabBarItem.badgeValue = [NSString stringWithFormat:@"%@",[notif.userInfo objectForKey:@"unReadCount"]];
//    NSLog(@"=================%@",[notif.userInfo objectForKey:@"unReadCount"]);
}

-(void)logIn
{
    BRSlogInViewController * liv=[[BRSlogInViewController alloc] init];
    UINavigationController * nvc=[[UINavigationController alloc] initWithRootViewController:liv];
    self.window.rootViewController=nvc;
    [self.window makeKeyAndVisible];

}

/** 注册用户通知 */
- (void)registerUserNotification {
    
    /*
     注册通知(推送)
     申请App需要接受来自服务商提供推送消息
     */
    
    // 判读系统版本是否是“iOS 8.0”以上
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ||
        [UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        
        // 定义用户通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
        // 定义用户通知设置
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        // 注册用户通知 - 根据用户通知设置
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else { // iOS8.0 以前远程推送设置方式
        // 定义远程通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        
        // 注册远程通知 -根据远程通知类型
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
}

/** 自定义：APP被“推送”启动时处理推送消息处理（APP 未启动--》启动）*/
- (void)receiveNotificationByLaunchingOptions:(NSDictionary *)launchOptions {
    if (!launchOptions)
        return;
    
    /*
     通过“远程推送”启动APP
     UIApplicationLaunchOptionsRemoteNotificationKey 远程推送Key
     */
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSLog(@"\n>>>[Launching RemoteNotification]:%@", userInfo);
    }
}

-(void)backselected1
{
    // 跳到指定页面
    [self.tabBarController setSelectedIndex:0];
}

/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *myToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    myToken = [myToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    [GeTuiSdk registerDeviceToken:myToken];    /// 向个推服务器注册deviceToken
    
     [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [GeTuiSdk registerDeviceToken:@""];// 如果APNS注册失败，通知个推服务器
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
    NSLog(@"\n>>>[DeviceToken Error]:%@\n\n",error.description);
}


- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    /// Background Fetch 恢复SDK 运行
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
}


/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    // [4-EXT-1]: 个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}


/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    // 处理APNs代码，通过userInfo可以取到推送的信息（包括内容，角标，自定义参数等）。如果需要弹窗等其他操作，则需要自行编码。
    NSLog(@"\n>>>[Receive RemoteNotification - Background Fetch]:%@\n\n",userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}



#pragma mark - mainView
@synthesize tabBarController = _tabBarController;

-(void)showDocView
{
    _tabBarController = [[UITabBarController alloc] init];
    _tabBarController.delegate = self;
    _tabBarController.tabBar.backgroundImage = nil;
    _tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    _tabBarController.tabBar.selectedImageTintColor = [UIColor colorWithRed:14/255.0 green:194/255.0 blue:14/255.0 alpha:1];
    
    docHome=[[DocHomeViewController alloc] init];
    homeNav=[[UINavigationController alloc] initWithRootViewController:docHome];
    UIImage * normalImage = [UIImage imageNamed:@"homeback"];
    UIImage *selectImage = [UIImage imageNamed:@"home"];
    homeNav.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"首页" image:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    docPatient=[[MainViewController alloc] init];
    [docPatient networkChanged:eEMConnectionConnected];
    serviceNav=[[UINavigationController alloc] initWithRootViewController:docPatient];
    normalImage = [UIImage imageNamed:@"serviceback"];
    selectImage = [UIImage imageNamed:@"service"];
    serviceNav.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"会话" image:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    serviceNav.tabBarItem.badgeValue = @"12";
    
    my=[[MDMyViewController alloc] init];
    myNav = [[UINavigationController alloc] initWithRootViewController:my];
    normalImage = [UIImage imageNamed:@"myback"];
    selectImage = [UIImage imageNamed:@"my"];
    myNav.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"我的" image:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    _tabBarController.viewControllers = [NSArray arrayWithObjects:homeNav,serviceNav,myNav, nil];
    _tabBarController.view.backgroundColor=[UIColor whiteColor];
    [self.window setRootViewController:_tabBarController];
    [self.window makeKeyAndVisible];
    [self applicationWillEnterForeground:nil];//主动触发一次fromlastseen
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 20)];
    
    statusBarView.backgroundColor=RGBACOLOR(246, 246, 246, 1);
    
    [self.window addSubview:statusBarView];
}


- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];//环信进入后台

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];//环信要从后台返回

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
