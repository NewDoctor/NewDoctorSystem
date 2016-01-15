//
//  BRSSignIn2ViewController.h
//  BRSClient
//
//  Created by 张昊辰 on 15/3/10.
//  Copyright (c) 2015年 minxing. All rights reserved.
//

#import "MDBaseViewController.h"
//#import "BRSTokenVO.h"
@interface BRSSignIn2ViewController : MDBaseViewController<UITextFieldDelegate>
//{
//    BRSTokenVO * tokenObject;
//}
@property (nonatomic, strong) NSString *login_name;
@property (nonatomic, strong) NSString *auth_code;

@end
