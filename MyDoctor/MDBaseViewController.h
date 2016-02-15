//
//  ViewController.h
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/23.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDConst.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"
#import "UIView+ViewExtension.h"
#import "BRSSysUtil.h"

@interface MDBaseViewController : UIViewController

@property (nonatomic,strong) UIButton * leftBtn;
@property (nonatomic,strong) UIButton * rightBtn;

-(void)setNavigationBarWithrightBtn:(NSString *)rightBtnTitle leftBtn:(NSString *)leftBtnImg;
+(BOOL)checkNetWork;
@end

