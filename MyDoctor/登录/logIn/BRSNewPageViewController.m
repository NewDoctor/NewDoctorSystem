//
//  BRSNewPageViewController.m
//  BRSClient
//
//  Created by 张昊辰 on 15/3/18.
//  Copyright (c) 2015年 minxing. All rights reserved.
//

#import "BRSNewPageViewController.h"
#import "BRSlogInViewController.h"
#import "BRSSignInViewController.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"
#import "MDConst.h"
#define autoSizeScaleX  (appWidth>320?appWidth/320:1)
#define autoSizeScaleY  (appHeight>568?appHeight/568:1)
#define T4FontSize (15*autoSizeScaleX)

@interface BRSNewPageViewController ()

@end

@implementation BRSNewPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];//[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-568h"]] ;
    
    [self UIButton];
}


-(void)UIButton
{
    UIImageView * imageView=[[UIImageView alloc] init];
    imageView.image=[UIImage imageNamed:@"newPage@2x"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(appWidth, appHeight));
    }];
    
    UIButton * button=[[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:@"引导-按钮1"] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"马上注册"] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    button.titleLabel.textColor=[UIColor whiteColor];
    [button addTarget:self action:@selector(tunch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton * button1=[[UIButton alloc] init];
    [button1 setBackgroundImage:[UIImage imageNamed:@"引导-按钮2"] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@"引导-按钮1"] forState:UIControlStateHighlighted];
    [button1 setTitle:[NSString stringWithFormat:@"登    录"] forState:UIControlStateNormal];
    button1.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    button1.titleLabel.textColor=[UIColor whiteColor];
    [button1 addTarget:self action:@selector(tunch1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    UILabel * label=[[UILabel alloc] init];
    label.text=@"已经注册了名片账号？";
    label.textAlignment = NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:T4FontSize];
    label.textColor=[UIColor whiteColor];
    [self.view addSubview:label];
    [button mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-140);
        make.size.mas_equalTo(CGSizeMake(210, 40));
    }];
    [label mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-100);
        make.size.mas_equalTo(CGSizeMake(appWidth, 30));
    }];
    [button1 mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-50);
        make.size.mas_equalTo(CGSizeMake(210, 40));
    }];
}
-(void)tunch:(UIButton *)tunch
{
    NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
    [stdDefault setObject:[NSString stringWithFormat:@"%d",1] forKey:@"NEWTime"];
    BRSSignInViewController * siv=[[BRSSignInViewController alloc] init];
    [self.navigationController pushViewController:siv animated:YES];
}
-(void)tunch1:(UIButton *)tunch
{
    NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
    [stdDefault setObject:[NSString stringWithFormat:@"%d",1] forKey:@"NEWTime"];
    BRSlogInViewController * siv=[[BRSlogInViewController alloc] init];
    [self.navigationController pushViewController:siv animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
