//
//  BRSChangePasswordViewController.h
//  BRSClient
//
//  Created by 张昊辰 on 15/3/17.
//  Copyright (c) 2015年 minxing. All rights reserved.
//

#import "MDBaseViewController.h"
#import "MDConst.h"

@interface BRSChangePasswordViewController : MDBaseViewController<UITableViewDataSource, UITableViewDelegate>
-(void)doChange:(NSString *)currentstr andNewPassword:(NSString *)newPassword;

@end
