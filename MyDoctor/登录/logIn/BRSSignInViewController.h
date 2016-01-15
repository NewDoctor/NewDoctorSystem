//
//  BRSSignInViewController.h
//  BRSClient
//
//  Created by 张昊辰 on 15/3/10.
//  Copyright (c) 2015年 minxing. All rights reserved.
//

#import "MDBaseViewController.h"

@interface BRSSignInViewController : MDBaseViewController<UITextFieldDelegate>

@property(nonatomic,assign)int type;
@property(nonatomic,strong)NSString * loseNumber;
@end
