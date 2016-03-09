//
//  DocLookAfterViewController.m
//  
//
//  Created by 张昊辰 on 15/12/7.
//
//

#import "DocCallRecordViewController.h"
#import "DocServiceFolerVO.h"
#import "DocHomeTableViewCell.h"
#import "MDRequestModel.h"
#import "MJRefresh.h"

@interface DocCallRecordViewController ()<sendInfoToCtr>

@end

@implementation DocCallRecordViewController
{
    NSMutableArray * dataArray;
    int curruntPage;
}
@synthesize tableView = _tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    curruntPage=1;
    dataArray=[[NSMutableArray alloc] init];
//    [self postRequest];
    [self TableView];
    [self refreshAndLoad];
}
-(void)refreshAndLoad
{
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        curruntPage = 1;
        [weakSelf postRequest];
    }];
    
    // 马上进入刷新状态
    [_tableView.mj_header beginRefreshing];
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        curruntPage ++;
        [weakSelf postRequest];
    }];
    
}

#pragma mark - POST请求
- (void)postRequest
{
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.methodNum = 20301;
    NSString * pageSize = @"10";
    int pageIndex = curruntPage;
    NSString * lastID = @"0";
    
    NSString * parameter=[NSString stringWithFormat:@"%@@`%@@`%d@`%@",[MDUserVO userVO].userID,pageSize,pageIndex,lastID];
    model.parameter = parameter;
    model.delegate = self;
    [model starRequest];
    
}
//请求数据回调
-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    //回馈数据
    if (curruntPage == 1) {
        [dataArray removeAllObjects];
    }
    NSLog(@"电话信息%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dic);
    NSArray * array=[dic objectForKey:@"obj"];
    NSLog(@"%@",array);
    for (int i=0; i<[array count]; i++) {
        DocServiceFolerVO * sfv2=[[DocServiceFolerVO alloc] init];
        sfv2.id=[array[i] objectForKey:@"id"];
        sfv2.CareInfoName=@"电话咨询";
        sfv2.OrderType=@"已完成";
        sfv2.Phone=[array[i] objectForKey:@"Phone"];
        sfv2.name=[array[i] objectForKey:@"RealName"];
        sfv2.headImg = [NSString stringWithFormat:@"%@%@",[MDUserVO userVO].photourl,[array[i] objectForKey:@"Photo"]];
        NSLog(@"------------%@",[NSString stringWithFormat:@"%@%@",[MDUserVO userVO].photourl,[array[i] objectForKey:@"Photo"]]);
        sfv2.CreateTime=[array[i] objectForKey:@"ConsultTime"];
        [dataArray addObject:sfv2];
    }
    
    [_tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)TableView
{
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,104, appWidth, appHeight-104-49) style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1];
    _tableView.backgroundColor=[UIColor clearColor];
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
    DocHomeTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell==nil)
    {
        cell=[[DocHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    cell.backgroundColor=[UIColor clearColor];
    for (UIView *item in cell.contentView.subviews) {
        [item removeFromSuperview];
    }
    if ([dataArray count]>0) {
        DocServiceFolerVO * service=dataArray[indexPath.row];
        cell.name=service.name;
        cell.serviceType=service.CareInfoName;
        cell.serviceStatus=service.OrderType;
        cell.time=service.CreateTime;
        cell.headImg =service.headImg;
    }
    [cell drawCell];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    // 带字典的通知
//    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"12" forKey:@"text"];
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushViewInDocHome" object:nil userInfo:userInfo];
    DocServiceFolerVO * service=dataArray[indexPath.row];
    NSString * phoneNum = [NSString stringWithFormat:@"tel:%@",service.Phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNum]];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [dataArray count];
    
}



@end