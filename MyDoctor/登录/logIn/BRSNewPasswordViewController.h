//
//  BRSNewPasswordViewController.h
//  BRSClient
//
//  Created by 张昊辰 on 15/4/2.
//  Copyright (c) 2015年 minxing. All rights reserved.
//

#import "MDBaseViewController.h"

@interface BRSNewPasswordViewController : MDBaseViewController<UITextFieldDelegate>

@property (nonatomic, strong) NSString * login_name;
@property (nonatomic, strong) NSString * auth_code;

@end
