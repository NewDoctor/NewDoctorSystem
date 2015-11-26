//
//  MDHospitalViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/11/25.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDHospitalViewController.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"

@interface MDHospitalViewController ()

@end

@implementation MDHospitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"社区医院";
    
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
    [self createView];
}

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES
     ];
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createView
{
    UIImageView * topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topImg"]];
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(TOPHEIGHT+18);
        make.left.equalTo(self.view.mas_left).with.offset(15);

    }];

    UIView * whiteView = [[UIView alloc] init];
    [self.view addSubview:whiteView];
    whiteView.backgroundColor = ColorWithRGB(255, 255, 255, 0.7);
    [whiteView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_bottom).with.offset(0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.equalTo(topImageView.mas_width);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-18);
    }];
    
    UILabel * topLab = [[UILabel alloc] init];
    topLab.backgroundColor = [UIColor clearColor];
    topLab.textColor = RedColor;
    topLab.font = [UIFont systemFontOfSize:15];
    topLab.text = @"您可以通过以下方式联系到我:";
    [topLab sizeToFit];
    [whiteView addSubview:topLab];
    
    [topLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(whiteView.mas_top).with.offset(21);
        make.left.equalTo(whiteView.mas_left).with.offset(30);
        make.right.equalTo(whiteView.mas_right).with.offset(-30);
    }];
    
    UILabel * bottomLab = [[UILabel alloc] init];
    bottomLab.backgroundColor = [UIColor clearColor];
    bottomLab.font = [UIFont systemFontOfSize:14];
    bottomLab.numberOfLines = 0;
    bottomLab.text = [NSString stringWithFormat:@"%@\n\n%@",@"1.发送消息，我会第一时间回复您;",@"2.一键呼叫，直接给我拨打电话;"];
    bottomLab.textColor = ColorWithRGB(97, 103, 111, 1);
    [bottomLab sizeToFit];
    [whiteView addSubview:bottomLab];
    [bottomLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(whiteView.mas_left).with.offset(30);
        make.top.equalTo(topLab.mas_bottom).with.offset(30);
    }];
    
    //下方两个按钮的设置
    
    UIButton * consultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    consultBtn.layer.cornerRadius = 2.0;
    consultBtn.layer.masksToBounds = YES;
    [consultBtn setTitle:@"图文咨询" forState:UIControlStateNormal];
    [consultBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [consultBtn setBackgroundColor:RedColor];
    [whiteView addSubview:consultBtn];
    
    UIButton * callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [callBtn setBackgroundColor:RedColor];
    callBtn.layer.cornerRadius = 2.0;
    callBtn.layer.masksToBounds = YES;
    [callBtn setTitle:@"一键呼叫" forState:UIControlStateNormal];
    [callBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [whiteView addSubview:callBtn];

    [consultBtn mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(whiteView.mas_left).with.offset(22);
        make.bottom.equalTo(whiteView.mas_bottom).with.offset(-40);
        make.right.equalTo(callBtn.mas_left).with.offset(-33);
        make.width.equalTo(callBtn.mas_width);
        make.height.equalTo(callBtn.mas_height);
    }];
    
    [callBtn mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(whiteView.mas_right).with.offset(-22);
        make.bottom.equalTo(whiteView.mas_bottom).with.offset(-40);
        make.left.equalTo(callBtn.mas_right).with.offset(33);
        make.width.equalTo(callBtn.mas_width);
        make.height.equalTo(callBtn.mas_height);
    }];
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