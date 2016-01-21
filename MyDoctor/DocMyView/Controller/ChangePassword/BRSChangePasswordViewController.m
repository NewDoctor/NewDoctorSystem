//
//  BRSChangePasswordViewController.m
//  BRSClient
//
//  Created by 张昊辰 on 15/3/17.
//  Copyright (c) 2015年 minxing. All rights reserved.
//

#import "BRSChangePasswordViewController.h"
#import "BRSChangePasswordView.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"
#import "MDRequestModel.h"
#import "MDUserVO.h"


@interface BRSChangePasswordViewController ()<sendInfoToCtr>
{
    BRSChangePasswordView *ChangePasswordView;
    //    WBMoreModel *model;
}
@end

@implementation BRSChangePasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
        //返回按钮点击
        [self.leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView.frame = CGRectMake(0, 0, 220, 44);
    self.navigationItem.title = @"修改密码";
    self.hidesBottomBarWhenPushed = YES;
    
}

- (void)loadView {
    ChangePasswordView = [[BRSChangePasswordView alloc] initWithFrame:appFrame];
    ChangePasswordView.controller = self;
    self.view = ChangePasswordView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)doChange:(NSString *)currentstr andNewPassword:(NSString *)newPassword {
   
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.methodNum = 20101;
    NSString * parameter=[NSString stringWithFormat:@"%@@`%@@`%@", [MDUserVO userVO].userID,currentstr,newPassword];
    model.parameter = parameter;
    model.delegate = self;
    [model starRequest];
    
    
//    MXKit *MXObj = [MXKit shareMXKit];
//    [MXObj changPassword:currentstr withNewPassword:newPassword WithCallback:^(id result,MXError *error){
//        if (result) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"修改成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            [self.navigationController popViewControllerAnimated:YES];
//        }else{
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error.description delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        [ChangePasswordView changeFinishButtonEnabled:YES];
//    }];
//
}
//请求数据回调
-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    //回馈数据
    NSLog(@"登录信息%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dic);
}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
