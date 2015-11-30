//
//  MDActivityViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/11/25.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDActivityViewController.h"
#import "activityCell.h"
#import "MDExpertConsultationViewController.h"
#import "MDLectureViewController.h"

@interface MDActivityViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataList;
    UIView * _headerView;
}

@end

@implementation MDActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"活动";
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self createHeaderView];
    
    [self createTableView];
    // Do any additional setup after loading the view.
}

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES
     ];
}

-(void)createHeaderView
{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth - 42, 60.0/69.0*(appWidth - 42))];
    _headerView.backgroundColor = ColorWithRGB(255, 255, 255, 0.7);
    //专家详情View设置
    UIImageView * headView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"专家头像"]];
    headView.backgroundColor = RedColor;
    headView.contentMode = UIViewContentModeScaleAspectFill;
    [_headerView addSubview:headView];
    
    [headView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_headerView.mas_centerX);
        make.top.equalTo(_headerView.mas_top).with.offset(20);
        make.height.equalTo(@(60.0/69.0*(appWidth - 42)/2));
    }];
    
    UILabel * detailsLab = [[UILabel alloc] init];
    detailsLab.text = @"专家详情";
    detailsLab.textColor = RedColor;
    [_headerView addSubview:detailsLab];
    
    [detailsLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_headerView.mas_centerX);
        make.height.equalTo(@(18));
        make.top.equalTo(headView.mas_bottom).with.offset(20);
    }];
    
    UILabel * nameLab = [[UILabel alloc] init];
    nameLab.text = @"姓名:张起灵";
    nameLab.font = [UIFont systemFontOfSize:14];
    [nameLab sizeToFit];
    nameLab.textAlignment = NSTextAlignmentLeft;
    nameLab.textColor = ColorWithRGB(97, 103, 111, 1);
    [_headerView addSubview:nameLab];
    
    UILabel * rankLab = [[UILabel alloc] init];
    rankLab.text = @"级别:副主任医师";
    rankLab.font = [UIFont systemFontOfSize:14];
    rankLab.textAlignment = NSTextAlignmentLeft;
    rankLab.textColor = ColorWithRGB(97, 103, 111, 1);
    [_headerView addSubview:rankLab];
    
    UILabel * classifyLab = [[UILabel alloc] init];
    classifyLab.text = @"科别:肠胃科";
    classifyLab.font = [UIFont systemFontOfSize:14];
    classifyLab.textAlignment = NSTextAlignmentLeft;
    classifyLab.textColor = ColorWithRGB(97, 103, 111, 1);
    [_headerView addSubview:classifyLab];
    
    [nameLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(detailsLab.mas_bottom).with.offset(8);
        make.left.equalTo(headView.mas_left);
        make.height.equalTo(rankLab);
    }];
    
    [rankLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(nameLab.mas_bottom).with.offset(8);
        make.left.equalTo(headView.mas_left);
        make.height.equalTo(nameLab);
        
    }];
    
    [classifyLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(rankLab.mas_bottom).with.offset(8);
        make.left.equalTo(headView.mas_left);
        make.height.equalTo(rankLab);
        make.bottom.equalTo(_headerView.mas_bottom).with.offset(-8);
    }];
    
    //分割线
    UIView * wireViewLeft = [[UIView alloc] init];
    wireViewLeft.backgroundColor = RedColor;
    UIView * wireViewRirght = [[UIView alloc] init];
    wireViewRirght.backgroundColor = RedColor;
    [_headerView addSubview:wireViewLeft];
    [_headerView addSubview:wireViewRirght];
    
    [wireViewLeft mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(_headerView.mas_left).with.offset(40);
        make.right.equalTo(detailsLab.mas_left).with.offset(-25);
        make.centerY.mas_equalTo(detailsLab.mas_centerY);
        make.height.equalTo(@1);
    }];
    
    [wireViewRirght mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(_headerView.mas_right).with.offset(-40);
        make.left.equalTo(detailsLab.mas_right).with.offset(25);
        make.centerY.mas_equalTo(detailsLab.mas_centerY);
        make.height.equalTo(@1);
    }];


}

-(void)createTableView
{
    
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(21,18, appWidth - 42, appHeight-20) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource  =self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"activityCell" bundle:nil] forCellReuseIdentifier:@"iden"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 协议方法

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    _tableView.tableHeaderView = _headerView;
    [_tableView sendSubviewToBack:_headerView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160.0/690.0*(appWidth - 42)+15;
//    return 103;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * iden = @"iden";
    activityCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[activityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    cell.textLabel.text = @"11";
    return cell;
}

//填充每个cell间距的view，使之透明
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MDExpertConsultationViewController * expertVC = [[MDExpertConsultationViewController alloc] init];
        expertVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:expertVC animated:YES];
    }
    else if (indexPath.section == 1)
    {
        MDLectureViewController * lectureVC = [[MDLectureViewController alloc] init];
        lectureVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:lectureVC animated:YES];
    }

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
