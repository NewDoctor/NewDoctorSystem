//
//  MDOngoingViewController.m
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/24.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import "MDOngoingViewController.h"
#import "MDServiceFolerVO.h"
#import "MDServiceTableViewCell.h"
#import "MDOrderDetailsViewController.h"

@interface MDOngoingViewController ()

@end

@implementation MDOngoingViewController
{
    NSMutableArray * dataArray;
    
}
@synthesize tableView = _tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self dataArray];
    [self TableView];
    
    
    
}

-(void)dataArray
{
    dataArray=[[NSMutableArray alloc] init];
    
    MDServiceFolerVO * sfv=[[MDServiceFolerVO alloc] init];
    sfv.serviceType=@"照护";
    sfv.serviceName=@"服务名";
    sfv.money=@"15元";
    sfv.nowCondition=@"等待派单";
    sfv.deleteOrCancel=@"删除订单";
    sfv.paymentOrRemind=@"提醒发货";
    
    
    [dataArray addObject:sfv];
    
}

-(void)TableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,104, appWidth, appHeight-64) style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    _tableView.allowsMultipleSelectionDuringEditing = YES;
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    [_tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Cell=@"HeaderCell";
    MDServiceTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell==nil)
    {
        cell=[[MDServiceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    for (UIView *item in cell.contentView.subviews) {
        [item removeFromSuperview];
    }
    if ([dataArray count]>0) {
        MDServiceFolerVO * service=dataArray[indexPath.row];
        cell.serviceType=service.serviceType;
        cell.serviceName=service.serviceName;
        cell.money=service.money;
        cell.nowCondition=service.nowCondition;
        cell.deleteOrCancel=service.deleteOrCancel;
        cell.paymentOrRemind=service.paymentOrRemind;
        
    }
    [cell drawCell];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    MDOrderDetailsViewController * odvc=[[MDOrderDetailsViewController alloc] init];
    [self.navigationController pushViewController:odvc animated:YES];

    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [dataArray count];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
