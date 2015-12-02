//
//  MDLectureViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/11/27.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDLectureViewController.h"

@interface MDLectureViewController ()<UIAlertViewDelegate>

@end

@implementation MDLectureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"专题讲座";
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.leftDownBtn setTitle:@"电话咨询" forState:UIControlStateNormal];
    [self.rightDownBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    
    //  取消继承的点击事件
    [self.rightDownBtn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    
    //添加点击事件
    [self.rightDownBtn addTarget:self action:@selector(orderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self setText];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES
     ];
    
}

-(void)orderBtnClick
{
    UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"预约成功"
                         
                                                  message:nil
                         
                                                 delegate:self
                         
                                        cancelButtonTitle:@"好的"
                         
                                        otherButtonTitles:nil];
    
    [alert show];
}

-(void)setText
{
    UILabel * startTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, appWidth - 48*2, 0)];
    startTimeLab.text = @"讲座开始时间: 2015.04.23 11:00";
    startTimeLab.textAlignment = NSTextAlignmentLeft;
    startTimeLab.font = [UIFont systemFontOfSize:14];
    startTimeLab.textColor = ColorWithRGB(97, 103, 111, 1);
    startTimeLab.numberOfLines = 0;
    [startTimeLab sizeToFit];
    [self.scrollView addSubview:startTimeLab];
    
    UILabel * endTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, startTimeLab.y+startTimeLab.height+21, appWidth - 48*2, 0)];
    endTimeLab.text = @"讲座结束时间: 2015.04.23 12:00";
    endTimeLab.textAlignment = NSTextAlignmentLeft;
    endTimeLab.font = [UIFont systemFontOfSize:14];
    endTimeLab.textColor = ColorWithRGB(97, 103, 111, 1);
    endTimeLab.numberOfLines = 0;
    [endTimeLab sizeToFit];
    [self.scrollView addSubview:endTimeLab];
    
    UILabel * placeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, endTimeLab.y+endTimeLab.height+21, appWidth - 48*2, 0)];
    placeLab.text = @"地点: 天津市南开区鞍山西道风湖里11-1-103";
    placeLab.textAlignment = NSTextAlignmentLeft;
    placeLab.font = [UIFont systemFontOfSize:14];
    placeLab.textColor = ColorWithRGB(97, 103, 111, 1);
    placeLab.numberOfLines = 0;
    [placeLab sizeToFit];
    [self.scrollView addSubview:placeLab];
    
    UILabel * detailsLab = [[UILabel alloc] initWithFrame:CGRectMake(0, placeLab.y+placeLab.height+21, appWidth - 48*2, 0)];
    detailsLab.text = @"内容: 从健康的四大基石（合理膳食、适量运动、戒烟限酒、心理平衡）详细讲解如何保持快乐的心境、老年人常见病的预防保健、用药常识，以及如何适当运动和合理膳食等";
    detailsLab.textAlignment = NSTextAlignmentLeft;
    detailsLab.font = [UIFont systemFontOfSize:14];
    detailsLab.textColor = ColorWithRGB(97, 103, 111, 1);
    detailsLab.numberOfLines = 0;
    [detailsLab sizeToFit];
    [self.scrollView addSubview:detailsLab];
    
    UILabel * telLab = [[UILabel alloc] initWithFrame:CGRectMake(0, detailsLab.y+detailsLab.height+21, detailsLab.width, 0)];
    telLab.text = @"联系电话: 18234092837";
    telLab.textAlignment = NSTextAlignmentLeft;
    telLab.font = [UIFont systemFontOfSize:14];
    telLab.textColor = ColorWithRGB(97, 103, 111, 1);
    telLab.numberOfLines = 0;
    [telLab sizeToFit];
    [self.scrollView addSubview:telLab];

    //设置scrollView内容物大小
    CGFloat scrollViewHeight = 0.0;
    for (UIView* view in self.scrollView.subviews)
    {
        scrollViewHeight += view.frame.size.height;
    }
    [self.scrollView setContentSize:(CGSizeMake(0, scrollViewHeight+21*4+10))];

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
