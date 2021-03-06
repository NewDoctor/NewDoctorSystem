//
//  DocHomeViewController.m
//  
//
//  Created by 张昊辰 on 15/12/7.
//
//

#import "DocHomeViewController.h"
#import "DocUnFinishedViewController.h"
#import "DocFinishedViewController.h"
#import "DocCallRecordViewController.h"
#import "WbToolBarFour.h"
#import "DocRecordViewController.h"
#import "NIDropDown.h"
#import "MainViewController.h"
#import "MDnoticeCenterController.h"

@interface DocHomeViewController ()<NIDropDownDelegate>

@end

@implementation DocHomeViewController
{
    DocUnFinishedViewController * unFinish;
    DocFinishedViewController * finisher;
    DocCallRecordViewController * callRecord;
    WbToolBarFour * bar;
    int firstShow;
    NIDropDown * dropDown;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    firstShow=1;
    self.navigationItem.title=@"医生";
    
//    [self setNavigationBarWithrightBtn:@"通知" leftBtn:@"下拉框"];
    [self setNavigationBarWithrightBtn:@"通知" leftBtn:nil];
    [self.rightBtn addTarget:self action:@selector(noticeClick) forControlEvents:UIControlEventTouchUpInside];

    [self.leftBtn addTarget:self action:@selector(requirBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.width = 80;
    [self.leftBtn setTitle:@"在线" forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushViewInParent:) name:@"pushViewInDocHome" object:nil];
    
    
    if (!bar) {
        bar = [[WbToolBarFour alloc] initWithFrame:CGRectMake(0, 64, appWidth, 40)];
        bar.dataSource = [[NSArray alloc] initWithObjects:@"未完成",@"已完成",@"通话记录", nil];
        bar.delegate = self;
        [bar drawFristRect:CGRectMake(0, 64, appWidth, 40)];
        [self.view addSubview:bar];
    }
    [self draw];

}//通知按钮点击
-(void)noticeClick
{
    MDnoticeCenterController * notice = [[MDnoticeCenterController alloc] init];
    notice.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:notice animated:YES];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pushViewInDocHome" object:nil];
}
-(void)draw
{
    if(!unFinish){
        unFinish=[[DocUnFinishedViewController alloc] init];
        [self.view addSubview:unFinish.view];
    }
    unFinish.view.hidden=NO;
    finisher.view.hidden=YES;
    callRecord.view.hidden=YES;
    if(firstShow==1){
        [self.view bringSubviewToFront:unFinish.view];
        [self.view bringSubviewToFront:bar];
        firstShow=0;
    }
    
}

//-(void)
-(void)requirBtnClick:(id)sender
{
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"在线",@"离线",@"忙碌",nil];
    if(dropDown == nil) {
        CGFloat f = self.leftBtn.height*arr.count;
        dropDown = [[NIDropDown alloc] init];
//        dropDown.isOffset = @"1";
        dropDown.Offset = 22;
        dropDown.font = 14;
        dropDown.textshowStyle = NSTextAlignmentCenter;
        [dropDown showDropDown:sender :&f :arr];
        dropDown.delegate = self;
        
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
    
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    dropDown = nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//标签选择后调用
-(void) elementSelected:(int)index toolBar:(WbToolBarFour*)toolBar
{
    if (index == 0) {
        if(!unFinish){
            unFinish=[[DocUnFinishedViewController alloc] init];
            [self.view addSubview:unFinish.view];
        }
        unFinish.view.hidden=NO;
        finisher.view.hidden=YES;
        callRecord.view.hidden=YES;
        [self.view bringSubviewToFront:unFinish.view];
        [self.view bringSubviewToFront:bar];
    }else if (index==1){
        if (!finisher) {
            finisher=[[DocFinishedViewController alloc] init];
            [self.view addSubview:finisher.view];
        }
        unFinish.view.hidden=YES;
        finisher.view.hidden=NO;
        callRecord.view.hidden=YES;
        [self.view bringSubviewToFront:finisher.view];
        [self.view bringSubviewToFront:bar];
    }
    else if (index==2){
        if (!callRecord) {
            callRecord=[[DocCallRecordViewController alloc] init];
            [self.view addSubview:callRecord.view];
        }
        unFinish.view.hidden=YES;
        finisher.view.hidden=YES;
        callRecord.view.hidden=NO;
        [self.view bringSubviewToFront:callRecord.view];
        [self.view bringSubviewToFront:bar];
    }
}
-(void)pushViewInParent:(id)sender
{
    
    NSString * text= [[sender userInfo] objectForKey:@"text"];
    NSString * text2 = [[sender userInfo] objectForKey:@"text2"];
    if ([text2 isEqualToString:@"线上咨询"]) {
        MainViewController * main=[[MainViewController alloc] init];
        [main networkChanged:eEMConnectionConnected];
        main.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:main animated:YES];
        return;
    }
    if ([text isEqualToString:@"已完成"]) {
        DocRecordViewController * recordVC = [[DocRecordViewController alloc] init];
        recordVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:recordVC animated:YES];
    }
    
  
}


@end
