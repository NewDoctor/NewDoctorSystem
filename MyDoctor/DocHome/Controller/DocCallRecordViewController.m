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
    
}
@synthesize tableView = _tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    dataArray=[[NSMutableArray alloc] init];
//    [self postRequest];
     [self TableView];
    if(!_tableView.header.isRefreshing) {
        [_tableView.header beginRefreshing];
    }
    [self postRequest];
    __weak typeof(self) weakSelf = self;
    [_tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf postRequest];
    }];
}

#pragma mark - POST请求
- (void)postRequest
{
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.methodNum = 20301;
    NSString * parameter=[NSString stringWithFormat:@"%@@`%d@`%d@`%d",[MDUserVO userVO].userID,10,0,0];
    model.parameter = parameter;
    model.delegate = self;
    [model starRequest];
    
}
//请求数据回调
-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    //回馈数据
    [dataArray removeAllObjects];
    NSLog(@"电话信息%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dic);
    NSArray * array=[dic objectForKey:@"obj"];
    NSLog(@"%@",array);
    for (int i=0; i<[array count]; i++) {
        DocServiceFolerVO * sfv2=[[DocServiceFolerVO alloc] init];
        sfv2.Id=[array[i] objectForKey:@"id"];
        sfv2.serviceType=@"电话咨询";
        sfv2.serviceStatus=@"已完成";
        sfv2.name=[array[i] objectForKey:@"RealName"];
        sfv2.headImg = [NSString stringWithFormat:@"%@%@",[MDUserVO userVO].photourl,[array[i] objectForKey:@"Photo"]];
        NSLog(@"------------%@",[NSString stringWithFormat:@"%@%@",[MDUserVO userVO].photourl,[array[i] objectForKey:@"Photo"]]);
        sfv2.Time=[array[i] objectForKey:@"ConsultTime"];
        [dataArray addObject:sfv2];
    }
    
    [_tableView reloadData];
    [_tableView.header endRefreshing];
    
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
    [_tableView.header endRefreshing];
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
        cell.serviceType=service.serviceType;
        cell.serviceStatus=service.serviceStatus;
        cell.time=service.Time;
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
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"12" forKey:@"text"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushViewInDocHome" object:nil userInfo:userInfo];
    
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